OPTIMIZED :: true;
BUILD_WASM :: true;
BUILD_NATIVE :: false;

WASM_INSERTION_STRING :: #string DONE

SHADER_RENDER_BASIC :: #string WGSL
%1;
WGSL

SHADER_RENDER_RAYMARCHING :: #string WGSL
%2;
WGSL

DONE



#load "scene/shaders/shaders.jai";



#run {
	checkbox_wasm   := ifx BUILD_WASM then "x" else " ";
	checkbox_native := ifx BUILD_NATIVE then "x" else " ";
	print("Building:\n");
	print("WASM:    [%]\n", checkbox_wasm);
	print("NATIVE:  [%]\n", checkbox_native);
	print("\n");
	set_build_options_dc(.{do_output = false});

	add_shaders :: (w: *Workspace) {
		SHADER :: #run create_shaders();
		build_string := sprint(WASM_INSERTION_STRING,
			SHADER.render_basic,
			SHADER.render_raymarching,
		);
		add_build_string(build_string, <<w);
	}

	if ( BUILD_WASM ) {
		w := compiler_create_workspace("Wasm Common");
		options := get_build_options(w);
		args := options.compile_time_command_line;
		// we ensure that the jails vscode extension does not generate the same output,
		// as this would generate an invalid build.
		jails_diagnostics := array_find(args, "jails_diagnostics");
		copy_commonly_propagated_fields(get_build_options(), *options);

		options.output_type                         = .EXECUTABLE;
		options.backend                             = .LLVM; // WASM only works with the LLVM backend, obviously.
		options.os_target                           = .WASM;
		options.cpu_target                          = .CUSTOM;
		options.emit_debug_info                     = .DWARF;
		options.backtrace_on_crash                  = .OFF; // Runtime_Support_Crash_Handler doesn’t support WASM (yet?)
		options.output_path                         = "../../public/";
		options.output_executable_name              = ifx jails_diagnostics then "jails" else "polygon-next";
		options.llvm_options.target_system_features = "+bulk-memory"; // "This options is needed so that "memcpy" and "memset" are mapped to "memory.copy" and "memory.fill" instructions in WASM.
		options.llvm_options.enable_split_modules   = false;
		options.llvm_options.function_sections      = true; // To get around "LLVM ERROR: section already has a defining function: .text"
		options.dead_code_elimination				= .MODULES_ONLY;

		if OPTIMIZED {
			set_optimization(*options, .VERY_OPTIMIZED);
		} else {
			set_optimization(*options, .VERY_DEBUG);
		}

		import_paths: [..]string;
		// Add our own modules folder first so that we can override modules with our own version, if necessary.
		array_add(*import_paths, tprint("%modules", #filepath));
		for options.import_path array_add(*import_paths, it);
		options.import_path = import_paths;

		// This was compiled from https://github.com/wingo/walloc via "clang -Oz --target=wasm64 -nostdlib -c -o walloc.o walloc.c".
		// We should probably port this allocator to Jai instead…
		//  -rluba, 2023-11-15
		walloc_object_file_path := "modules/walloc/walloc.o";
		EMSDK_PATH :: "/home/gui/work/web/games/emsdk";

		STACK_SIZE :: 4 * 1024 * 1024;
		options.additional_linker_arguments = .[
			"--stack-first",
			"-z",
			tprint("stack-size=%", STACK_SIZE),
			walloc_object_file_path,
			// tprint("-L%/upstream/lib", EMSDK_PATH)
			tprint("-L%/upstream/emscripten/cache/sysroot/lib/wasm64-emscripten/", EMSDK_PATH)
		];

		set_build_options(options, w);

		// Replace the default allocator with Walloc (https://github.com/wingo/walloc).
		remap_import(w, "*", "Default_Allocator", "walloc");

		compiler_begin_intercept(w);

		add_build_file("main.jai", w);

		generated_code := false;
		while true {
			message := compiler_wait_for_message();
			if message.kind == {
				case .TYPECHECKED;
					update_procedures(message);
				case .PHASE;
					phase := cast(*Message_Phase) message;
						// print("phase:%.\n", phase.phase);
					if phase.phase == .TYPECHECKED_ALL_WE_CAN {
						if !generated_code {

							add_shaders(*w);
							add_build_string("WASM :: true;", w);
							generated_code = true;
						}
					}

				case .COMPLETE;
					break;
			}
		}

		compiler_end_intercept(w);
	}
	if ( BUILD_NATIVE ) {
		w := compiler_create_workspace("Native Common");

		options := get_build_options(w);
		args := options.compile_time_command_line;
		// we ensure that the jails vscode extension does not generate the same output,
		// as this would generate an invalid build.
		jails_diagnostics := array_find(args, "jails_diagnostics");
		options.output_path = "../../bin/";
		make_directory_if_it_does_not_exist(options.output_path);
		options.output_executable_name = ifx jails_diagnostics then "jails" else "polygon-next";

		if OPTIMIZED {
			set_optimization(*options, .VERY_OPTIMIZED);
		} else {
			set_optimization(*options, .VERY_DEBUG);
			if OS == .LINUX {
				options.backend = .X64;
			}
		}

		set_build_options(options, w);

		compiler_begin_intercept(w);

		add_build_file("main.jai", w);

		generated_code := false;
		while true {
			message := compiler_wait_for_message();
			if message.kind == {
				case .TYPECHECKED;
					update_procedures(message);
				case .PHASE;
					phase := cast(*Message_Phase) message;
					if phase.phase == .TYPECHECKED_ALL_WE_CAN {
						if !generated_code {

							add_shaders(*w);
							add_build_string("WASM :: false;", w);
							generated_code = true;
						}
					}

				case .COMPLETE;
					break;
			}
		}

		compiler_end_intercept(w);
	}
}

update_procedures :: (message: *Message) {
	typechecked := cast(*Message_Typechecked) message;
	for tc: typechecked.procedure_bodies {
		body := tc.expression;
		if body.body_flags & .ALREADY_MODIFIED continue;

		assert(body.block != null);
		if(body.header.name == "import_shader"){
			code_literal := cast(*Code_Literal) tc.subexpressions[0];
			shader_file_name := code_literal.values._string;
			jai_file_path := code_literal.location.enclosing_load.fully_pathed_filename;
			path_elements := split(jai_file_path, "/");
			path := parse_path(jai_file_path, reduce=true);
			path.words[path.words.count-1] = shader_file_name;
			shader_file_path := path_to_string(path);
			shader_raw := read_shader_file_with_include(shader_file_path);

			new_statements : [..] *Code_Node;
			array_add(*new_statements, make_return_statement(make_string_literal(shader_raw)));

			body.block.statements = new_statements;
			compiler_modify_procedure(message.workspace, body);
		}
	}
}

SHADER_INCLUDE_START :: "// include ";
read_shader_file_with_include :: (file_path:string)->string {
	lines:[..]string;
	handlers:[..]Text_File_Handler;
	defer array_reset(*lines);
	add_file_lines(*lines, file_path, *handlers);

	content := join(..lines,"\n");

	for handlers deinit(*it);

	return content;
}
add_file_lines :: (lines:*[..]string, file_path: string, handlers:*[..]Text_File_Handler){
	handler: Text_File_Handler;
	handler.do_version_number = false;
	array_add(handlers, handler);

	short_name := "example_data";
	start_file(*handler, short_name, file_path, false);
	assert(handler.failed==false, tprint("failed to parse include chunk '%'", file_path));

	while true {
		line, found := consume_next_line(*handler);
		if !found break;
		if(begins_with(line, SHADER_INCLUDE_START)){
			include_file_name := slice(line, SHADER_INCLUDE_START.count, line.count-1);
			include_file_path := tprint("%../shaders/common/%.wgsl", #filepath, include_file_name);
			print("include_file_path:%,%\n", include_file_name, include_file_path);
			add_file_lines(lines, include_file_path, handlers);
		} else {
			array_add(lines, line);
		}
	}
}

make_return_statement :: (expression: *Code_Node) -> *Code_Return {
	ret := New(Code_Return);
	ret.kind = .RETURN;

	arguments_unsorted: [..] Code_Argument;

	arg: Code_Argument;
	arg.expression = expression;
	arg.name = null;

	array_add(*arguments_unsorted, arg);
	ret.arguments_unsorted = arguments_unsorted;

	arguments_sorted: [..] *Code_Node;
	array_add(*arguments_sorted, expression);
	ret.arguments_sorted = arguments_sorted;

	return ret;
}



#import "Basic";
#import "Compiler";
#import "File";
#import "File_Utilities";
#import "String";
#import "Text_File_Handler";
// #import "System";





#run {
	versionInfo: Version_Info;
	compiler_get_version_info(*versionInfo);
	VERSION_ERROR_MESSAGE :: "requires jai version 0.2.4";
	assert(versionInfo.major == 0, VERSION_ERROR_MESSAGE);
	assert(versionInfo.minor == 2, VERSION_ERROR_MESSAGE);
	assert(versionInfo.micro == 4, VERSION_ERROR_MESSAGE);

	build_log_builder: String_Builder;
	set_build_options_dc(.{do_output = false});

	{
		w := compiler_create_workspace("Wasm");
		options := get_build_options(w);

		buildArgs := getArgs(*options);
		print_to_builder(*build_log_builder, tprint("WASM:        [%]\n", _checkbox(buildArgs.wasm)));
		print_to_builder(*build_log_builder, tprint("DEBUGGER:    [%]\n", _checkbox(buildArgs.debugger)));
		if(buildArgs.wasm){
			copy_commonly_propagated_fields(get_build_options(), *options);

			options.output_type                         = .EXECUTABLE;
			options.backend                             = .LLVM; // WASM only works with the LLVM backend, obviously.
			options.os_target                           = .WASM;
			options.cpu_target                          = .CUSTOM;
			options.emit_debug_info                     = .DWARF;
			options.backtrace_on_crash                  = .OFF; // Runtime_Support_Crash_Handler doesn’t support WASM (yet?)
			options.output_path                         = "../../public/";
			options.output_executable_name              = ifx buildArgs.jailsDiagnostics then "jails" else "polygon-next";
			options.llvm_options.target_system_features = "+bulk-memory"; // "This options is needed so that "memcpy" and "memset" are mapped to "memory.copy" and "memory.fill" instructions in WASM.
			options.llvm_options.enable_split_modules   = false;
			options.llvm_options.function_sections      = true; // To get around "LLVM ERROR: section already has a defining function: .text"
			options.dead_code_elimination				= .MODULES_ONLY;

			setOptimisation(*options, *buildArgs, wasm=true);


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

			STACK_SIZE :: 512 * 1024 * 1024;
			// STACK_SIZE :: 65 * 1024;
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

			add_build_string("FREE_MEMORY_DEBUG :: false; #load \"main.jai\";", w);
			listen_to_compiler_messages(w, wasm=buildArgs.wasm, test=buildArgs.test);

			compiler_end_intercept(w);
		}
	}
	{
		w := compiler_create_workspace("Native");

		options := get_build_options(w);
		buildArgs := getArgs(*options);
		print_to_builder(*build_log_builder, tprint("NATIVE:      [%]\n", _checkbox(buildArgs.native)));
		print_to_builder(*build_log_builder, tprint("RUN_TESTS:   [%]\n", _checkbox(buildArgs.test)));
		print_to_builder(*build_log_builder, tprint("DEBUGGER:    [%]\n", _checkbox(buildArgs.debugger)));
		print_to_builder(*build_log_builder, tprint("OPTIMIZED:   [%]\n", _checkbox(buildArgs.optimized)));
		if(buildArgs.native) {
			options.output_path = "../../bin/";
			make_directory_if_it_does_not_exist(options.output_path);
			options.output_executable_name = ifx buildArgs.jailsDiagnostics then "jails" else "polygon-next";

			setOptimisation(*options, *buildArgs, wasm=false);

			set_build_options(options, w);

			compiler_begin_intercept(w);

			add_build_string(tprint("FREE_MEMORY_DEBUG :: %; #load \"main.jai\";", buildArgs.test), w);
			listen_to_compiler_messages(w, wasm=buildArgs.wasm, test=buildArgs.test);

			compiler_end_intercept(w);
		}

	}

	print("\n");
	build_log :string= builder_to_string(*build_log_builder);
	print("\n");
	print("%\n", build_log);
	print("\n");
}


listen_to_compiler_messages :: (w: Workspace, wasm:bool, test:bool) {

	generated_code := false;
	count := 0;
	while true {
		message := compiler_wait_for_message();
		if message.kind == {
			case .TYPECHECKED;{
				update_procedures(message);
			}
			case .PHASE;
				messagePhase := cast(*Message_Phase) message;
				if messagePhase.phase == .TYPECHECKED_ALL_WE_CAN {
					if !generated_code {
						add_build_string(tprint("WASM :: %;", wasm), w);
						add_build_string(tprint("RUN_TESTS :: %;", test), w);
						generated_code = true;
					}
				}

			case .COMPLETE;
				break;
		}
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

BuildArgs :: struct {
	wasm:bool;
	native:bool;
	jailsDiagnostics: bool;
	test:bool;
	optimized:bool;
	debugger:bool;
	// all:[..]string;
}
getArgs :: (options: *Build_Options)->BuildArgs {
	buildArgs: BuildArgs;
	args := options.compile_time_command_line;
	// we ensure that the jails vscode extension does not generate the same output,
	// as this would generate an invalid build.
	buildArgs.jailsDiagnostics = array_find(args, "jails_diagnostics");
	buildArgs.test = array_find(args, "test");
	buildArgs.wasm = array_find(args, "wasm");
	buildArgs.native = array_find(args, "native");
	buildArgs.debugger = array_find(args, "debugger");
	buildArgs.optimized = array_find(args, "O");
	if( buildArgs.wasm==false && buildArgs.native==false ) {
		buildArgs.wasm = true;
		buildArgs.native = true;
	}

	// array_resize(*COMPILE_TIME_ARGS, args.count);
	// for arg, i: args {
	// 	COMPILE_TIME_ARGS[i] = arg;
	// }

	return buildArgs;
}
setOptimisation :: (options: *Build_Options, buildArgs: *BuildArgs, wasm:bool) {
	if buildArgs.optimized {
		set_optimization(options, .VERY_OPTIMIZED); // OPTIMIZED_VERY_SMALL
	} else {
		set_optimization(options, .VERY_DEBUG);
		if wasm == false && OS == .LINUX {
			options.backend = .X64;
		}
	}
	if buildArgs.debugger {
		options.interactive_bytecode_debugger = true;
	}
}
_checkbox :: (status:bool)->string {
	return ifx status then "x" else " ";
}


#import "Basic";
#import "Compiler";
#import "File";
#import "File_Utilities";
#import "String";
#import "Text_File_Handler";

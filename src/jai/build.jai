// This example compiles a Jai program into WASM64.
// After compiling first.jai, you can view it in your browser by serving the "public" folder via a web server of your choice.
// (Just opening index.html directly from your file system will not work because the browser can’t fetch the WASM file from there.)
//
// Since Jai currently only supports compiling to WASM64 (i.e. it requires the "Memory64" extension), you need to enable that feature flag in your browser.
// See https://webassembly.org/roadmap/ for where "Memory64" is available and how you can enable it.

// Thanks to Alexey Kutepov (Tsoding/rexim), Patrik Smělý (SogoCZE), and KujuKuju for laying the groundwork
// for this by figuring out how to use Jai for WASM.

WASM_INSERTION_STRING :: #string DONE

SHADER :: #string WGSL
%1;
WGSL

DONE

#load "native/shaders.jai";


#run {
	set_build_options_dc(.{do_output = false});

	{
		w := compiler_create_workspace("Wasm");

		options := get_build_options(w);
		copy_commonly_propagated_fields(get_build_options(), *options);

		options.output_type                         = .EXECUTABLE;
		options.backend                             = .LLVM; // WASM only works with the LLVM backend, obviously.
		options.os_target                           = .WASM;
		options.cpu_target                          = .CUSTOM;
		options.emit_debug_info                     = .DWARF;
		options.backtrace_on_crash                  = .OFF; // Runtime_Support_Crash_Handler doesn’t support WASM (yet?)
		options.output_path                         = "../../public/";
		options.output_executable_name              = "polygon-next";
		options.llvm_options.target_system_features = "+bulk-memory"; // "This options is needed so that "memcpy" and "memset" are mapped to "memory.copy" and "memory.fill" instructions in WASM.
		options.llvm_options.enable_split_modules   = false;
		options.llvm_options.function_sections      = true; // To get around "LLVM ERROR: section already has a defining function: .text"
		options.dead_code_elimination				= .MODULES_ONLY;

		import_paths: [..]string;
		// Add our own modules folder first so that we can override modules with our own version, if necessary.
		array_add(*import_paths, tprint("%modules", #filepath));
		for options.import_path array_add(*import_paths, it);
		options.import_path = import_paths;

		// This was compiled from https://github.com/wingo/walloc via "clang -Oz --target=wasm64 -nostdlib -c -o walloc.o walloc.c".
		// We should probably port this allocator to Jai instead…
		//  -rluba, 2023-11-15
		walloc_object_file_path := "modules/walloc/walloc.o";

		STACK_SIZE :: 64 * 1024;
		options.additional_linker_arguments = .["--stack-first", "-z", tprint("stack-size=%", STACK_SIZE), walloc_object_file_path];

		set_build_options(options, w);

		// Replace the default allocator with Walloc (https://github.com/wingo/walloc).
		remap_import(w, "*", "Default_Allocator", "walloc");

		compiler_begin_intercept(w);

		add_build_file("main_wasm.jai", w);

		generated_code := false;
		while true {
			message := compiler_wait_for_message();
			if message.kind == {
				case .TYPECHECKED;
					typechecked := cast(*Message_Typechecked) message;
					for body: typechecked.procedure_bodies {
						header := body.expression.header;
						// You could replace individual procedure bodies here, if you needed to.
					}
				case .PHASE;
					phase := cast(*Message_Phase) message;
					if phase.phase == .TYPECHECKED_ALL_WE_CAN {
						if !generated_code {
							SHADER :: #run create_shaders();
							build_string := sprint(WASM_INSERTION_STRING, SHADER);
							add_build_string(build_string, w);
							generated_code = true;
						}
					}

				case .COMPLETE;
					break;
			}
		}

		compiler_end_intercept(w);
	}
	{
		w := compiler_create_workspace("Native");
		options := get_build_options(w);
		options.output_path = "../../bin/";
		make_directory_if_it_does_not_exist(options.output_path);
		options.output_executable_name = "polygon-next-native";
		set_build_options(options, w);
		add_build_file("main_native.jai", w);
	}
}

#import "Basic";
#import "Compiler";
#import "File";
// #import "String";
// #import "System";

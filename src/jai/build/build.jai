build :: () #compile_time {

	buildValidateJaiVersion();

	build_log_builder: String_Builder;
	set_build_options_dc(.{do_output = false});

	{
		w := compiler_create_workspace("Wasm");
		options := get_build_options(w);

		buildArgs := getArgs(*options);
		if(buildArgs.wasm){
			buildWasm(w, *options, *buildArgs);
		}
	}
	{
		w := compiler_create_workspace("Native");

		options := get_build_options(w);
		buildArgs := getArgs(*options);
		if(buildArgs.native) {
			buildNative(w, *options, *buildArgs);
		}

		print_to_builder(*build_log_builder, tprint("WASM:          [%]\n", _checkbox(buildArgs.wasm)));
		print_to_builder(*build_log_builder, tprint("DEBUGGER:      [%]\n", _checkbox(buildArgs.debugger)));
		print_to_builder(*build_log_builder, tprint("NATIVE:        [%]\n", _checkbox(buildArgs.native)));
		print_to_builder(*build_log_builder, tprint("RUN_TESTS:     [%]\n", _checkbox(buildArgs.test)));
		print_to_builder(*build_log_builder, tprint("DEBUGGER:      [%]\n", _checkbox(buildArgs.debugger)));
		print_to_builder(*build_log_builder, tprint("OPTIMIZED:     [%]\n", _checkbox(buildArgs.optimized)));
		print_to_builder(*build_log_builder, tprint("SKIP_MEM_TEST: [%]\n", _checkbox(buildArgs.skipmemtest)));
		print_to_builder(*build_log_builder, tprint("NO_BULK_MEM:   [%]\n", _checkbox(buildArgs.no_bulk_mem)));
		print_to_builder(*build_log_builder, tprint("EMPTY_MAIN:    [%]\n", _checkbox(buildArgs.empty_main)));
		print("\n");
		build_log :string= builder_to_string(*build_log_builder);
		print("\n");
		print("%\n", build_log);
		print("\n");

	}

}

#run build();

#import "Basic";
#import "Compiler";
#import "File";
#import "File_Utilities";
#import "String";
#import "Hash_Table";
#import "Text_File_Handler";

#load "_index.jai";
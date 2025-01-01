build :: () #compile_time {
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
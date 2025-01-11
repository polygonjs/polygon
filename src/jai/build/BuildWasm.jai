buildWasm :: (w: Workspace, options: *Build_Options, buildArgs: *BuildArgs) {
	copy_commonly_propagated_fields(get_build_options(), options);

	options.output_type                         = .EXECUTABLE;
	options.backend                             = .LLVM; // WASM only works with the LLVM backend, obviously.
	options.os_target                           = .WASM;
	options.cpu_target                          = .CUSTOM;
	options.emit_debug_info                     = .DWARF;
	options.backtrace_on_crash                  = .OFF; // Runtime_Support_Crash_Handler doesn’t support WASM (yet?)
	options.output_path                         = "../../../public/";
	options.output_executable_name              = ifx buildArgs.jailsDiagnostics then "jails" else "polygon-next";
	#if #exists(JAILS_DIAGNOSTICS_BUILD) options.output_type = .NO_OUTPUT;
	options.llvm_options.target_system_features = "+bulk-memory"; // "This options is needed so that "memcpy" and "memset" are mapped to "memory.copy" and "memory.fill" instructions in WASM.
	options.llvm_options.enable_split_modules   = false;
	options.llvm_options.function_sections      = true; // To get around "LLVM ERROR: section already has a defining function: .text"
	options.dead_code_elimination				= .MODULES_ONLY;

	setOptimisation(options, buildArgs, wasm=true);


	import_paths: [..]string;
	// Add our own modules folder first so that we can override modules with our own version, if necessary.
	array_add(*import_paths, tprint("%/../modules", #filepath));
	for options.import_path array_add(*import_paths, it);
	options.import_path = import_paths;

	// This was compiled from https://github.com/wingo/walloc via "clang -Oz --target=wasm64 -nostdlib -c -o walloc.o walloc.c".
	// We should probably port this allocator to Jai instead…
	//  -rluba, 2023-11-15
	walloc_object_file_path := "../modules/walloc/walloc.o";
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

	add_build_string("FREE_MEMORY_DEBUG :: false; SKIP_MEM_TEST :: false; #load \"../main.jai\";", w);
	listen_to_compiler_messages(w, wasm=buildArgs.wasm, test=buildArgs.test);

	compiler_end_intercept(w);
}
buildNative :: (w: Workspace, options: *Build_Options, buildArgs: *BuildArgs) {
	options.output_path = "../../../bin/";
	make_directory_if_it_does_not_exist(options.output_path);
	options.output_executable_name = ifx buildArgs.jailsDiagnostics then "jails" else "polygon-next";
	#if #exists(JAILS_DIAGNOSTICS_BUILD) options.output_type = .NO_OUTPUT;

	setOptimisation(options, buildArgs, wasm=false);

	import_paths: [..]string;
	// Add our own modules folder first so that we can override modules with our own version, if necessary.
	array_add(*import_paths, tprint("%/../modules", #filepath));
	for options.import_path array_add(*import_paths, it);
	options.import_path = import_paths;

	set_build_options(options, w);

	compiler_begin_intercept(w);

	add_build_string(tprint("FREE_MEMORY_DEBUG :: %; SKIP_MEM_TEST :: %; #load \"../main.jai\";", buildArgs.test && !buildArgs.skipmemtest, buildArgs.skipmemtest), w);
	listen_to_compiler_messages(w, wasm=buildArgs.wasm, test=buildArgs.test);

	compiler_end_intercept(w);
}
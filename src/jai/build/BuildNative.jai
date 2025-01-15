buildNative :: (w: Workspace, options: *Build_Options, buildArgs: *BuildArgs) {
	options.output_path = "../../../bin/";
	make_directory_if_it_does_not_exist(options.output_path);
	options.output_executable_name = ifx buildArgs.jailsDiagnostics then "jails" else "polygon-next";
	#if #exists(JAILS_DIAGNOSTICS_BUILD) options.output_type = .NO_OUTPUT;

	updateBuildOptions(options, buildArgs, wasm=false);

	import_paths: [..]string;
	// Add our own modules folder first so that we can override modules with our own version, if necessary.
	array_add(*import_paths, tprint("%/../modules", #filepath));
	for options.import_path array_add(*import_paths, it);
	options.import_path = import_paths;

	set_build_options(options, w);

	compiler_begin_intercept(w);

	// freeMemory := tprint("FREE_MEMORY_DEBUG :: %;", buildArgs.test && !buildArgs.skipmemtest);
	// skipMemTest := tprint("SKIP_MEM_TEST :: %;", buildArgs.skipmemtest);
	// sceneOnly := tprint("SCENE_ONLY :: %;", buildArgs.sceneOnly);
	globalVars := buildGlobals(.{
		freeMemory = buildArgs.test && !buildArgs.skipmemtest,
		skipMemTest = buildArgs.skipmemtest,
		useEditor = buildArgs.noEditor==false
	});
	buildString := tprint("% #load \"../main.jai\";", globalVars);
	// print("buildString (native):%\n", buildString);
	add_build_string(buildString, w);
	listen_to_compiler_messages(w, wasm=buildArgs.wasm, test=buildArgs.test);

	compiler_end_intercept(w);
}
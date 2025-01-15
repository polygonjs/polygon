updateBuildOptions :: (options: *Build_Options, buildArgs: *BuildArgs, wasm:bool) {
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
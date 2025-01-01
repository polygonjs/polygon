
BuildArgs :: struct {
	wasm:bool;
	native:bool;
	jailsDiagnostics: bool;
	test:bool;
	optimized:bool;
	debugger:bool;
	skipmemtest:bool;
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
	buildArgs.skipmemtest = array_find(args, "skipmemtest");
	if( buildArgs.wasm==false && buildArgs.native==false ) {
		buildArgs.wasm = true;
		buildArgs.native = false;
		buildArgs.test = false;
	}

	// array_resize(*COMPILE_TIME_ARGS, args.count);
	// for arg, i: args {
	// 	COMPILE_TIME_ARGS[i] = arg;
	// }

	return buildArgs;
}

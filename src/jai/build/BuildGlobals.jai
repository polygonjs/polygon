GlobalsOptions :: struct {
	freeMemory: bool;
	skipMemTest: bool;
	useEditor: bool;
}
buildGlobals :: (options:GlobalsOptions) -> string {
	freeMemory := tprint("FREE_MEMORY_DEBUG :: %;", options.freeMemory);
	skipMemTest := tprint("SKIP_MEM_TEST :: %;", options.skipMemTest);
	useEditor := tprint("USE_EDITOR :: %;", options.useEditor);
	globalVars := tprint("% % %", freeMemory, skipMemTest, useEditor);
	return globalVars;
}


main :: () {
	loadFontImage();

	#if RUN_TESTS {
		runTests(*APP);
		return;
	}
	nodesSceneInit(*APP.nodesScene);
	windowInit(*APP.editor);
	initSceneAndAttachToEditor(*APP);
	editorStart(*APP.editor);

	reset_temporary_storage();
	#if WASM==false && FREE_MEMORY_DEBUG==true defer report_memory_leaks();
	SDL_Quit();
	printGreen("polygon quit\n");
}
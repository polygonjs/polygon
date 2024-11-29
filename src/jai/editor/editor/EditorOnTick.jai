editorOnTick :: (editor: *Editor, newTime: u64, width: u64, height: u64) {
	onResize(editor, .{width, height});

	if USE_IMGUI_DEBUG return;
	#if WASM {
		context = call_from_wasm_context;
		events_data_update(*EVENTS_DATA);
		time := performance_now();
		computeFPS(editor.nodesScene, time);
		processEvent(editor, *EVENTS_DATA);
	} else {
	}

	// print("time:%\n", newTime / 1000.0);
	sceneOnTick(editor.nodesScene, newTime / 1000.0);
	editorFlushCommands(editor);
	editorRender(editor);
	reset_temporary_storage();
	editor.nodesScene.framesCount += 1;
	editor.onAfterTick(editor);


	// if FRAMES_COUNT > 2 {do_exit = true;};
}

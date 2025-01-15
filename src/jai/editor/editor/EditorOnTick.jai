editorOnTick :: (editor: *Editor, newTime: Time, width: u64, height: u64) {
	onResize(editor, .{width, height});

	if USE_IMGUI_DEBUG return;
	#if WASM {
		eventsDataUpdate(*editor.eventsData);
		time := performance_now();
		computeFPS(editor.nodesScene, time);
		processEvent(editor, *editor.eventsData);
	} else {
	}

	sceneOnBeforeTick(editor.nodesScene, newTime);
	editorFlushCommands(editor);
	editorRender(editor);
	reset_temporary_storage();
	sceneOnAfterTick(editor.nodesScene);
	editor.onAfterTick(editor);


	// if FRAMES_COUNT > 2 { editorRequestExit(editor); };
}

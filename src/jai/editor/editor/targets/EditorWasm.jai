
wasm_debug_break :: ()  #foreign;
wasm_write_string :: (count: s64, data: *u8, is_error: bool)  #foreign;

editorStart :: (editor: *Editor) {
	if (editorValid(editor)==false){
		assert(false, "editorValid(editor)==false");
		return;
	}

	drawDataInit(editor);
}

windowInit :: ()->Vector2UInt {
	return .{4, 4};
}
headlessInit :: (wgpuContext: *WGPUContext, windowSize: Vector2UInt) {
	// current_window_size := Vector2UInt.{4, 4};
	// renderer_init_native_headless(current_window_size);
	// return current_window_size;

	wgpuContext.windowSize = windowSize;
}
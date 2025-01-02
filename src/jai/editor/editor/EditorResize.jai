onResize :: (editor: *Editor, size:Vector2UInt64) {
	if editor.wgpuContext.windowSize == size {return;}
	editor.wgpuContext.windowSize = Vector2UInt.{xx size.x, xx size.y};
	editorPanelsResize(editor);
}

editorPanelsResize :: (using editor: *Editor) {
	#if HAS_VIEWER_PANEL onResize(*viewerPanel);
	#if HAS_NETWORK_PANEL onResize(*networkPanel);
	onResize(*paramsPanel);
}
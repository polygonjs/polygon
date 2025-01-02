onResize :: (editor: *Editor, size:Vector2UInt64) {
	if editor.windowSize == size {return;}
	editor.windowSize = size;
	editorPanelsResize(editor);
}

editorPanelsResize :: (using editor: *Editor) {
	#if HAS_VIEWER_PANEL onResize(*viewerPanel);
	#if HAS_NETWORK_PANEL onResize(*networkPanel);
	onResize(*paramsPanel);
}
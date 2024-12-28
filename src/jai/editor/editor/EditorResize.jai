onResize :: (editor: *Editor, size:Vector2UInt64) {
	if editor.windowSize == size {return;}
	editor.windowSize = size;
	#if HAS_VIEWER_PANEL onResize(*editor.viewerPanel);
	#if HAS_NETWORK_PANEL onResize(*editor.networkPanel);
	onResize(*editor.paramsPanel);
}
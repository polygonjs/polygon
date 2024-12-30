onResize :: (using panel: *TYPE) {
	newAspect:float = (cast(float32) editor.windowSize.x) / (cast(float32) editor.windowSize.y);

	renderer.viewport.start = .{ editor.windowSize.x*0, xx (0.5 * xx editor.windowSize.y) };
	renderer.viewport.size = .{ xx(cast(float32)editor.windowSize.x*0.5), xx(cast(float32)editor.windowSize.y*0.5) };
}

#scope_file

TYPE :: ParamsPanel;
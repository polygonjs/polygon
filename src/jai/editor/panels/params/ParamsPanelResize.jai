onResize :: (using panel: *TYPE) {
	windowWidth :float32= xx editor.windowSize.x;
	windowHeight :float32= xx (editor.windowSize.y - editor.mainMenuBar.computedHeight);
	// newAspect:float = (cast(float32) editor.windowSize.x) / (cast(float32) editor.windowSize.y);

	renderer.viewport.start = .{
		0,
		xx (editor.mainMenuBar.computedHeight + (0.5 * windowHeight))
	};
	renderer.viewport.size = .{ xx (windowWidth*0.5), xx (windowHeight*0.5) };
}

#scope_file

TYPE :: ParamsPanel;
onResize :: (using panel: *TYPE) {
	windowWidth :float32= xx editor.wgpuContext.windowSize.x;
	windowHeight :float32= xx (editor.wgpuContext.windowSize.y - editor.mainMenuBar.computedHeight);
	newAspect:float = windowWidth / windowHeight;

	renderer.viewport.start = .{ 0, xx editor.mainMenuBar.computedHeight };
	renderer.viewport.size = .{ xx(windowWidth*0.5), xx(windowHeight*0.5) };

	previousAspect := camera.aspect;
	if(renderer.fullScreen == true) {
		camera.aspect = newAspect;
	} else {
		camera.aspect = cast(float32)renderer.viewport.size.x / cast(float32)renderer.viewport.size.y;
	}
	if(previousAspect != camera.aspect) {
		sceneCameraUpdateProjectionMatrix(*editor.nodesScene.worldScene, *camera);
	}
}

#scope_file

TYPE :: ViewerPanel;
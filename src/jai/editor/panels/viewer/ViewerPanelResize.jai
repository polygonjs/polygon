onResize :: (using panel: *TYPE) {
	newAspect:float = (cast(float32) editor.windowSize.x) / (cast(float32) editor.windowSize.y);

	renderer.viewport.start = .{ editor.windowSize.x*0, editor.windowSize.y*0 };
	renderer.viewport.size = .{ xx(cast(float32)editor.windowSize.x*0.49), xx(cast(float32)editor.windowSize.y*0.49) };

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
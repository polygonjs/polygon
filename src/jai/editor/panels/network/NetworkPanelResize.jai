
onResize :: (using panel: *TYPE) {
	windowWidth :float32= xx editor.windowSize.x;
	windowHeight :float32= xx (editor.windowSize.y - editor.mainMenuBar.computedHeight);
	newAspect:float = windowWidth / windowHeight;

	rendererColor.viewport.start = .{ xx (windowWidth*0.5), xx editor.mainMenuBar.computedHeight };
	#if NETWORK_PANEL_USE_RAYCAST_RENDERER rendererRaycast.viewport.start = rendererColor.viewport.start;
	rendererSetSize(*rendererColor, .{ xx (windowWidth*0.5), xx windowHeight });
	#if NETWORK_PANEL_USE_RAYCAST_RENDERER rendererCopySize(*rendererColor, *rendererRaycast);

	previousAspect := camera.aspect;
	if(rendererColor.fullScreen == true) {
		camera.aspect = newAspect;
	} else {
		camera.aspect = cast(float32)rendererColor.viewport.size.x / cast(float32)rendererColor.viewport.size.y;
	}
	if(previousAspect != camera.aspect) {
		sceneCameraUpdateProjectionMatrix(*sceneWorld, *camera);
		#if NETWORK_PANEL_USE_RAYCAST_RENDERER sceneCameraUpdateProjectionMatrix(*sceneRaycast, *camera);
	}
}

#scope_file

TYPE :: NetworkPanel;
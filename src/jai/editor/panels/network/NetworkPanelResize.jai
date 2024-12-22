
onResize :: (using panel: *TYPE) {
	newAspect:float = (cast(float32) editor.windowSize.x) / (cast(float32) editor.windowSize.y);

	rendererColor.viewport.start = .{ cast(u64) (cast(float) editor.windowSize.x*0.5), editor.windowSize.y*0 };
	#if NETWORK_PANEL_USE_RAYCAST_RENDERER rendererRaycast.viewport.start = rendererColor.viewport.start;
	rendererSetSize(rendererColor, .{ cast(u64) (cast(float)editor.windowSize.x*0.5), editor.windowSize.y*1 });
	#if NETWORK_PANEL_USE_RAYCAST_RENDERER rendererCopySize(rendererColor, rendererRaycast);

	if(rendererColor.fullScreen == true) {
		camera.aspect = newAspect;
	} else {
		camera.aspect = cast(float32)rendererColor.viewport.size.x / cast(float32)rendererColor.viewport.size.y;
	}
	sceneCameraUpdateProjectionMatrix(sceneWorld, camera);
	sceneCameraUpdateProjectionMatrix(sceneRaycast, camera);
}

#scope_file

TYPE :: NetworkPanel;
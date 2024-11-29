drawDataInit :: (panel: *TYPE) {
	using panel;
	rendererInitPipelines(rendererColor, sceneWorld, camera);
	#if NETWORK_PANEL_USE_RAYCAST_RENDERER rendererInitPipelines(rendererRaycast, sceneRaycast, camera);
}
render :: (panel: *TYPE, renderCollectionData: *RenderCollectionData) {
	using panel;
	rendererFlushCommands(rendererColor);
	#if NETWORK_PANEL_USE_RAYCAST_RENDERER rendererFlushCommands(rendererRaycast);
	cameraUniformsUpdate(camera);
	render(renderCollectionData, rendererColor, sceneWorld, camera);
}
rendererDestroyBuffers :: (panel: *TYPE) {
	using panel;
	rendererDestroyBuffers(rendererColor);
	rendererDestroyBuffers(rendererRaycast);
}

#scope_file

TYPE :: NetworkPanel;
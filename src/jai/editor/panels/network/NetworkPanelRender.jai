drawDataInit :: (using panel: *TYPE) {
	rendererInitPipelines(rendererColor, sceneWorld, camera);
	#if NETWORK_PANEL_USE_RAYCAST_RENDERER rendererInitPipelines(rendererRaycast, sceneRaycast, camera);
}
render :: (using panel: *TYPE, renderCollectionData: *RenderCollectionData) {
	rendererFlushCommands(rendererColor);
	#if NETWORK_PANEL_USE_RAYCAST_RENDERER rendererFlushCommands(rendererRaycast);
	cameraUniformsUpdate(camera);
	render(renderCollectionData, rendererColor, sceneWorld, camera);
}
rendererDestroyBuffers :: (using panel: *TYPE) {
	rendererDestroyBuffers(rendererColor);
	rendererDestroyBuffers(rendererRaycast);
}

#scope_file

TYPE :: NetworkPanel;
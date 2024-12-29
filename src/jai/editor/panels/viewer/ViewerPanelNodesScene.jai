panelSetScene :: (using panel: *TYPE, nodesScene: *NodesScene) {
	rendererAny: Any = panel.renderer;
	cameraControlsSetScenes(*cameraControls, .[*editor.nodesScene.worldScene]);
	cameraControlsCommit(*cameraControls);
	sceneAddObserver(*nodesScene.worldScene, rendererAny);
}
panelRemoveScene :: (using panel: *TYPE, nodesScene: *NodesScene) {
	sceneRemoveObserver(*nodesScene.worldScene, *renderer);
}
#scope_file

TYPE :: ViewerPanel;
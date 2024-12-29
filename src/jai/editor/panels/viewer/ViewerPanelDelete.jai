viewerPanelReset :: (using panel: *TYPE) {
	if(editor.nodesScene != null) sceneRemoveObserver(*editor.nodesScene.worldScene, *renderer);
	rendererReset(*renderer);
}
viewerPanelDelete :: (using panel: *TYPE) {
	viewerPanelReset(panel);
	free(panel);
}

#scope_file

TYPE :: ViewerPanel;

panelSetScene :: (using panel: *TYPE, scene: *NodesScene) {
	networkPanelUpdateScenes(panel, panel.editor.nodesScene);
	// sceneAddObserver(editor.nodesScene.worldScene, renderer);
}
panelRemoveScene :: (panel: *TYPE, scene: *NodesScene) {
	// sceneAddObserver(editor.nodesScene.worldScene, renderer);
}

#scope_file

TYPE :: NetworkPanel;

networkPanelUpdateScenes :: (panel: *TYPE, nodesScene: *NodesScene) {
	using panel.editor.sceneUiData;

	nodePositions.count = nodesScene.nodes.count;
	maybe_grow(*nodePositions);

	for node, i: nodesScene.nodes {
		if node != null {
			networkPanelAddNode(panel, node);
		}
	}
}
editorSetScene :: (editor: *Editor, nodesScene: *NodesScene) {
	assert(editor.nodesScene==null, "editor.nodesScene is not null");
	editor.nodesScene = nodesScene;
	editorAny: Any = <<editor;
	// tis := cast(*Type_Info_Struct)editorAny.type;
	nodesSceneAddObserver(nodesScene, editorAny);

	editor.sceneUiData.nodePositions.count = nodesScene.nodes.count;
	maybe_grow(*editor.sceneUiData.nodePositions);

	#if HAS_NETWORK_PANEL panelSetScene(editor.networkPanel, editor.nodesScene);
	#if HAS_VIEWER_PANEL panelSetScene(editor.viewerPanel, editor.nodesScene);
	// for node, i: nodesScene.nodes {
	// 	editor.sceneUiData.nodePositions[i] = .{0,0};
	// }
	//
	assert(nodesScene.timeGraphNode.name == "TimeNode", "timeGraphNode not set up correctly");
}
editorRemoveScene :: (editor: *Editor) {
	assert(editor.nodesScene!=null, "editor.nodesScene is null");
	editorAny: Any = <<editor;
	nodesSceneRemoveObserver(editor.nodesScene, editorAny);
	#if HAS_NETWORK_PANEL panelRemoveScene(editor.networkPanel, editor.nodesScene);
	#if HAS_VIEWER_PANEL panelRemoveScene(editor.viewerPanel, editor.nodesScene);
	editor.nodesScene = null;
}


Editor :: struct {
	nodesScene: *NodesScene;
	networkPanel: *NetworkPanel;

	SceneUiData :: struct {
		nodePositions:[..]Vector2;
	}
	sceneUiData: SceneUiData;
}

editorInit :: (editor: *Editor, nodesScene: *NodesScene) {
	editor.nodesScene = nodesScene;
	editorAny: Any = <<editor;
	tis := cast(*Type_Info_Struct)editorAny.type;
	print("editorAny: %\n", tis.name);
	sceneAddObserver(nodesScene, editorAny);

	//
	maxNodeId := -1;
	for node: nodesScene.nodes {
		if maxNodeId < node.nodeId {
			maxNodeId = node.nodeId;
		}
	}
	array_init(*editor.sceneUiData.nodePositions);
	array_resize(*editor.sceneUiData.nodePositions, maxNodeId + 1);
	for node, i: nodesScene.nodes {
		editor.sceneUiData.nodePositions[node.nodeId] = .{0,0};
	}

	//
	editor.networkPanel = newNetworkPanel(editor);
	networkPanelUpdateWorldScene(editor.networkPanel, nodesScene);

}

onNodeAdded :: (editor: *Editor, scene: *NodesScene, node: *$T) {
	using editor.sceneUiData;
	if nodePositions.count <= node.nodeId {
		array_resize(*nodePositions, node.nodeId + 1);
	}
	nodePositions[node.nodeId] = .{0,0};

	networkdPanelAddNode(editor.networkPanel, node, nodePositions[node.nodeId]);
}
onNodeRemoved :: (editor: *Editor, scene: *NodesScene, node: *$T) {
	editor.sceneUiData.nodePositions[node.nodeId] = .{-1000000,-1000000};

	networkdPanelRemoveNode(editor.networkPanel, node);
}
onNodeInputAdded :: (editor: *Editor, scene: *NodesScene, node: *$T, inputIndex: u8) {
	print("onNodeInputAdded % %\n", node, inputIndex);
}
onNodeInputRemoved :: (editor: *Editor, scene: *NodesScene, node: *$T, inputIndex: u8) {
	print("onNodeInputRemoved % %\n", node, inputIndex);
}


#scope_file

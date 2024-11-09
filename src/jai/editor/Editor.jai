

Editor :: struct {
	nodesScene: *NodesScene;

	viewerPanel: *ViewerPanel;
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
	editor.viewerPanel = newViewerPanel(editor);
	editor.networkPanel = newNetworkPanel(editor);

}
drawDataInit :: (editor: *Editor) {
	drawDataInit(editor.viewerPanel);
	drawDataInit(editor.networkPanel);
}
render :: (editor: *Editor, renderCollectionData: *RenderCollectionData) {
	render(editor.viewerPanel, renderCollectionData);
	render(editor.networkPanel, renderCollectionData);
}
rendererDestroyBuffers :: (editor: *Editor) {
	rendererDestroyBuffers(editor.viewerPanel);
	rendererDestroyBuffers(editor.networkPanel);
}
cameraControlsProcessEvent :: (editor: *Editor, eventsData:*EventsData) {
	cameraControlsProcessEvent(editor.viewerPanel, eventsData);
	cameraControlsProcessEvent(editor.networkPanel, eventsData);
}

onResize :: (editor: *Editor, size:Vector2UInt64) {
	onResize(editor.viewerPanel, size);
	onResize(editor.networkPanel, size);
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

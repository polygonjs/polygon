

Editor :: struct {
	nodesScene: *NodesScene;

	windowSize: Vector2UInt64;
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
	if editor.windowSize == size {return;}
	editor.windowSize = size;
	onResize(editor.viewerPanel);
	onResize(editor.networkPanel);
}

nodeSetPosition :: (editor: *Editor, node: *$T, position: Vector2) {
	editor.sceneUiData.nodePositions[node.nodeId] = position;
	editorEmitEvent(editor, EditorEvent.NODE_MOVED, node);
}

onNodeAdded :: (editor: *Editor, scene: *NodesScene, node: *$T) {
	using editor.sceneUiData;
	if nodePositions.count <= node.nodeId {
		array_resize(*nodePositions, node.nodeId + 1);
	}
	nodePositions[node.nodeId] = .{0, 0};

	networkPanelAddNode(editor.networkPanel, node);
}
onNodeRemoved :: (editor: *Editor, scene: *NodesScene, node: *$T) {
	editor.sceneUiData.nodePositions[node.nodeId] = .{-1000000,-1000000};

	networkPanelRemoveNode(editor.networkPanel, node);
}
onNodeInputAdded :: (editor: *Editor, scene: *NodesScene, node: *$T, inputIndex: u8) {
	print("onNodeInputAdded % %\n", node, inputIndex);
}
onNodeInputRemoved :: (editor: *Editor, scene: *NodesScene, node: *$T, inputIndex: u8) {
	print("onNodeInputRemoved % %\n", node, inputIndex);
}


#scope_file

EditorEvent :: enum u8 {
	NODE_ADDED :: 0;
	NODE_REMOVED;
	NODE_MOVED;
	NODE_INPUT_ADDED;
	NODE_INPUT_REMOVED;
}


editorEmitEvent :: (editor: *Editor, $event: EditorEvent, node: *$T) {
	p := editor.networkPanel;
	if event == {
		case EditorEvent.NODE_ADDED; 	{ onNodeAdded(p, node); return;}
		case EditorEvent.NODE_REMOVED; 	{ onNodeRemoved(p, node); return;}
		case EditorEvent.NODE_MOVED; 	{ onNodeMoved(p, node); return;}
	}
}

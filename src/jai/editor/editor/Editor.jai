

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
render :: (editor: *Editor) {
	data :RenderCollectionData= rendererCollectionStart(*WGPU_CONTEXT);
	render(editor.viewerPanel, *data);
	render(editor.networkPanel, *data);

	rendererCollectionEnd(*WGPU_CONTEXT, data);
	rendererDestroyBuffers(editor);
}
processEvent :: (editor: *Editor, eventsData:*EventsData) {
	#if USE_IMGUI {
		if(ImGui.GetIO().WantCaptureMouse == false) processEventPanels(editor, eventsData);
	} else {
		processEventPanels(editor, eventsData);
	}
}
rendererDestroyBuffers :: (editor: *Editor) {
	rendererDestroyBuffers(editor.viewerPanel);
	rendererDestroyBuffers(editor.networkPanel);
}


onResize :: (editor: *Editor, size:Vector2UInt64) {
	if editor.windowSize == size {return;}
	editor.windowSize = size;
	onResize(editor.viewerPanel);
	onResize(editor.networkPanel);
}

nodeSetPosition :: (editor: *Editor, node: *$T, position: Vector2) {
	onNodeSetPosition(editor, editor.nodesScene, node, position);
}

#scope_file

// editorEmitEvent :: (editor: *Editor, $event: EditorEvent, node: *$T) {
// 	p := editor.networkPanel;
// 	if event == {
// 		case EditorEvent.NODE_ADDED; 	{ onNodeAdded(p, node); return;}
// 		case EditorEvent.NODE_REMOVED; 	{ onNodeRemoved(p, node); return;}
// 		case EditorEvent.NODE_MOVED; 	{ onNodeMoved(p, node); return;}
// 	}
// }

processEventPanels :: (editor: *Editor, eventsData:*EventsData) {
	processEvent(editor.viewerPanel, eventsData);
	processEvent(editor.networkPanel, eventsData);
}
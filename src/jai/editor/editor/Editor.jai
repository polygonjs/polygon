

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

newEditor :: ()->*Editor {
	editor := New(Editor);
	editorInit(editor);
	return editor;
}
editorInit :: (editor: *Editor) {
	array_init(*editor.sceneUiData.nodePositions);

	editor.viewerPanel = newViewerPanel(editor);
	editor.networkPanel = newNetworkPanel(editor);
}

editorSetScene :: (editor: *Editor, nodesScene: *NodesScene) {
	assert(editor.nodesScene==null, "editor.nodesScene is not null");
	editor.nodesScene = nodesScene;
	editorAny: Any = <<editor;
	// tis := cast(*Type_Info_Struct)editorAny.type;
	sceneAddObserver(nodesScene, editorAny);

	array_resize(*editor.sceneUiData.nodePositions, nodesScene.nodeTypes.count);

	networkPanelSetScene(editor.networkPanel);
	// for node, i: nodesScene.nodes {
	// 	editor.sceneUiData.nodePositions[i] = .{0,0};
	// }
	//
}
editorRemoveScene :: (editor: *Editor) {
	assert(editor.nodesScene!=null, "editor.nodesScene is null");
	editorAny: Any = <<editor;
	sceneRemoveObserver(editor.nodesScene, editorAny);
	editor.nodesScene = null;
}
editorDelete :: (editor: *Editor) {
	using editor;
	if(editor.nodesScene!=null) editorRemoveScene(editor);
	array_reset(*sceneUiData.nodePositions);

	viewerPanelDelete(viewerPanel);
	networkPanelDelete(networkPanel);

	free(editor);
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

nodeSetPosition :: (editor: *Editor, node: *BaseNode, position: Vector2) {
	onNodeSetPosition(editor, editor.nodesScene, node, position);
}
nodeSetPosition :: (editor: *Editor, node: BaseNode, position: Vector2) {
	nodeSetPosition(editor, *node, position);
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
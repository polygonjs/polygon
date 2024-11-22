

Editor :: struct {
	exitRequested: bool=false;
	nodesScene: *NodesScene;

	windowSize: Vector2UInt64;
	viewerPanel: *ViewerPanel;
	networkPanel: *NetworkPanel;

	SceneUiData :: struct {
		nodePositions:[..]Vector2;
	}
	sceneUiData: SceneUiData;

	onAfterTick: EditorCustomOnTickCallback=DEFAULT_EDITOR_ON_TICK;
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

	array_resize(*editor.sceneUiData.nodePositions, nodesScene.nodes.count);

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
editorRender :: (editor: *Editor) {
	WGPU_CONTEXT.framesCount = editor.nodesScene.framesCount;
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
editorOnTick :: (editor: *Editor, newTime: u64, width: u64, height: u64) {
	onResize(editor, .{width, height});

	if USE_IMGUI_DEBUG return;
	#if WASM {
		context = call_from_wasm_context;
		events_data_update(*EVENTS_DATA);
		time := performance_now();
		compute_fps(editor.nodesScene, time, *UI_DATA);
		processEvent(editor, *EVENTS_DATA);
	} else {
	}

	sceneOnTick(editor.nodesScene, newTime / 1000.0);
	editorRender(editor);
	reset_temporary_storage();
	editor.nodesScene.framesCount += 1;
	editor.onAfterTick(editor);

	if(editor.exitRequested) {
		editorRemoveScene(editor);
	}
	// if FRAMES_COUNT > 2 {do_exit = true;};
}

nodeSetPosition :: (editor: *Editor, node: *BaseNode, position: Vector2) {
	onNodeSetPosition(editor, editor.nodesScene, node, position);
}
nodeSetPosition :: (editor: *Editor, node: BaseNode, position: Vector2) {
	nodeSetPosition(editor, *node, position);
}

editorRequestExit :: (editor: *Editor) {
	editor.exitRequested = true;
}

EditorCustomOnTickCallback :: #type (editor: *Editor);

#scope_file

DEFAULT_EDITOR_ON_TICK :EditorCustomOnTickCallback: (editor: *Editor) {}

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
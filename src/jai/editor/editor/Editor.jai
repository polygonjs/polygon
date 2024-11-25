
HAS_VIEWER_PANEL :: true;
HAS_NETWORK_PANEL :: true;
Editor :: struct {
	exitRequested: bool=false;
	nodesScene: *NodesScene;

	windowSize: Vector2UInt64;
	#if HAS_VIEWER_PANEL viewerPanel: *ViewerPanel;
	#if HAS_NETWORK_PANEL networkPanel: *NetworkPanel;

	SceneUiData :: struct {
		nodePositions:[..]Vector2;
	}
	sceneUiData: SceneUiData;

	onAfterTick: EditorCustomOnTickCallback=DEFAULT_EDITOR_ON_TICK;
	commands: EditorCommands;
}

newEditor :: ()->*Editor {
	editor := New(Editor);
	editorInit(editor);
	return editor;
}
editorInit :: (editor: *Editor) {
	array_init(*editor.sceneUiData.nodePositions);

	#if HAS_VIEWER_PANEL editor.viewerPanel = newViewerPanel(editor);
	#if HAS_NETWORK_PANEL editor.networkPanel = newNetworkPanel(editor);
}

editorSetScene :: (editor: *Editor, nodesScene: *NodesScene) {
	assert(editor.nodesScene==null, "editor.nodesScene is not null");
	editor.nodesScene = nodesScene;
	editorAny: Any = <<editor;
	// tis := cast(*Type_Info_Struct)editorAny.type;
	nodesSceneAddObserver(nodesScene, editorAny);

	array_resize(*editor.sceneUiData.nodePositions, nodesScene.nodes.count);

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
editorDelete :: (editor: *Editor) {
	using editor;
	array_reset(*sceneUiData.nodePositions);

	#if HAS_VIEWER_PANEL viewerPanelDelete(viewerPanel);
	#if HAS_NETWORK_PANEL networkPanelDelete(networkPanel);
	if(nodesScene != null) {
		editorRemoveScene(editor);
	}

	editorCommandsDelete(*editor.commands);
	free(editor);
}
drawDataInit :: (editor: *Editor) {
	#if HAS_VIEWER_PANEL drawDataInit(editor.viewerPanel);
	#if HAS_NETWORK_PANEL drawDataInit(editor.networkPanel);
}
editorRender :: (editor: *Editor) {
	WGPU_CONTEXT.framesCount = editor.nodesScene.framesCount;
	// print("-----------editorRender: %\n", editor.nodesScene.framesCount);
	data :RenderCollectionData= rendererCollectionStart(*WGPU_CONTEXT);
	#if HAS_VIEWER_PANEL render(editor.viewerPanel, *data);
	#if HAS_NETWORK_PANEL render(editor.networkPanel, *data);

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
	#if HAS_VIEWER_PANEL rendererDestroyBuffers(editor.viewerPanel);
	#if HAS_NETWORK_PANEL rendererDestroyBuffers(editor.networkPanel);
}


onResize :: (editor: *Editor, size:Vector2UInt64) {
	if editor.windowSize == size {return;}
	editor.windowSize = size;
	#if HAS_VIEWER_PANEL onResize(editor.viewerPanel);
	#if HAS_NETWORK_PANEL onResize(editor.networkPanel);
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

	// print("time:%\n", newTime / 1000.0);
	sceneOnTick(editor.nodesScene, newTime / 1000.0);
	editorFlushCommands(editor);
	editorRender(editor);
	reset_temporary_storage();
	editor.nodesScene.framesCount += 1;
	editor.onAfterTick(editor);


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
	#if HAS_VIEWER_PANEL processEvent(editor.viewerPanel, eventsData);
	#if HAS_NETWORK_PANEL processEvent(editor.networkPanel, eventsData);
}
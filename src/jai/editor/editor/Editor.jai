
HAS_VIEWER_PANEL :: true;
HAS_NETWORK_PANEL :: true;
Editor :: struct {
	#if USE_FLAT_POOL {
		pool: Flat_Pool;
	} else #if USE_POOL {
		pool: Pool;
	}
	allocator: Allocator;
	//
	exitRequested: bool=false;
	nodesScene: *NodesScene;
	eventsData:EventsData;

	#if USE_IMGUI {
		imguiContext: Imgui_Context;
	}

	windowSize: Vector2UInt64;
	#if HAS_VIEWER_PANEL viewerPanel: *ViewerPanel;
	#if HAS_NETWORK_PANEL networkPanel: *NetworkPanel;
	paramsPanel: *ParamsPanel;

	SceneUiData :: struct {
		nodePositions:[..]Vector2;
		selectedNodeIds:[..]NodeId;
	}
	sceneUiData: SceneUiData;

	onAfterTick: EditorCustomOnTickCallback=DEFAULT_EDITOR_ON_TICK;
	commands: EditorCommands;
}

newEditor :: ()->*Editor {
	editor := New(Editor);
	allocatorAssign(editor);
	editorInit(editor);
	return editor;
}
editorInit :: (editor: *Editor) {
	array_init(*editor.sceneUiData.nodePositions,, editor.allocator);
	array_init(*editor.sceneUiData.selectedNodeIds,, editor.allocator);
	editorCommandsSetAllocator(editor);

	#if HAS_VIEWER_PANEL editor.viewerPanel = newViewerPanel(editor);
	#if HAS_NETWORK_PANEL editor.networkPanel = newNetworkPanel(editor);
	editor.paramsPanel = newParamsPanel(editor);
}


editorDelete :: (editor: *Editor) {
	using editor;

	#if HAS_VIEWER_PANEL viewerPanelDelete(viewerPanel);
	#if HAS_NETWORK_PANEL networkPanelDelete(networkPanel);
	paramsPanelDelete(paramsPanel);
	if(nodesScene != null) {
		editorRemoveScene(editor);
	}

	allocatorReset(editor);
	free(editor);
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


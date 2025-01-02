
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
		imguiPolygonContext: ImguiPolygonContext;
	}
	#if USE_WGPU {
		wgpuContext: WGPUContext;
	}

	windowSize: Vector2UInt64;
	#if HAS_VIEWER_PANEL viewerPanel: ViewerPanel;
	#if HAS_NETWORK_PANEL networkPanel: NetworkPanel;
	paramsPanel: ParamsPanel;
	mainMenuBar: MainMenuBar;

	SceneUiData :: struct {
		nodePositions:[..]Vector2;
		selectedNodeIds:[..]NodeId;
	}
	sceneUiData: SceneUiData;

	onAfterTick: EditorOnTickCallback=DEFAULT_EDITOR_ON_TICK;
	onAfterDelete: EditorOnAfterDeleteCallback=DEFAULT_EDITOR_ON_AFTER_DELETE;
	commands: EditorCommands;

	initialized:bool = false;
	disposed:bool = false;
}

// I've considered not using a pointer here,
// to signal this cannot update the editor,
// but this seemed like it didn't quite work in wasm.
// to re-investigate.
editorValid :: (editor: *Editor)-> bool {
	// if((editor.initialized==true && editor.disposed==false)==false){ print("invalid:editor=%,initialized=% disposed=%\n", editor, editor.initialized, editor.disposed); }
	return editor.initialized==true && editor.disposed==false;
}

editorInit :: (editor: *Editor, $ensureWGPUContextValid: bool=true) {
	if(editor.disposed==true){
		assert(false, "editorInit: already disposed");
		return;
	}
	if(editor.initialized==true){
		assert(false, "editorInit: already initialized");
		return;
	}
	editor.initialized = true;


	allocatorAssign(editor);

	#if ensureWGPUContextValid {
		assert(editor.wgpuContext.device != null, "editor.wgpuContext.device is null");
		assert(editor.wgpuContext.queue != null, "editor.wgpuContext.queue is null");
	}
	array_init(*editor.sceneUiData.nodePositions, editor.allocator, reserve=true);
	array_init(*editor.sceneUiData.selectedNodeIds, editor.allocator, reserve=true);
	editorCommandsSetAllocator(editor);

	#if HAS_VIEWER_PANEL viewerPanelInit(*editor.viewerPanel, editor, ensureWGPUContextValid);
	#if HAS_NETWORK_PANEL networkPanelInit(*editor.networkPanel, editor, ensureWGPUContextValid);
	paramsPanelInit(*editor.paramsPanel, editor, ensureWGPUContextValid);

}

editorRequestExit :: (editor: *Editor) {
	editor.exitRequested = true;
}

EditorOnTickCallback :: #type (editor: *Editor);
EditorOnAfterDeleteCallback :: #type (nodesScene: *NodesScene);

#scope_file

DEFAULT_EDITOR_ON_TICK :EditorOnTickCallback: (editor: *Editor) {}
DEFAULT_EDITOR_ON_AFTER_DELETE :EditorOnAfterDeleteCallback: (nodesScene: *NodesScene) {}

// editorEmitEvent :: (editor: *Editor, $event: EditorEvent, node: *$T) {
// 	p := editor.networkPanel;
// 	if event == {
// 		case EditorEvent.NODE_ADDED; 	{ onNodeAdded(p, node); return;}
// 		case EditorEvent.NODE_REMOVED; 	{ onNodeRemoved(p, node); return;}
// 		case EditorEvent.NODE_MOVED; 	{ onNodeMoved(p, node); return;}
// 	}
// }


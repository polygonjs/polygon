ParamsPanel :: struct {
	#if USE_FLAT_POOL {
		pool: Flat_Pool;
	} else #if USE_POOL {
		pool: Pool;
	}
	// allocator: Allocator;
	//
	editor: *Editor;

	renderer: Renderer;
}

// newParamsPanel :: (editor: *Editor, $ensureWGPUContextValid: bool=true) -> *TYPE {
// 	panel: *TYPE = New(TYPE);
// 	paramsPanelInit(panel, editor, ensureWGPUContextValid);

// 	return panel;
// }
paramsPanelInit :: (using panel: *TYPE, _editor: *Editor, $ensureWGPUContextValid: bool=true) {
	// allocatorAssign(panel);

	rendererInit(*renderer, *_editor.wgpuContext, ensureWGPUContextValid);

	renderer.label = "ParamsPanelRenderer";
	renderer.fullScreen = false;
	renderer.viewport = .{
		start = .{0,0},
		size = .{1,1}
	};
	renderer.bgColor = DEFAULT_RENDERER_BG_COLOR;
	renderer.use_msaa = false;
	renderer.use_depth_buffer = false;
	renderer.useReadback = false;
	// renderer.render_ui = true;
	renderer.clear = false;

	editor = _editor;
}



processEvent :: (panel: *TYPE, eventsData:*EventsData) {
}


// panelSetScene :: (panel: *TYPE, nodesScene: *NodesScene) {
// 	rendererAny: Any = <<panel.renderer;
// 	sceneAddObserver(nodesScene.worldScene, rendererAny);
// }
// panelRemoveScene :: (panel: *TYPE, nodesScene: *NodesScene) {
// 	sceneRemoveObserver(nodesScene.worldScene, panel.renderer);
// }
#scope_file

TYPE :: ParamsPanel;


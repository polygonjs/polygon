ViewerPanel :: struct {
	#if USE_FLAT_POOL {
		pool: Flat_Pool;
	} else #if USE_POOL {
		pool: Pool;
	}
	// allocator: Allocator;
	//
	editor: *Editor;

	camera: PerspectiveCamera;
	cameraControls: OrbitControls;

	renderer: Renderer;
}

// newViewerPanel :: (editor: *Editor, $ensureWGPUContextValid: bool=true) -> *TYPE {
// 	panel: *TYPE = New(TYPE);
// 	viewerPanelInit(panel, editor, ensureWGPUContextValid);

// 	return panel;
// }
viewerPanelInit :: (using panel: *TYPE, _editor: *Editor, $ensureWGPUContextValid: bool=true) {
	// allocatorAssign(panel);

	rendererInit(*renderer, *_editor.wgpuContext, ensureWGPUContextValid);

	renderer.label = "ViewerPanelRenderer";
	renderer.fullScreen = false;
	renderer.viewport = .{
		start = .{0,0},
		size = .{1,1}
	};
	renderer.bgColor = DEFAULT_RENDERER_BG_COLOR;
	renderer.use_msaa = true;
	renderer.use_depth_buffer = true;
	renderer.useReadback = false;
	renderer.clear = false;
	// renderer.clearViewport = true;

	editor = _editor;
	object3DInit(*camera);
	cameraControls.camera = *camera;

	// cameraControlsCommit(*cameraControls); // do not commit as we don't have the scene yet
}



#scope_file

TYPE :: ViewerPanel;


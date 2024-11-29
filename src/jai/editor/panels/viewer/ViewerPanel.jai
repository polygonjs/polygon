ViewerPanel :: struct {
	#if USE_FLAT_POOL {
		pool: Flat_Pool;
	} else #if USE_POOL {
		pool: Pool;
	}
	allocator: Allocator;
	//
	editor: *Editor;

	camera: PerspectiveCamera;
	cameraControls: OrbitControls;

	renderer: *Renderer;
}

newViewerPanel :: (editor: *Editor) -> *TYPE {
	panel: *TYPE = New(TYPE);
	viewerPanelInit(panel, editor);

	return panel;
}
viewerPanelDelete :: (panel: *TYPE) {
	using panel;
	if(editor.nodesScene != null) sceneRemoveObserver(editor.nodesScene.worldScene, renderer);
	rendererDelete(renderer);
	allocatorReset(panel);
	// object3DDelete(camera);
	free(panel);
}
drawDataInit :: (panel: *TYPE) {
	using panel;
	#if USE_IMGUI { renderer_init_ui(renderer); }
	rendererInitPipelines(renderer, editor.nodesScene.worldScene, *camera);
}
render :: (panel: *TYPE, renderCollectionData: *RenderCollectionData) {
	using panel;
	nodesSceneOutputNodesCompute(editor.nodesScene);
	rendererFlushCommands(renderer);
	cameraUniformsUpdate(*camera);
	render(renderCollectionData, renderer, editor.nodesScene.worldScene, *camera);
}
rendererDestroyBuffers :: (panel: *TYPE) {
	rendererDestroyBuffers(panel.renderer);
}
processEvent :: (panel: *TYPE, eventsData:*EventsData) {
	using panel;
	focused := element_focused(renderer, eventsData);
	camera_controls_process_event(*cameraControls, eventsData, focused);
}
onResize :: (panel: *TYPE) {
	using panel;
	newAspect:float = (cast(float32) editor.windowSize.x) / (cast(float32) editor.windowSize.y);

	renderer.viewport.start = .{ editor.windowSize.x*0, editor.windowSize.y*0 };
	renderer.viewport.size = .{ xx(cast(float32)editor.windowSize.x*0.49), xx(cast(float32)editor.windowSize.y*0.49) };

	if(renderer.full_screen == true) {
		camera.aspect = newAspect;
	} else {
		camera.aspect = cast(float32)renderer.viewport.size.x / cast(float32)renderer.viewport.size.y;
	}
	cameraProjectionUpdate(*camera);
}
panelSetScene :: (panel: *TYPE, nodesScene: *NodesScene) {
	rendererAny: Any = <<panel.renderer;
	sceneAddObserver(nodesScene.worldScene, rendererAny);
}
panelRemoveScene :: (panel: *TYPE, nodesScene: *NodesScene) {
	sceneRemoveObserver(nodesScene.worldScene, panel.renderer);
}
#scope_file

TYPE :: ViewerPanel;

viewerPanelInit :: (panel: *TYPE, _editor: *Editor) {

	using panel;


	renderer = newRenderer();

	renderer.label = "ViewerPanelRenderer";
	renderer.full_screen = false;
	renderer.viewport = .{
		start = .{0,0},
		size = .{200,200}
	};
	renderer.bgColor = DEFAULT_RENDERER_BG_COLOR;
	renderer.use_msaa = true;
	renderer.use_depth_buffer = true;
	renderer.useReadback = false;
	renderer.render_ui = true;
	renderer.clear = true;

	editor = _editor;
	camera.type = PerspectiveCamera;
	object3DInit(*camera);
	cameraControls.camera = *camera;

	cameraControlsCommit(*cameraControls);
}
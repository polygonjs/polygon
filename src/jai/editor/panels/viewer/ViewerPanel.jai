ViewerPanel :: struct {
	editor: *Editor;

	camera: PerspectiveCamera;
	cameraControls: OrbitControls;

	renderer: Renderer = .{
		name = "ViewerPanelRenderer",
		full_screen = false,
		viewport = .{
			start = .{0,0},
			size = .{500,700}
		},
		bgColor = DEFAULT_RENDERER_BG_COLOR,
		render_ui = true,
		clear = true,
	};
}

newViewerPanel :: (editor: *Editor) -> *TYPE {
	panel: *TYPE = New(TYPE);
	viewerPanelInit(panel, editor);

	return panel;
}
drawDataInit :: (panel: *TYPE) {
	using panel;
	#if USE_IMGUI { renderer_init_ui(*renderer); }
	renderer_init_pipelines(*renderer, editor.nodesScene.worldScene, *camera);
}
render :: (panel: *TYPE, renderCollectionData: *RenderCollectionData) {
	using panel;
	cameraUniformsUpdate(*camera);
	render(renderCollectionData, *renderer, editor.nodesScene.worldScene, *camera);
}
rendererDestroyBuffers :: (panel: *TYPE) {
	renderer_destroy_buffers(*panel.renderer);
}
cameraControlsProcessEvent :: (panel: *TYPE, eventsData:*EventsData) {
	using panel;
	camera_controls_process_event(*cameraControls, eventsData, element_focused(*renderer, eventsData));
}
onResize :: (panel: *TYPE, size:Vector2UInt64) {
	new_aspect:float = (cast(float32) size.x) / (cast(float32) size.y);

	using panel;
	if(renderer.full_screen == true) {
		camera.aspect = new_aspect;
	} else {
		camera.aspect = renderer.viewport.size.x / renderer.viewport.size.y;
	}
	cameraProjectionUpdate(*camera);
}
#scope_file

TYPE :: ViewerPanel;

viewerPanelInit :: (panel: *TYPE, editor: *Editor) {
	panel.editor = editor;

	panel.camera.type = PerspectiveCamera;
	object3DInit(*panel.camera);
	panel.cameraControls.camera = *panel.camera;

	cameraControlsCommit(*panel.cameraControls);
}
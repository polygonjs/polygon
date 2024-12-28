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

newViewerPanel :: (editor: *Editor, $ensureWGPUContextValid: bool=true) -> *TYPE {
	panel: *TYPE = New(TYPE);
	viewerPanelInit(panel, editor, ensureWGPUContextValid);

	return panel;
}
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
	renderer.clear = true;

	editor = _editor;
	camera.type = PerspectiveCamera;
	object3DInit(*camera);
	cameraControls.camera = *camera;

	// cameraControlsCommit(*cameraControls); // do not commit as we don't have the scene yet
}
viewerPanelReset :: (using panel: *TYPE) {
	if(editor.nodesScene != null) sceneRemoveObserver(*editor.nodesScene.worldScene, *renderer);
	rendererReset(*renderer);
}
viewerPanelDelete :: (using panel: *TYPE) {
	viewerPanelReset(panel);
	free(panel);
}
drawDataInit :: (using panel: *TYPE) {
	rendererInitPipelines(*renderer, *editor.nodesScene.worldScene, *camera);
}
render :: (using panel: *TYPE, renderCollectionData: *RenderCollectionData) {
	nodesSceneOutputNodesCompute(editor.nodesScene);
	render(renderCollectionData, *renderer, *editor.nodesScene.worldScene, *camera);
}
rendererDestroyBuffers :: (using panel: *TYPE) {
	rendererDestroyBuffers(*renderer);
}

onResize :: (using panel: *TYPE) {
	newAspect:float = (cast(float32) editor.windowSize.x) / (cast(float32) editor.windowSize.y);

	renderer.viewport.start = .{ editor.windowSize.x*0, editor.windowSize.y*0 };
	renderer.viewport.size = .{ xx(cast(float32)editor.windowSize.x*0.49), xx(cast(float32)editor.windowSize.y*0.49) };

	if(renderer.fullScreen == true) {
		camera.aspect = newAspect;
	} else {
		camera.aspect = cast(float32)renderer.viewport.size.x / cast(float32)renderer.viewport.size.y;
	}
	sceneCameraUpdateProjectionMatrix(*editor.nodesScene.worldScene, *camera);
}
panelSetScene :: (using panel: *TYPE, nodesScene: *NodesScene) {
	rendererAny: Any = panel.renderer;
	cameraControlsSetScenes(*cameraControls, .[*editor.nodesScene.worldScene]);
	cameraControlsCommit(*cameraControls);
	sceneAddObserver(*nodesScene.worldScene, rendererAny);
}
panelRemoveScene :: (using panel: *TYPE, nodesScene: *NodesScene) {
	sceneRemoveObserver(*nodesScene.worldScene, *renderer);
}
#scope_file

TYPE :: ViewerPanel;


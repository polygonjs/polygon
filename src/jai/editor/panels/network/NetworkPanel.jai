
NetworkPanel :: struct {
	editor: *Editor;
	worldScene: *Scene;
	nodesSceneObjectIndex: [..]u32;

	camera: OrthographicCamera;
	cameraControls: PanControls;

	basicMat: *BasicMeshMaterial;

	renderer: Renderer = .{
		name = "NetworkPanelRenderer",
		full_screen = false,
		viewport = .{
			start = .{600,0},
			size = .{500,900}
		},
		bgColor = DEFAULT_RENDERER_BG_COLOR,
		use_msaa = false,
		render_ui = false,
		clear = false,
	};
}

newNetworkPanel :: (editor: *Editor) -> *TYPE {
	panel: *TYPE = New(TYPE);
	networkPanelInit(panel, editor);

	return panel;
}
drawDataInit :: (panel: *TYPE) {
	using panel;
	renderer_init_pipelines(*renderer, worldScene, *camera);
}
render :: (panel: *TYPE, renderCollectionData: *RenderCollectionData) {
	using panel;
	cameraUniformsUpdate(*camera); // if this is only in cameraControlsProcessEvent, then the camera is not initialized correctly
	render(renderCollectionData, *renderer, worldScene, *camera);
}
rendererDestroyBuffers :: (panel: *TYPE) {
	renderer_destroy_buffers(*panel.renderer);
}
cameraControlsProcessEvent :: (panel: *TYPE, eventsData:*EventsData) {
	using panel;
	camera_controls_process_event(*cameraControls, eventsData, element_focused(*renderer, eventsData));
}

onResize :: (panel: *TYPE) {
	using panel;
	newAspect:float = (cast(float32) editor.windowSize.x) / (cast(float32) editor.windowSize.y);

	renderer.viewport.start = .{ cast(u64) (cast(float) editor.windowSize.x*0.5), editor.windowSize.y*0 };
	renderer.viewport.size = .{ cast(u64) (cast(float)editor.windowSize.x*0.5), editor.windowSize.y*1 };

	if(renderer.full_screen == true) {
		camera.aspect = newAspect;
	} else {
		camera.aspect = cast(float32)renderer.viewport.size.x / cast(float32)renderer.viewport.size.y;
	}
	cameraProjectionUpdate(*camera);
}

networkPanelUpdateWorldScene :: (panel: *TYPE, nodesScene: *NodesScene) {
	using panel.editor.sceneUiData;

	maxNodeId := -1;
	for node: nodesScene.nodes {
		if maxNodeId < node.nodeId {
			maxNodeId = node.nodeId;
		}
	}
	if nodePositions.count < maxNodeId + 1 {
		array_resize(*nodePositions, maxNodeId + 1);
	}

	for node, i: nodesScene.nodes {
		networkdPanelAddNode(panel, node, nodePositions[node.nodeId]);
	}
}

networkdPanelAddNode :: (panel: *TYPE, node: *$T, pos: Vector2) {
	mesh := newObject3D(Mesh);
	setColor(panel.basicMat, .{1.0, 0.0, 0.0, 1.0});
	geometry_box_update(mesh.geometry, segments=.{2,2,2});
	mesh.material = xx panel.basicMat;

	mesh.position = .{x = pos.x, y = pos.y, z = 0.0};
	transformable_update_matrix(mesh);
	{
		using panel;
		if nodesSceneObjectIndex.count <= node.nodeId {
			array_resize(*nodesSceneObjectIndex, node.nodeId + 1);
		}
		nodesSceneObjectIndex[node.nodeId] = xx worldScene.children.count;
		array_add(*worldScene.children, mesh);
	}
}
networkdPanelRemoveNode :: (panel: *TYPE, node: *$T) {
	using panel;
	meshIndex := nodesSceneObjectIndex[node.nodeId];
	if meshIndex > 0 {
		mesh := worldScene.children[meshIndex];
		sceneObjectRemove(worldScene, mesh);
		worldScene.children[meshIndex] = null;
		nodesSceneObjectIndex[node.nodeId] = 0;
	}
}

#scope_file

TYPE :: NetworkPanel;

networkPanelInit :: (panel: *NetworkPanel, editor: *Editor) {

	panel.editor = editor;
	panel.worldScene = newObject3D(Scene);
	panel.camera.type = OrthographicCamera;
	object3DInit(*panel.camera);

	panel.basicMat = newMaterial(BasicMeshMaterial);
	panel.cameraControls.camera = *panel.camera;

	{
		mat := newMaterial(BackgroundMeshMaterial);
		setColor(mat, .{0.2, 0.2, 0.2, 1.0});
		mesh0 := newObject3D(Mesh);
		mesh0.material = xx mat;
		geometry_plane_update(mesh0.geometry, size=.{2,2}, segments=.{1,1});
		transformable_update_matrix(mesh0);
		sceneObjectAdd(panel.worldScene, mesh0);
	}

	networkPanelUpdateWorldScene(panel, editor.nodesScene);

	cameraControlsCommit(*panel.cameraControls);
}
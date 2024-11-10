
NetworkPanel :: struct {
	editor: *Editor;
	worldScene: *Scene;
	worldSceneRaycast: *Scene;
	nodesSceneObjectIndex: [..]u32;

	camera: OrthographicCamera;
	cameraControls: PanControls;

	basicMat: *BasicMeshMaterial;

	rendererColor: Renderer = .{
		name = "NetworkPanelRenderer",
		full_screen = false,
		viewport = .{
			start = .{600,0},
			size = .{500,900}
		},
		bgColor = DEFAULT_RENDERER_BG_COLOR,
		use_msaa = false,
		use_depth_buffer = true,
		use_readback = false,
		render_ui = false,
		clear = false,
	};
	rendererRaycast: Renderer = .{
		name = "NetworkPanelRendererRaycast",
		full_screen = false,
		viewport = .{
			start = .{600,0},
			size = .{1,1}
		},
		bgColor = .{0,0,1,1},
		use_msaa = false,
		use_depth_buffer = true,
		use_readback = true,
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
	renderer_init_pipelines(*rendererColor, worldScene, *camera);
	renderer_init_pipelines(*rendererRaycast, worldSceneRaycast, *camera);
}
render :: (panel: *TYPE, renderCollectionData: *RenderCollectionData) {
	using panel;
	cameraUniformsUpdate(*camera);
	render(renderCollectionData, *rendererColor, worldScene, *camera);
}
rendererDestroyBuffers :: (panel: *TYPE) {
	using panel;
	renderer_destroy_buffers(*rendererColor);
}
processEvent :: (panel: *TYPE, eventsData:*EventsData) {
	using panel;
	focused := element_focused(*rendererColor, eventsData);
	camera_controls_process_event(*cameraControls, eventsData, focused);
	if (focused){
		print("\ncursor: %, %\n", eventsData.cursor.x, eventsData.cursor.y);
		result := read_pixel(*rendererRaycast, worldSceneRaycast, *camera, eventsData.cursor);
		print("result: %\n", result);
	}
}

onResize :: (panel: *TYPE) {
	using panel;
	newAspect:float = (cast(float32) editor.windowSize.x) / (cast(float32) editor.windowSize.y);

	rendererColor.viewport.start = .{ cast(u64) (cast(float) editor.windowSize.x*0.5), editor.windowSize.y*0 };
	rendererRaycast.viewport.start = rendererColor.viewport.start;
	rendererSetSize(*rendererColor, .{ cast(u64) (cast(float)editor.windowSize.x*0.5), editor.windowSize.y*1 });
	rendererCopySize(*rendererColor, *rendererRaycast);

	if(rendererColor.full_screen == true) {
		camera.aspect = newAspect;
	} else {
		camera.aspect = cast(float32)rendererColor.viewport.size.x / cast(float32)rendererColor.viewport.size.y;
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
		networkPanelAddNode(panel, node);
	}
}

networkPanelAddNode :: (panel: *TYPE, node: *$T) {
	mesh := newObject3D(Mesh);
	setColor(panel.basicMat, .{1.0, 0.0, 0.0, 1.0});
	geometry_box_update(mesh.geometry, segments=.{2,2,2});
	mesh.material = xx panel.basicMat;

	pos := panel.editor.sceneUiData.nodePositions[node.nodeId];
	mesh.position = .{x = pos.x, y = pos.y, z = 0.0};
	transformable_update_matrix(mesh);
	{
		using panel;
		if nodesSceneObjectIndex.count <= node.nodeId {
			array_resize(*nodesSceneObjectIndex, node.nodeId + 1);
		}
		nodesSceneObjectIndex[node.nodeId] = xx worldScene.children.count;
		array_add(*worldScene.children, mesh);
		array_add(*worldSceneRaycast.children, mesh);
	}
}
networkPanelRemoveNode :: (panel: *TYPE, node: *$T) {
	using panel;
	meshIndex := nodesSceneObjectIndex[node.nodeId];
	if meshIndex > 0 {
		mesh := worldScene.children[meshIndex];
		sceneObjectRemove(worldScene, mesh);
		sceneObjectRemove(worldSceneRaycast, mesh);
		nodesSceneObjectIndex[node.nodeId] = 0;
	}
}
networkPanelMoveNode :: (panel: *TYPE, node: *$T) {
	using panel;
	meshIndex := nodesSceneObjectIndex[node.nodeId];
	if meshIndex > 0 {
		mesh := worldScene.children[meshIndex];
		pos := panel.editor.sceneUiData.nodePositions[node.nodeId];
		mesh.position = .{x = pos.x, y = pos.y, z = 0.0};
		transformable_update_matrix(mesh);
	}
}

onNodeAdded :: (panel: *TYPE, node: *$T) {
	networkPanelAddNode(panel, node);
}
onNodeRemoved :: (panel: *TYPE, node: *$T) {
	networkPanelRemoveNode(panel, node);
}
onNodeMoved :: (panel: *TYPE, node: *$T) {
	networkPanelMoveNode(panel, node);
}

#scope_file

TYPE :: NetworkPanel;

networkPanelInit :: (panel: *NetworkPanel, editor: *Editor) {

	panel.editor = editor;
	panel.worldScene = newObject3D(Scene);
	panel.worldSceneRaycast = newObject3D(Scene);
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
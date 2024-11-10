
NetworkPanel :: struct {
	editor: *Editor;
	sceneWorld: *Scene;
	sceneRaycast: *Scene;
	objectIndex: [..]u32;

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
	renderer_init_pipelines(*rendererColor, sceneWorld, *camera);
	renderer_init_pipelines(*rendererRaycast, sceneRaycast, *camera);
}
render :: (panel: *TYPE, renderCollectionData: *RenderCollectionData) {
	using panel;
	cameraUniformsUpdate(*camera);
	render(renderCollectionData, *rendererColor, sceneWorld, *camera);
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
		result := read_pixel(*rendererRaycast, sceneRaycast, *camera, eventsData.cursor);
		id := meshIdMaterialUnpackId(result);
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



networkPanelAddNode :: (panel: *TYPE, node: *$T) {

	_addMesh :: (panel: *TYPE, node: *$T, geometry: *Geometry, $forRaycast:bool) {
		using panel;

		mesh := newMesh(Mesh, geometry);

		#if forRaycast {
			scene := sceneRaycast;
			material := newMaterial(MeshIdMaterial);
			material.uniforms.id = node.nodeId;
			mesh.material = xx material;
		} else {
			scene := sceneWorld;
			setColor(panel.basicMat, .{1.0, 0.5, 0.25, 1.0});
			mesh.material = xx panel.basicMat;
		}

		pos := panel.editor.sceneUiData.nodePositions[node.nodeId];
		mesh.position = .{x = pos.x, y = pos.y, z = 0.0};
		transformable_update_matrix(mesh);
		{
			using panel;
			#if forRaycast==false {
				if objectIndex.count <= node.nodeId {
					array_resize(*objectIndex, node.nodeId + 1);
				}
				objectIndex[node.nodeId] = xx scene.children.count;
			}
			sceneObjectAdd(scene, mesh);
		}
	}

	geometry :*Geometry = New(Geometry);
	geometry_box_update(geometry, segments=.{2,2,2});

	_addMesh(panel, node, geometry, forRaycast=false);
	_addMesh(panel, node, geometry, forRaycast=true);
}

networkPanelRemoveNode :: (panel: *TYPE, node: *$T) {
	_removeNode :: (panel:*TYPE, node:*T, $forRaycast:bool) {
		using panel;
		meshIndex := objectIndex[node.nodeId];
		if meshIndex >= 0 {
			#if forRaycast {
				scene := sceneRaycast;
			} else {
				scene := sceneWorld;
			}
			mesh := scene.children[meshIndex];
			sceneObjectRemove(scene, mesh);
			#if forRaycast == true {
				objectIndex[node.nodeId] = 0;
			}
		}
	}
	_removeNode(panel, node, forRaycast=false);
	_removeNode(panel, node, forRaycast=true);
}
networkPanelMoveNode :: (panel: *TYPE, node: *$T) {
	_moveNode :: (panel:*TYPE, node:*T, $forRaycast:bool) {
		using panel;
		#if forRaycast {
			scene := sceneRaycast;
		} else {
			scene := sceneWorld;
		}
		meshIndex := objectIndex[node.nodeId];
		if meshIndex >= 0 {
			mesh := scene.children[meshIndex];
			pos := panel.editor.sceneUiData.nodePositions[node.nodeId];
			mesh.position = .{x = pos.x, y = pos.y, z = 0.0};
			transformable_update_matrix(mesh);
		}
	}
	_moveNode(panel, node, forRaycast=false);
	_moveNode(panel, node, forRaycast=true);
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

networkPanelInit :: (panel: *TYPE, editor: *Editor) {

	panel.editor = editor;
	panel.sceneWorld = newObject3D(Scene);
	panel.sceneRaycast = newObject3D(Scene);
	panel.camera.type = OrthographicCamera;
	object3DInit(*panel.camera);

	panel.basicMat = newMaterial(BasicMeshMaterial);
	panel.cameraControls.camera = *panel.camera;

	_addBgMesh :: (panel:*TYPE, scene:*Scene, color:Color) {
		mat := newMaterial(BackgroundMeshMaterial);
		setColor(mat, color);
		mesh0 := newObject3D(Mesh);
		assert(mesh0.geometry != null, "mesh0.geometry is null\n");
		mesh0.material = xx mat;
		geometry_plane_update(mesh0.geometry, size=.{2,2}, segments=.{1,1});
		transformable_update_matrix(mesh0);
		sceneObjectAdd(scene, mesh0);
	}
	_addBgMesh(panel, panel.sceneWorld, .{0.2, 0.2, 0.2, 1.0});
	_addBgMesh(panel, panel.sceneRaycast, .{0, 0, 0, 0});

	networkPanelUpdateScenes(panel, editor.nodesScene);

	cameraControlsCommit(*panel.cameraControls);
}

networkPanelUpdateScenes :: (panel: *TYPE, nodesScene: *NodesScene) {
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
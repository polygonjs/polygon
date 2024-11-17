
NetworkPanel :: struct {
	editor: *Editor;
	sceneWorld: *Scene;
	sceneRaycast: *Scene;
	objectIndex: [..]u32;

	camera: OrthographicCamera;
	cameraControls: PanControls;

	basicMat: *MATERIAL_BASIC;

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
networkPanelDelete :: (panel: *TYPE) {
	using panel;

	// delete bg material
	{
		bgObject := sceneWorld.children[0];
		mesh := cast(*Mesh)bgObject;
		materialDelete(cast(*MATERIAL_BG)mesh.material);
		geometryDelete(mesh.geometry);
		object3DDelete(mesh);
		sceneWorld.children[0] = null;
	}
	{
		bgObject := sceneRaycast.children[0];
		mesh := cast(*Mesh)bgObject;
		materialDelete(cast(*MATERIAL_BG)mesh.material);
		geometryDelete(mesh.geometry);
		object3DDelete(mesh);
		sceneRaycast.children[0] = null;
	}

	for object, i : sceneWorld.children {
		if object != null {
			object3DDelete(object);
			sceneWorld.children[i] = null;
		}
	}
	for object,i : sceneRaycast.children {
		if object != null {
			mesh := cast(*Mesh)object;
			materialDelete(cast(*MATERIAL_RAYCAST)mesh.material);
			geometryDelete(mesh.geometry);
			object3DDelete(object);
			sceneRaycast.children[i] = null;
		}
	}
	
	array_reset(*objectIndex);
	object3DDelete(sceneWorld);
	object3DDelete(sceneRaycast);
	materialDelete(basicMat);
	print("panel deleted, %\n", panel);
	free(panel);
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
		nodeId := meshIdMaterialUnpackId(result);
		node := sceneFindNodeById(editor.nodesScene, nodeId);
		if node != null {
			print("node: %\n", node.type);
		}
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
			material := newMaterial(MATERIAL_RAYCAST);
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
			object := scene.children[meshIndex];
			#if forRaycast {
				mesh := cast(*Mesh)object;
				materialDelete(cast(*MATERIAL_RAYCAST)mesh.material);
				geometryDelete(mesh.geometry);
			}
			sceneObjectRemove(scene, object);
			#if forRaycast == true {
				objectIndex[node.nodeId] = 0;
			}
		}
	}
	_removeNode(panel, node, forRaycast=false);
	_removeNode(panel, node, forRaycast=true);
}
networkPanelNodeSetPosition :: (panel: *TYPE, node: *$T, position: Vector2) {
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

networkPanelSetScene :: (panel: *TYPE) {
	networkPanelUpdateScenes(panel, panel.editor.nodesScene);
}

#scope_file

TYPE :: NetworkPanel;
MATERIAL_RAYCAST :: MeshIdMaterial;
MATERIAL_BG :: BackgroundMeshMaterial;
MATERIAL_BASIC :: BackgroundMeshMaterial;

networkPanelInit :: (panel: *TYPE, _editor: *Editor) {
	using panel;
	editor = _editor;
	sceneWorld = newObject3D(Scene);
	sceneRaycast = newObject3D(Scene);
	camera.type = OrthographicCamera;
	object3DInit(*camera);

	basicMat = newMaterial(MATERIAL_BASIC);
	cameraControls.camera = *camera;

	_addBgMesh :: (panel:*TYPE, scene:*Scene, color:Color) {
		mat := newMaterial(MATERIAL_BG);
		setColor(mat, color);
		mesh0 := newObject3D(Mesh);
		assert(mesh0.geometry != null, "mesh0.geometry is null\n");
		mesh0.material = xx mat;
		geometry_plane_update(mesh0.geometry, size=.{2,2}, segments=.{1,1});
		transformable_update_matrix(mesh0);
		sceneObjectAdd(scene, mesh0);
	}
	_addBgMesh(panel, sceneWorld, .{0.2, 0.2, 0.2, 1.0});
	_addBgMesh(panel, sceneRaycast, .{0, 0, 0, 0});

	cameraControlsCommit(*cameraControls);
}

networkPanelUpdateScenes :: (panel: *TYPE, nodesScene: *NodesScene) {
	using panel.editor.sceneUiData;

	if nodePositions.count < nodesScene.nodes.count {
		array_resize(*nodePositions, nodesScene.nodes.count);
	}

	for node, i: nodesScene.nodes {
		if node != null {
			networkPanelAddNode(panel, node);
		}
	}
}
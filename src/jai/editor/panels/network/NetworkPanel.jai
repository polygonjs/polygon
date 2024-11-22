
NetworkPanel :: struct {
	#if USE_FLAT_POOL {
		pool: Flat_Pool;
	} else #if USE_POOL {
		pool: Pool;
	}
	allocator: Allocator;
	//
	editor: *Editor;
	sceneWorld: *Scene;
	#if USE_RAYCAST_RENDERER sceneRaycast: *Scene;
	objectIndex: [..]u32;

	camera: *OrthographicCamera;
	cameraControls: PanControls;

	basicMat: *MATERIAL_BASIC;

	rendererColor: *Renderer;
	#if USE_RAYCAST_RENDERER rendererRaycast: *Renderer;
}

newNetworkPanel :: (editor: *Editor) -> *TYPE {
	panel: *TYPE = New(TYPE);

	networkPanelInit(panel, editor);

	return panel;
}
networkPanelDelete :: (panel: *TYPE) {
	using panel;


	// delete bg material
	// {
	// 	bgObject := sceneWorld.children[0];
	// 	mesh := cast(*Mesh)bgObject;
	// 	materialDelete(cast(*MATERIAL_BG)mesh.material);
	// 	geometryDelete(mesh.geometry);
	// 	worldObjectDelete(mesh);
	// 	sceneWorld.children[0] = null;
	// }
	// {
	// 	bgObject := sceneRaycast.children[0];
	// 	mesh := cast(*Mesh)bgObject;
	// 	materialDelete(cast(*MATERIAL_BG)mesh.material);
	// 	geometryDelete(mesh.geometry);
	// 	worldObjectDelete(mesh);
	// 	sceneRaycast.children[0] = null;
	// }

	// for object, i : sceneWorld.children {
	// 	if object != null {
	// 		generatedWorldObjectDelete(object);
	// 		sceneWorld.children[i] = null;
	// 		raycastObject := sceneRaycast.children[i];
	// 		if raycastObject.type == Mesh {
	// 			(cast(*Mesh)raycastObject).geometry = null;
	// 		}
	// 	}
	// }
	rendererDelete(rendererColor);
	#if USE_RAYCAST_RENDERER rendererDelete(rendererRaycast);
	worldObjectDelete(sceneWorld);
	#if USE_RAYCAST_RENDERER worldObjectDelete(sceneRaycast);
	// for object,i : sceneRaycast.children {
	// 	if object != null {
	// 		mesh := cast(*Mesh)object;
	// 		materialDelete(cast(*MATERIAL_RAYCAST)mesh.material);
	// 		// geometryDelete(mesh.geometry);
	// 		generatedWorldObjectDelete(object);
	// 		sceneRaycast.children[i] = null;
	// 	}
	// }
	
	// array_reset(*objectIndex);
	// generatedWorldObjectDelete(sceneWorld);
	// generatedWorldObjectDelete(sceneRaycast);
	// materialDelete(basicMat);
	allocatorReset(panel);
	free(panel);
}
drawDataInit :: (panel: *TYPE) {
	using panel;
	#if USE_IMGUI && HAS_VIEWER_PANEL==false { renderer_init_ui(rendererColor); }
	renderer_init_pipelines(rendererColor, sceneWorld, camera);
	#if USE_RAYCAST_RENDERER renderer_init_pipelines(rendererRaycast, sceneRaycast, camera);
}
render :: (panel: *TYPE, renderCollectionData: *RenderCollectionData) {
	using panel;
	cameraUniformsUpdate(camera);
	render(renderCollectionData, rendererColor, sceneWorld, camera);
}
rendererDestroyBuffers :: (panel: *TYPE) {
	using panel;
	renderer_destroy_buffers(rendererColor);
}
processEvent :: (panel: *TYPE, eventsData:*EventsData) {
	using panel;
	focused := element_focused(rendererColor, eventsData);
	camera_controls_process_event(*cameraControls, eventsData, focused);
	if (focused){
		#if WASM==false && USE_RAYCAST_RENDERER {
			result := read_pixel(rendererRaycast, sceneRaycast, camera, eventsData.cursor);
			nodeId := meshIdMaterialUnpackId(result);
			if nodeId < editor.nodesScene.nodes.count {
				node := editor.nodesScene.nodes[nodeId];
				if node != null {
					print("hovered nodeId: %, %\n", nodeId, node.type);
				}
			}
		} else {
			if READ_PIXEL_WARNING_PRINTED == false {
				print("read_pixel not supported in WASM yet\n");
				READ_PIXEL_WARNING_PRINTED = true;
			}
		}
	}
}
READ_PIXEL_WARNING_PRINTED:=false;

onResize :: (panel: *TYPE) {
	using panel;
	newAspect:float = (cast(float32) editor.windowSize.x) / (cast(float32) editor.windowSize.y);

	rendererColor.viewport.start = .{ cast(u64) (cast(float) editor.windowSize.x*0.5), editor.windowSize.y*0 };
	#if USE_RAYCAST_RENDERER rendererRaycast.viewport.start = rendererColor.viewport.start;
	rendererSetSize(rendererColor, .{ cast(u64) (cast(float)editor.windowSize.x*0.5), editor.windowSize.y*1 });
	#if USE_RAYCAST_RENDERER rendererCopySize(rendererColor, rendererRaycast);

	if(rendererColor.full_screen == true) {
		camera.aspect = newAspect;
	} else {
		camera.aspect = cast(float32)rendererColor.viewport.size.x / cast(float32)rendererColor.viewport.size.y;
	}
	cameraProjectionUpdate(camera);
}



networkPanelAddNode :: (panel: *TYPE, node: *$T) {

	_addMesh :: (panel: *TYPE, node: *$T, geometry: *Geometry, $forRaycast:bool) {
		using panel;

		#if forRaycast == true {
			scene := sceneRaycast;
		} else {
			scene := sceneWorld;
		}
		mesh := newMesh(scene, Mesh, geometry);

		#if forRaycast {
			material := newMaterial(MATERIAL_RAYCAST, panel.allocator);
			material.uniforms.id = node.nodeId;
			mesh.material = xx material;
		} else {
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

	geometry :*Geometry = newGeometry(panel.sceneWorld.allocator);
	geometry_box_update(geometry, segments=.{2,2,2});

	_addMesh(panel, node, geometry, forRaycast=false);
	#if USE_RAYCAST_RENDERER _addMesh(panel, node, geometry, forRaycast=true);
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
			sceneObjectRemove(scene, object, delete=false);
			#if forRaycast == true {
				objectIndex[node.nodeId] = 0;
			}
		}
	}
	_removeNode(panel, node, forRaycast=false);
	#if USE_RAYCAST_RENDERER _removeNode(panel, node, forRaycast=true);
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
	#if USE_RAYCAST_RENDERER _moveNode(panel, node, forRaycast=true);
}

networkPanelSetScene :: (panel: *TYPE) {
	networkPanelUpdateScenes(panel, panel.editor.nodesScene);
}

#scope_file

TYPE :: NetworkPanel;
MATERIAL_RAYCAST :: MeshIdMaterial;
MATERIAL_BG :: BackgroundMeshMaterial;
MATERIAL_BASIC :: BasicMeshMaterial;

USE_RAYCAST_RENDERER :: true;


networkPanelInit :: (panel: *TYPE, _editor: *Editor) {
	allocatorAssign(panel);


	using panel;

	{
		rendererColor = newRenderer();
		rendererColor.name = "NetworkPanelRenderer";
		rendererColor.full_screen = false;
		rendererColor.viewport = .{
				start = .{600,0},
				size = .{500,900}
			};
		rendererColor.bgColor = DEFAULT_RENDERER_BG_COLOR;
		rendererColor.use_msaa = false;
		rendererColor.use_depth_buffer = true;
		rendererColor.use_readback = false;
		#if HAS_VIEWER_PANEL == true {rendererColor.render_ui = false;}
		#if HAS_VIEWER_PANEL == false {rendererColor.render_ui = true;}
		rendererColor.clear = false;
	}
	#if USE_RAYCAST_RENDERER {
		rendererRaycast = newRenderer();
		rendererRaycast.name = "NetworkPanelRendererRaycast";
		rendererRaycast.full_screen = false;
		rendererRaycast.viewport = .{
			start = .{600,0},
			size = .{1,1}
		};
		rendererRaycast.bgColor = .{0,0,1,1};
		rendererRaycast.use_msaa = false;
		rendererRaycast.use_depth_buffer = true;
		rendererRaycast.use_readback = true;
		rendererRaycast.render_ui = false;
		rendererRaycast.clear = false;
	}


	// allocatorAssign(rendererColor);
	// allocatorAssign(rendererRaycast);
	
	objectIndex.allocator = panel.allocator;
	editor = _editor;
	sceneWorld = newScene(panel.allocator);
	#if USE_RAYCAST_RENDERER sceneRaycast = newScene(panel.allocator);
	camera = newObject3D(sceneWorld, OrthographicCamera);
	// camera.type = OrthographicCamera;
	// object3DInit(*camera);

	basicMat = newMaterial(MATERIAL_BASIC, panel.allocator);
	cameraControls.camera = camera;

	_addBgMesh :: (panel:*TYPE, scene:*Scene, color:Color) {
		mat := newMaterial(scene, MATERIAL_BG);
		setColor(mat, color);
		mesh0 := newMesh(scene, Mesh);
		assert(mesh0.geometry != null, "mesh0.geometry is null\n");
		mesh0.material = xx mat;
		geometry_plane_update(mesh0.geometry, size=.{2,2}, segments=.{1,1});
		transformable_update_matrix(mesh0);
		sceneObjectAdd(scene, mesh0);
	}
	_addBgMesh(panel, sceneWorld, .{0.2, 0.2, 0.2, 1.0});
	#if USE_RAYCAST_RENDERER _addBgMesh(panel, sceneRaycast, .{0, 0, 0, 0});

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
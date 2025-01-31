NETWORK_PANEL_USE_RAYCAST_RENDERER :: false;
NetworkPanel :: struct {
	#if USE_FLAT_POOL {
		pool: Flat_Pool;
	} else #if USE_POOL {
		pool: Pool;
	}
	allocator: Allocator;
	//
	editor: *Editor;
	sceneWorld: Scene;
	#if NETWORK_PANEL_USE_RAYCAST_RENDERER sceneRaycast: Scene;
	nodeBodyObjectIndexByNodeId: [..]u32;
	// nodeTextObjectIndexByNodeId: [..]u32;
	connectionObjectIndexByConnectionId: [..]u32;

	camera: OrthographicCamera;
	cameraControls: PanControls;

	DefaultMaterial :: struct {
		nodeBasic: MATERIAL_BASIC;
		nodeSelected: MATERIAL_BASIC;
		nodeHovered: MATERIAL_BASIC;
		connectionBasic: MATERIAL_BASIC;
		connectionCurrent: MATERIAL_BASIC;
	}
	mat: DefaultMaterial;

	rendererColor: Renderer;
	#if NETWORK_PANEL_USE_RAYCAST_RENDERER rendererRaycast: Renderer;

	eventHandler: NetworkPanelEventHandler;
	nodeMoveData: NetworkPanelNodeMoveData;
}

NetworkPanelEventHandler :: struct {
	mode: NetworkPanelOperation = .NONE;
	#if NETWORK_PANEL_USE_RAYCAST_RENDERER {
		waitingForButtonDownReadPixel:bool = false;
		waitingForButtonUpReadPixel:bool = false;
	}
	nodeIdOnButtonDownFound:bool = false;
	nodeIdOnButtonDown:NodeId = 0;

	screenData: NetworkPanelCursorData;
	worldData: NetworkPanelCursorData;

	hoveredNodeId: NodeIdOrNone = -1;
	highlightedConnectionId: NodeConnectionIdOrNone = -1;
}

NetworkPanelOperation :: enum u8 {
	NONE :: 0;
	SELECT;
	NODE_MOVE;
	NODE_CREATE;
	NODE_CONNECT;
}

// newNetworkPanel :: (editor: *Editor, $ensureWGPUContextValid: bool=true) -> *TYPE {
// 	panel: *TYPE = New(TYPE);

// 	networkPanelInit(panel, editor, ensureWGPUContextValid);

// 	return panel;
// }

networkPanelInit :: (using panel: *TYPE, _editor: *Editor, $ensureWGPUContextValid: bool=true) {
	allocatorAssign(panel);

	{
		rendererInit(*rendererColor, *_editor.wgpuContext, ensureWGPUContextValid);
		rendererColor.label = "NetworkPanelRendererColor";
		rendererColor.fullScreen = false;
		rendererColor.viewport = .{
				start = .{0,0},
				size = .{1,1}
			};
		rendererColor.bgColor = DEFAULT_RENDERER_BG_COLOR;
		rendererColor.use_msaa = true;
		rendererColor.use_depth_buffer = true;
		rendererColor.useReadback = false;
		rendererColor.clear = true;
	}
	#if NETWORK_PANEL_USE_RAYCAST_RENDERER {
		rendererInit(*rendererRaycast, *_editor.wgpuContext, ensureWGPUContextValid);
		rendererRaycast.label = "NetworkPanelRendererRaycast";
		rendererRaycast.fullScreen = false;
		rendererRaycast.viewport = .{
			start = .{0,0},
			size = .{1,1}
		};
		rendererRaycast.bgColor = .{1,1,1,0};
		rendererRaycast.use_msaa = false;
		rendererRaycast.use_depth_buffer = true;
		rendererRaycast.useReadback = true;
		rendererRaycast.clear = false;
	}


	// allocatorAssign(rendererColor);
	// allocatorAssign(rendererRaycast);
	
	nodeBodyObjectIndexByNodeId.allocator = panel.allocator;
	// nodeTextObjectIndexByNodeId.allocator = panel.allocator;
	connectionObjectIndexByConnectionId.allocator = panel.allocator;
	editor = _editor;
	worldSceneInit(*sceneWorld);
	#if NETWORK_PANEL_USE_RAYCAST_RENDERER worldSceneInit(*sceneRaycast);
	// camera = newObject3D(*sceneWorld, OrthographicCamera);
	object3DInit(*camera);
	camera.near = 0;
	camera.far = 10;
	camera.size = 10;
	cameraProjectionUpdate(*camera);
	// camera.type = OrthographicCamera;
	// object3DInit(*camera);

	rendererColorAny: Any = rendererColor;
	sceneAddObserver(*sceneWorld, rendererColorAny);
	#if NETWORK_PANEL_USE_RAYCAST_RENDERER {
		rendererRaycastAny: Any = rendererRaycast;
		sceneAddObserver(*sceneRaycast, rendererRaycastAny);
	}

	materialInit(*mat.nodeBasic);
	materialInit(*mat.nodeSelected);
	materialInit(*mat.nodeHovered);
	materialInit(*mat.connectionBasic);
	materialInit(*mat.connectionCurrent);
	setColor(*mat.nodeBasic, .{1.0, 0.5, 0.25, 1.0});
	setColor(*mat.nodeSelected, .{0, 1, 0, 1});
	setColor(*mat.nodeHovered, .{1.0, 0.7, 0.2, 1.0});
	setColor(*mat.connectionBasic, .{0.25, 0.5, 0.75, 1.0});
	setColor(*mat.connectionCurrent, .{0.9, 1, 0.9, 1});
	cameraControls.camera = *camera;
	#if NETWORK_PANEL_USE_RAYCAST_RENDERER {
		cameraControlsSetScenes(*cameraControls, .[*sceneWorld, *sceneRaycast]);
	} else {
		cameraControlsSetScenes(*cameraControls, .[*sceneWorld]);
	}
	cameraControlsCommit(*cameraControls);


	networkPanelAddBgMesh(panel, *sceneWorld, .{0.2, 0.2, 0.2, 1.0});
	#if NETWORK_PANEL_USE_RAYCAST_RENDERER networkPanelAddBgMesh(panel, *sceneRaycast, .{0, 0, 0, 0});

	nodeMoveDataInit(panel);
}



NETWORK_PANEL_MATERIAL_RAYCAST :: MeshIdMaterial;

#scope_file

TYPE :: NetworkPanel;
MATERIAL_BASIC :: MeshBasicMaterial;



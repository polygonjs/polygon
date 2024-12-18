NETWORK_PANEL_USE_RAYCAST_RENDERER :: true;
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
	#if NETWORK_PANEL_USE_RAYCAST_RENDERER sceneRaycast: *Scene;
	nodeObjectIndexByNodeId: [..]u32;
	connectionObjectIndexByConnectionId: [..]u32;

	camera: *OrthographicCamera;
	cameraControls: PanControls;

	DefaultMaterial :: struct {
		nodeBasic: *MATERIAL_BASIC;
		nodeSelected: *MATERIAL_BASIC;
		connectionBasic: *MATERIAL_BASIC;
	}
	mat: DefaultMaterial;

	rendererColor: *Renderer;
	#if NETWORK_PANEL_USE_RAYCAST_RENDERER rendererRaycast: *Renderer;

	eventHandler: NetworkPanelEventHandler;
}

NetworkPanelEventHandler :: struct {
	mode: NetworkPanelOperation = .NONE;
	waitingForButtonDownReadPixel:bool = false;
	waitingForButtonUpReadPixel:bool = false;
	nodeIdOnButtonDownFound:bool = false;
	nodeIdOnButtonDown:NodeId = 0;

	screenData: NetworkPanelCursorData;
	worldData: NetworkPanelCursorData;
}

NetworkPanelOperation :: enum u8 {
	NONE :: 0;
	SELECT;
	NODE_MOVE;
	NODE_CREATE;
	NODE_CONNECT;
}

newNetworkPanel :: (editor: *Editor, $ensureWGPUContextValid: bool=true) -> *TYPE {
	panel: *TYPE = New(TYPE);

	networkPanelInit(panel, editor, ensureWGPUContextValid);

	return panel;
}


NETWORK_PANEL_MATERIAL_RAYCAST :: MeshIdMaterial;

#scope_file

TYPE :: NetworkPanel;
MATERIAL_BASIC :: MeshBasicMaterial;



networkPanelInit :: (using panel: *TYPE, _editor: *Editor, $ensureWGPUContextValid: bool=true) {
	allocatorAssign(panel);

	{
		rendererColor = newRenderer(*_editor.wgpuContext, ensureWGPUContextValid);
		rendererColor.label = "NetworkPanelRendererColor";
		rendererColor.fullScreen = false;
		rendererColor.viewport = .{
				start = .{0,0},
				size = .{1,1}
			};
		rendererColor.bgColor = DEFAULT_RENDERER_BG_COLOR;
		rendererColor.use_msaa = false;
		rendererColor.use_depth_buffer = true;
		rendererColor.useReadback = false;
		rendererColor.clear = false;
	}
	#if NETWORK_PANEL_USE_RAYCAST_RENDERER {
		rendererRaycast = newRenderer(*_editor.wgpuContext, ensureWGPUContextValid);
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
	
	nodeObjectIndexByNodeId.allocator = panel.allocator;
	connectionObjectIndexByConnectionId.allocator = panel.allocator;
	editor = _editor;
	sceneWorld = newScene(panel.allocator);
	#if NETWORK_PANEL_USE_RAYCAST_RENDERER sceneRaycast = newScene(panel.allocator);
	camera = newObject3D(sceneWorld, OrthographicCamera);
	camera.near = 0;
	camera.far = 10;
	cameraProjectionUpdate(camera);
	// camera.type = OrthographicCamera;
	// object3DInit(*camera);

	rendererColorAny: Any = <<rendererColor;
	sceneAddObserver(sceneWorld, rendererColorAny);
	#if NETWORK_PANEL_USE_RAYCAST_RENDERER {
		rendererRaycastAny: Any = <<rendererRaycast;
		sceneAddObserver(sceneRaycast, rendererRaycastAny);
	}

	mat.nodeBasic = newMaterial(MATERIAL_BASIC, panel.allocator);
	mat.nodeSelected = newMaterial(MATERIAL_BASIC, panel.allocator);
	mat.connectionBasic = newMaterial(MATERIAL_BASIC, panel.allocator);
	setColor(mat.nodeBasic, .{1.0, 0.5, 0.25, 1.0});
	setColor(mat.nodeSelected, .{0, 1, 0, 1});
	setColor(mat.connectionBasic, .{0.25, 0.5, 0.75, 1.0});

	cameraControls.camera = camera;

	networkPanelAddBgMesh(panel, sceneWorld, .{0.2, 0.2, 0.2, 1.0});
	#if NETWORK_PANEL_USE_RAYCAST_RENDERER networkPanelAddBgMesh(panel, sceneRaycast, .{0, 0, 0, 0});

	cameraControlsCommit(*cameraControls);
}


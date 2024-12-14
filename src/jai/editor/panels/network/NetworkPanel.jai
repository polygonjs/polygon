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
	objectIndex: [..]u32;

	camera: *OrthographicCamera;
	cameraControls: PanControls;

	DefaultMaterial :: struct {
		basic: *MATERIAL_BASIC;
		nodeSelected: *MATERIAL_BASIC;
	}
	mat: DefaultMaterial;

	rendererColor: *Renderer;
	#if NETWORK_PANEL_USE_RAYCAST_RENDERER rendererRaycast: *Renderer;
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



networkPanelInit :: (panel: *TYPE, _editor: *Editor, $ensureWGPUContextValid: bool=true) {
	allocatorAssign(panel);


	using panel;

	{
		rendererColor = newRenderer(*_editor.wgpuContext, ensureWGPUContextValid);
		rendererColor.label = "NetworkPanelRendererColor";
		rendererColor.full_screen = false;
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
		rendererRaycast.full_screen = false;
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
	
	objectIndex.allocator = panel.allocator;
	editor = _editor;
	sceneWorld = newScene(panel.allocator);
	#if NETWORK_PANEL_USE_RAYCAST_RENDERER sceneRaycast = newScene(panel.allocator);
	camera = newObject3D(sceneWorld, OrthographicCamera);
	// camera.type = OrthographicCamera;
	// object3DInit(*camera);

	rendererColorAny: Any = <<rendererColor;
	sceneAddObserver(sceneWorld, rendererColorAny);
	#if NETWORK_PANEL_USE_RAYCAST_RENDERER {
		rendererRaycastAny: Any = <<rendererRaycast;
		sceneAddObserver(sceneRaycast, rendererRaycastAny);
	}

	mat.basic = newMaterial(MATERIAL_BASIC, panel.allocator);
	mat.nodeSelected = newMaterial(MATERIAL_BASIC, panel.allocator);
	setColor(mat.basic, .{1.0, 0.5, 0.25, 1.0});
	setColor(mat.nodeSelected, .{0, 1, 0, 1});

	cameraControls.camera = camera;

	networkPanelAddBgMesh(panel, sceneWorld, .{0.2, 0.2, 0.2, 1.0});
	#if NETWORK_PANEL_USE_RAYCAST_RENDERER networkPanelAddBgMesh(panel, sceneRaycast, .{0, 0, 0, 0});

	cameraControlsCommit(*cameraControls);
}


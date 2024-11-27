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

	basicMat: *MATERIAL_BASIC;

	rendererColor: *Renderer;
	#if NETWORK_PANEL_USE_RAYCAST_RENDERER rendererRaycast: *Renderer;
}

newNetworkPanel :: (editor: *Editor) -> *TYPE {
	panel: *TYPE = New(TYPE);

	networkPanelInit(panel, editor);

	return panel;
}


NETWORK_PANEL_MATERIAL_RAYCAST :: MeshIdMaterial;

#scope_file

TYPE :: NetworkPanel;
MATERIAL_BG :: BackgroundMeshMaterial;
MATERIAL_BASIC :: BasicMeshMaterial;



networkPanelInit :: (panel: *TYPE, _editor: *Editor) {
	allocatorAssign(panel);


	using panel;

	{
		rendererColor = newRenderer();
		rendererColor.label = "NetworkPanelRendererColor";
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
	#if NETWORK_PANEL_USE_RAYCAST_RENDERER {
		rendererRaycast = newRenderer();
		rendererRaycast.label = "NetworkPanelRendererRaycast";
		rendererRaycast.full_screen = false;
		rendererRaycast.viewport = .{
			start = .{600,0},
			size = .{1,1}
		};
		rendererRaycast.bgColor = .{1,1,1,0};
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

	basicMat = newMaterial(MATERIAL_BASIC, panel.allocator);
	cameraControls.camera = camera;

	networkPanelAddBgMesh(panel, sceneWorld, .{0.2, 0.2, 0.2, 1.0});
	#if NETWORK_PANEL_USE_RAYCAST_RENDERER networkPanelAddBgMesh(panel, sceneRaycast, .{0, 0, 0, 0});

	cameraControlsCommit(*cameraControls);
}


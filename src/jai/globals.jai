#if USE_WGPU {
	WGPU_CONTEXT:WGPUContext;
}
#if USE_IMGUI {
	WINDOW_CONTEXT:WindowContext;
	BD:ImGui_ImplWGPU_Data;
	IWC:ImGui_WGPU_Common;
}
EVENTS_DATA:EventsData;
UI_DATA:UiData;


CAMERA_WORLD:*PerspectiveCamera;
CAMERA_CONTROLS_WORLD:OrbitControls;
SCENE_NODES:Scene;
CAMERA_NODES:*OrthographicCamera;
CAMERA_CONTROLS_NODES:PanControls;

#if RENDER_WORLD {
	WORLD_RENDERER: Renderer = .{
		name = "WORLD_RENDERER",
		full_screen = false,
		viewport = .{
			start = .{0,0},
			size = .{500,700}
		},
		bg_color = .{0.1, 0.3, 0.72, 1.0},
		render_ui = true,
		clear = true,
	};
}
#if RENDER_NODES_NETWORK {
	NODES_RENDERER: Renderer = .{
		name = "NODES_RENDERER",
		full_screen = false,
		viewport = .{
			start = .{600,0},
			size = .{500,900}
		},
		bg_color = .{0,0,0,1},
		use_msaa = false,
		render_ui = false,
		clear = false,
	};
}
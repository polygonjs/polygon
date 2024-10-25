COLOR_SPACE_LINEAR :: true; // needs to manually match same variable in WebGPURequest.ts
USE_IMGUI :: true;
USE_IMGUI_DEBUG :: false;
USE_COMPUTE_SHADER :: false;
MAP_BUFFER :: false && WASM==false; // to read the buffer from the GPU to the CPU
FREE_MEMORY :: true; // beware wasm memory corruption when in use
FREE_MEMORY_DEBUG :: false;
RENDER_IN_VIEWPORT :: true;
RENDER_SCENE :: true;
RUN_TESTS :: false;
VSYNC :: false;

#placeholder WASM;
#placeholder SHADER_RENDER_BASIC;
#placeholder SHADER_RENDER_RAYMARCHING;

#if USE_IMGUI WINDOW_CONTEXT:WindowContext;
WGPU_CONTEXT:WGPUContext;
#if USE_IMGUI {
	BD:ImGui_ImplWGPU_Data;
	IWC:ImGui_WGPU_Common;
}
EVENTS_DATA:EventsData;
UI_DATA:UiData;

do_exit := false;
#if WASM==true {
	call_from_wasm_context :Context;
	wasm_debug_break :: ()  #foreign;
	wasm_write_string :: (count: s64, data: *u8, is_error: bool)  #foreign;
}

#if WASM==false {
	wgpu_log_callback :: (level: WGPULogLevel, msg: *u8, userdata: *void) #c_call {
		new_context: Context;
		push_context new_context {
			print("\n");
			print_red("ERROR WGPU START\n");
		}
		print_c("[WGPU :: %]: %\n", level, to_string(msg));
		push_context new_context {
			print_red("ERROR WGPU END\n");
			print("\n");
		}
	}
}


//
//
//
//
//
main :: () {
	#if WASM==true call_from_wasm_context = context;

	#if RUN_TESTS run_tests();

	node_name_size := 128;
	SCENE_WORLD.node_name.data  = alloc(node_name_size);
	SCENE_WORLD.node_name.count = node_name_size;
	test_string := "Hello World!";
	memcpy(SCENE_WORLD.node_name.data, test_string.data, test_string.count);


	init_scene_world(*SCENE_WORLD, 1.);
	CAMERA_WORLD = newObject3D(PerspectiveCamera);
	CAMERA_CONTROLS_WORLD.camera = CAMERA_WORLD;
	init_scene_nodes(*SCENE_NODES, 1.);
	CAMERA_NODES = newObject3D(OrthographicCamera);
	CAMERA_CONTROLS_NODES.camera = CAMERA_NODES;

	#if WASM==false {
		SDL_Init(SDL_INIT_VIDEO|SDL_INIT_AUDIO);
		current_window_size :Vector2UInt = .{1280, 720};

		display_mode: SDL_DisplayMode;
		get_display_mode_result := SDL_GetDesktopDisplayMode(0, *display_mode);
		if(get_display_mode_result == 0){
			display_name :string= to_string(SDL_GetDisplayName(0));
			current_window_size = .{xx display_mode.w, xx display_mode.h};
		}

		window:*SDL_Window = SDL_CreateWindow("Polygon Compute",
			SDL_WINDOWPOS_UNDEFINED,
			SDL_WINDOWPOS_UNDEFINED,
			xx current_window_size.x,
			xx current_window_size.y,
			SDL_WINDOW_ALLOW_HIGHDPI
			|SDL_WINDOW_RESIZABLE
			|SDL_WINDOW_MAXIMIZED
			|SDL_WINDOW_INPUT_FOCUS
			|SDL_WINDOW_MOUSE_FOCUS
			//|SDL_WINDOW_FULLSCREEN
		);
		assert(window != null, "Could not create window: %\n", to_string(SDL_GetError()));
		// if(get_display_mode_result==0){
		// 	SDL_SetWindowFullscreen(*window, xx SDL_WINDOW_RESIZABLE);
		// }
		#if USE_IMGUI {
			WINDOW_CONTEXT.window = window;

			imgui_context := ImGui.CreateContext();
			sdl_init_success := ImGui_ImplSdl_Init(window);
			assert(sdl_init_success, "ImGui_ImplSdl_Init returns false");
			// imgui_style := ImGui.GetStyle(); // ImGuiStyle
			// imgui_style.AntiAliasedLinesUseTex = false;
			// ImGui.StyleColorsLight(/*imgui_style*/);
		}

		wgpuSetLogCallback(wgpu_log_callback, null);
		wgpuSetLogLevel(.Error); //(.Warn);
		renderer_init_native(window, current_window_size);
		init_draw_data();
		#if USE_IMGUI io := ImGui.GetIO();

		while !do_exit {
			
			time := current_time_monotonic();
			compute_fps(time, *UI_DATA);
			sdl_event: SDL_Event;
			events_data_reset(*EVENTS_DATA);
			
			while SDL_PollEvent(*sdl_event) {
				events_data_update(*EVENTS_DATA, *sdl_event);
				orbit_controls_process_event();

				if sdl_event.type == {
					case SDL_QUIT; {do_exit = true;}
					case SDL_WINDOWEVENT; {
						if (sdl_event.window.event == SDL_WINDOWEVENT_RESIZED) {
							new_width := sdl_event.window.data1;
							new_height := sdl_event.window.data2;
							if(new_width > 0 && new_height > 0){
								current_window_size = .{xx new_width, xx new_height};
								renderer_resize_native(current_window_size);
							}
						}
					}
					case SDL_KEYDOWN; {
						#if USE_IMGUI {
							if(io.WantCaptureKeyboard == false){
								if sdl_event.key.keysym.sym == SDLK_ESCAPE {
									do_exit = true;
								}
							}
						} else {
							if sdl_event.key.keysym.sym == SDLK_ESCAPE {
								do_exit = true;
							}
						}
					}
				}
			}
			orbit_controls_process_event();

			// do_exit = true;
			on_request_animation_frame(xx to_microseconds(time), current_window_size.x, current_window_size.y);

		}
		reset_temporary_storage();
		#if WASM==false && FREE_MEMORY_DEBUG==true defer report_memory_leaks();
		SDL_Quit();
		print_green("polygon quit\n");
	}

}







//
//
//
//
//
init_draw_data :: () {
	#if WASM==true context = call_from_wasm_context;

	renderer_init_ui();
	renderer_init_pipelines_scene_data(*WORLD_RENDERER, *SCENE_WORLD, xx CAMERA_WORLD);
	renderer_init_pipelines_nodes(*NODES_RENDERER, *SCENE_NODES, xx CAMERA_NODES);

}


//
//
//
//
//
on_request_animation_frame :: (
	new_time: u64,
	width: u64,
	height: u64
) {
	if USE_IMGUI_DEBUG return;
	#if WASM {
		context = call_from_wasm_context;
		events_data_update(*EVENTS_DATA);
		time := performance_now();
		compute_fps(time, *UI_DATA);
	} else {
	}

	new_aspect:float = (cast(float32) width) / (cast(float32) height);

	if(new_aspect != CAMERA_WORLD.aspect){
		if(WORLD_RENDERER.full_screen == true) {
			CAMERA_WORLD.aspect = new_aspect;
			CAMERA_NODES.aspect = new_aspect;
		} else {
			CAMERA_WORLD.aspect = WORLD_RENDERER.viewport.size.x / WORLD_RENDERER.viewport.size.y;
			CAMERA_NODES.aspect = WORLD_RENDERER.viewport.size.x / WORLD_RENDERER.viewport.size.y;
		}
		camera_projection_update(CAMERA_WORLD);
		camera_projection_update(CAMERA_NODES);
	}
	SCENE_WORLD.time = new_time / 1000.0;
	orbit_controls_process_event();
	update_scene_data_uniforms(*SCENE_WORLD);
	camera_uniforms_update(CAMERA_WORLD, SCENE_WORLD.time);
	camera_uniforms_update(CAMERA_NODES, SCENE_NODES.time);

	window_size :Vector2UInt= .{xx width, xx height};
	data := renderer_collection_start(*WGPU_CONTEXT);
	render(*data, *WORLD_RENDERER, *SCENE_WORLD, CAMERA_WORLD, window_size, render_ui=true, clear=true);
	render(*data, *NODES_RENDERER, *SCENE_NODES, CAMERA_NODES, window_size, render_ui=false, clear=false);
	renderer_collection_end(*WGPU_CONTEXT, data);

	renderer_destroy_buffers(*WORLD_RENDERER);
	renderer_destroy_buffers(*NODES_RENDERER);

	reset_temporary_storage();
	FRAMES_COUNT += 1;
	// if FRAMES_COUNT > 2 {do_exit = true;};
}

// scope_file does not yet prevent unwanted functions to be in the wasm export
#scope_file

orbit_controls_process_event :: () {
	#if USE_IMGUI {
		io := ImGui.GetIO();
		if(io.WantCaptureMouse == false){
			camera_controls_process_event(*CAMERA_CONTROLS_WORLD, *EVENTS_DATA);
			camera_controls_process_event(*CAMERA_CONTROLS_NODES, *EVENTS_DATA);
		}
	} else {
		camera_controls_process_event(*CAMERA_CONTROLS_WORLD, *EVENTS_DATA);
		camera_controls_process_event(*CAMERA_CONTROLS_NODES, *EVENTS_DATA);
	}
}



SCENE_WORLD:Scene;
CAMERA_WORLD:*PerspectiveCamera;
CAMERA_CONTROLS_WORLD:OrbitControls;
SCENE_NODES:Scene;
CAMERA_NODES:*OrthographicCamera;
CAMERA_CONTROLS_NODES:PanControls;
WORLD_RENDERER: Renderer = .{
	full_screen = false,
	viewport = .{
		start = .{0,0},
		size = .{500,700}
	},
	bg_color = .{0.1, 0.3, 0.72, 1.0},
};
NODES_RENDERER: Renderer = .{
	full_screen = false,
	viewport = .{
		start = .{600,0},
		size = .{500,900}
	},
	bg_color = .{0,0,0,1},
};


#if FREE_MEMORY_DEBUG #import "Basic"()(MEMORY_DEBUGGER=true);
else #import "Basic";
#import "Hash_Table";
#import "Math";
#import "String";
#if WASM == true  #import "wgpu_wasm";
else              #import "wgpu";

#load "scene/index.jai";
#load "common/events/index.jai";
#load "common/wgpu/index.jai";
#load "common/ui/index.jai";
#load "common/utils/index.jai";


#if WASM == false {
	#import "SDL";
}
#if USE_IMGUI {
	#load "common/imgui/index.jai";
}

#load "test/index.jai";

#if OS == .LINUX {
	// in order to import gcc_s, I initially tried:
	// gcc_s  :: #library,system,link_always "libgcc_s.so.1";
	// as the symlink from libgcc_s.so did not exist. This worked fine,
	// but to be cleaner, I created it with:
	// sudo ln -s /lib/x86_64-linux-gnu/libgcc_s.so.1 /lib/x86_64-linux-gnu/libgcc_s.so
	// and now we can import with "gcc_s"
	gcc_s  :: #library,system,link_always "gcc_s";
	// c  :: #library,system,link_always "libc";
	// m  :: #library,system,link_always "libm";
	// dl :: #library,system,link_always "libdl";
	// pt :: #library,system,link_always "libpthread";

	// for imgui_impl_wgpu lib (until we convert it to jai)
	//
	// sudo ln -s /lib/x86_64-linux-gnu/libstdc++.so.6 /lib/x86_64-linux-gnu/libstdc++.so
	// and now we can import with "gcc_s"
	// libstd :: #library,system,link_always "stdc++";
}


USE_IMGUI :: true;
USE_IMGUI_DEBUG :: false;
USE_COMPUTE_SHADER :: true;
MAP_BUFFER :: false && WASM==false; // to read the buffer from the GPU to the CPU
FREE_MEMORY :: true; // beware wasm memory corruption when in use
FREE_MEMORY_DEBUG :: false;
RENDER_IN_VIEWPORT :: false;
RENDER_SCENE :: true;
RUN_TESTS :: false;
VSYNC :: false;

#placeholder WASM;
#placeholder SHADER_RENDER_BASIC;
#placeholder SHADER_RENDER_RAYMARCHING;
#placeholder SHADER_COMPUTE_BOX_CREATE;
#placeholder SHADER_COMPUTE_TRANSLATE;
#placeholder SHADER_COMPUTE_noise;


#if USE_IMGUI window_context:WindowContext;
SCENE_DATA:SceneData;
pipeline_controller0: PipelineController;
pipeline_controller1: PipelineController;
pipeline_controller2: PipelineController;
PIPELINE_CONTROLLERS:[..]PipelineController;
orbit_controls:OrbitControls;
events_data:EventsData;
#if USE_IMGUI {
	ui_data:UiData= .{};
	bd:ImGui_ImplWGPU_Data = .{};
	iwc:ImGui_WGPU_Common = .{};
}
#if USE_COMPUTE_SHADER {
	COMPUTE_CONTROLLER_COLLECTION:ComputeControllerCollection;
}



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
	SCENE_DATA.node_name.data  = alloc(node_name_size);
	SCENE_DATA.node_name.count = node_name_size;
	test_string := "Hello World!";
	memcpy(SCENE_DATA.node_name.data, test_string.data, test_string.count);


	init_scene_data(*SCENE_DATA, 1.);

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
			window_context.window = window;

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
			compute_fps(time, *ui_data);
			sdl_event: SDL_Event;
			events_data_reset(*events_data);
			
			while SDL_PollEvent(*sdl_event) {
				events_data_update(*events_data, *sdl_event);
				#if USE_IMGUI {
					ImGui_ImplSdl_ProcessEvent(*sdl_event);
					if(io.WantCaptureMouse == false){
						orbit_controls_process_event(*orbit_controls, *events_data);
					}
				} else {
					orbit_controls_process_event(*orbit_controls, *events_data);
				}

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
			#if USE_IMGUI {
				if(io.WantCaptureMouse == false){
					orbit_controls_process_event(*orbit_controls, *events_data);
				}
			} else {
				orbit_controls_process_event(*orbit_controls, *events_data);
			}

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
	renderer_init_draw_data();
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
		events_data_update(*events_data);
		time := performance_now();
		compute_fps(time, *ui_data);
	} else {
	}
	

	new_aspect:float = (cast(float32) width) / (cast(float32) height);

	if(new_aspect != SCENE_DATA.camera.aspect){
		SCENE_DATA.camera.aspect = new_aspect;
		camera_data_projection_update(*SCENE_DATA.camera);
	}
	SCENE_DATA.time = new_time / 1000.0;
	#if USE_IMGUI {
		io := ImGui.GetIO();
		if(io.WantCaptureMouse == false){
			orbit_controls_process_event(*orbit_controls, *events_data);
		}
	} else {
		orbit_controls_process_event(*orbit_controls, *events_data);
	}
	orbit_controls_update_camera(*orbit_controls, *SCENE_DATA.camera);
	update_scene_data_uniforms(*SCENE_DATA);

	#if USE_COMPUTE_SHADER {
		compute_controller_collection_compute(*COMPUTE_CONTROLLER_COLLECTION, *SCENE_DATA);
	}

	render();

	reset_temporary_storage();
	FRAMES_COUNT += 1;
}

// scope_file does not yet prevent unwanted functions to be in the wasm export
#scope_file

#if FREE_MEMORY_DEBUG #import "Basic"()(MEMORY_DEBUGGER=true);
else #import "Basic";
#import "Math";
#import "String";
#if WASM == true  #import "wgpu_wasm";
else              #import "wgpu";

#load "scene/index.jai";
#load "common/fps.jai";
#load "common/math_helper.jai";
#load "common/type_utils.jai";
#load "common/events/index.jai";
#load "common/wgpu/index.jai";
#load "common/print_utils.jai";


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

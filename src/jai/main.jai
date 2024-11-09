#load "config.jai";
#load "globals.jai";



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
		#if USE_WGPU {
			print_c("[WGPU :: %]: %\n", level, to_string(msg));
		}
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

	#if RUN_TESTS {
		runTests();
		#if WASM==false {
			return;
		}
	}
	sceneInit(*NODES_SCENE);
	assert(NODES_SCENE.timeGraphNode.type == TimeNode, "timeGraphNode not set up correctly (A)");
	appInit(*NODES_SCENE);
	assert(NODES_SCENE.timeGraphNode.type == TimeNode, "timeGraphNode not set up correctly (B)");
	editorInit(*EDITOR, *NODES_SCENE);
	// node_name_size := 128;
	// SCENE_WORLD.node_name.data  = alloc(node_name_size);
	// SCENE_WORLD.node_name.count = node_name_size;
	// test_string := "Hello World!";
	// memcpy(SCENE_WORLD.node_name.data, test_string.data, test_string.count);

	// CAMERA_WORLD = newObject3D(PerspectiveCamera);
	// CAMERA_CONTROLS_WORLD.camera = CAMERA_WORLD;
	// camera_controls_apply(*CAMERA_CONTROLS_WORLD);
	// CAMERA_NODES = newObject3D(OrthographicCamera);
	// CAMERA_CONTROLS_NODES.camera = CAMERA_NODES;

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
		#if USE_WGPU {
			renderer_init_native(window, current_window_size);
			init_draw_data();
		}
		#if USE_IMGUI io := ImGui.GetIO();

		while !do_exit {
			
			time := current_time_monotonic();
			compute_fps(time, *UI_DATA);
			sdl_event: SDL_Event;
			events_data_reset(*EVENTS_DATA);
			
			while SDL_PollEvent(*sdl_event) {
				events_data_update(*EVENTS_DATA, *sdl_event);
				cameraControlsProcessEvent();

				if sdl_event.type == {
					case SDL_QUIT; {do_exit = true;}
					case SDL_WINDOWEVENT; {
						if (sdl_event.window.event == SDL_WINDOWEVENT_RESIZED) {
							new_width := sdl_event.window.data1;
							new_height := sdl_event.window.data2;
							if(new_width > 0 && new_height > 0){
								current_window_size = .{xx new_width, xx new_height};
								#if USE_WGPU {
									renderer_resize_native(current_window_size);
								}
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

	drawDataInit(*EDITOR);

}


//
//
//
//
//
on_request_animation_frame :: (
	newTime: u64,
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

	onResize(*EDITOR, .{width, height});
	#if WASM {
		cameraControlsProcessEvent();
	}
	sceneOnTick(*NODES_SCENE, newTime / 1000.0);

	#if USE_WGPU {
		data :RenderCollectionData= rendererCollectionStart(*WGPU_CONTEXT);
		render(*EDITOR, *data);
		rendererCollectionEnd(*WGPU_CONTEXT, data);
	}

	rendererDestroyBuffers(*EDITOR);

	reset_temporary_storage();
	FRAMES_COUNT += 1;
	// if FRAMES_COUNT > 2 {do_exit = true;};
}


#scope_file

cameraControlsProcessEvent :: () {
	#if USE_IMGUI {
		if(ImGui.GetIO().WantCaptureMouse == false) cameraControlsProcessEvent(*EDITOR, *EVENTS_DATA);
	} else {
		cameraControlsProcessEvent(*EDITOR, *EVENTS_DATA);
	}
}






#if FREE_MEMORY_DEBUG #import "Basic"()(MEMORY_DEBUGGER=true);
else #import "Basic";
#import "Bit_Array";
#import "Hash_Table";
#import "Math";
#import "String";
#if WASM == true  #import "wgpu_wasm";
else              #import "wgpu";

#load "app.jai";
#load "core/graph/_index.jai";
#load "editor/_index.jai";
#load "engine/_index.jai";
#load "scene/_index.jai";
#load "common/events/index.jai";
#load "common/ui/index.jai";
#load "common/utils/_index.jai";


#if WASM == false {
	#import "SDL";
}
#if USE_IMGUI {
	#load "common/imgui/index.jai";
}
#if USE_WGPU {
	#load "common/wgpu/index.jai";
}
#if RUN_TESTS {
	#load "test/_index.jai";
}

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

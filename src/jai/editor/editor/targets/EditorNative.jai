

editorNativeStart :: (editor: *Editor, window_size :Vector2UInt) {
	current_window_size :Vector2UInt = window_size;

	#if USE_WGPU {
		drawDataInit(editor);
	}
	#if USE_IMGUI {
		io := ImGui.GetIO();
	}

	while editor.exitRequested==false {

		time := current_time_monotonic();
		compute_fps(editor.nodesScene, time, *UI_DATA);
		sdl_event: SDL_Event;
		events_data_reset(*EVENTS_DATA);

		while SDL_PollEvent(*sdl_event) {
			events_data_update(*EVENTS_DATA, *sdl_event);
			processEvent(editor, *EVENTS_DATA);

			if sdl_event.type == {
				case SDL_QUIT; {editor.exitRequested = true;}
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
								editor.exitRequested = true;
							}
						}
					} else {
						if sdl_event.key.keysym.sym == SDLK_ESCAPE {
							editor.exitRequested = true;
						}
					}
				}
			}
		}

		// editor.exitRequested = true;
		editorOnTick(editor, xx to_microseconds(time), current_window_size.x, current_window_size.y);

	}
	editorDelete(editor);
}

windowInit :: ()->Vector2UInt {
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
	}

	return current_window_size;
}

#scope_file

wgpu_log_callback :: (level: WGPULogLevel, msg: *u8, userdata: *void) #c_call {
	new_context: Context;
	push_context new_context {
		print("\n");
		printRed("ERROR WGPU START\n");
	}
	#if USE_WGPU {
		print_c("[WGPU :: %]: %\n", level, to_string(msg));
	}
	push_context new_context {
		printRed("ERROR WGPU END\n");
		print("\n");
	}
}
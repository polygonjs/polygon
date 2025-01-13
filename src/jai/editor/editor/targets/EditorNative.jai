

editorStart :: (editor: *Editor) {
	if (editorValid(editor)==false){
		assert(false, "editorValid(editor)==false");
		return;
	}

	assert(editor.wgpuContext.windowSize.x > 0, "editor.wgpuContext.windowSize.x is zero");
	assert(editor.wgpuContext.windowSize.y > 0, "editor.wgpuContext.windowSize.y is zero");
	assert(editor.wgpuContext.device != null, "editor.wgpuContext.device is null");
	assert(editor.wgpuContext.queue != null, "editor.wgpuContext.device is null");

	#if USE_WGPU {
		drawDataInit(editor);
	}

	while editor.exitRequested==false {

		time := current_time_monotonic();
		computeFPS(editor.nodesScene, time);
		sdl_event: SDL_Event;
		eventsDataReset(*editor.eventsData);
		while SDL_PollEvent(*sdl_event) {
			eventsDataUpdate(*editor.eventsData, *sdl_event);
			processEvent(editor, *editor.eventsData);

			if sdl_event.type == {
				case SDL_QUIT; { editorRequestExit(editor); }
				case SDL_WINDOWEVENT; {
					if (sdl_event.window.event == SDL_WINDOWEVENT_RESIZED) {
						new_width := sdl_event.window.data1;
						new_height := sdl_event.window.data2;
						if(new_width > 0 && new_height > 0){
							newWindowSize :Vector2UInt= .{xx new_width, xx new_height};
							#if USE_WGPU {
								wgpuContextResize(*editor.wgpuContext, newWindowSize);
							}
						}
					}
				}
				case SDL_KEYDOWN; {
					#if USE_IMGUI {
						if(ImGui.GetIO().WantCaptureKeyboard == false){
							if sdl_event.key.keysym.sym == SDLK_ESCAPE {
								editorRequestExit(editor);
							}
						}
					} else {
						if sdl_event.key.keysym.sym == SDLK_ESCAPE {
							editorRequestExit(editor);
						}
					}
				}
			}
		}

		editorOnTick(editor, xx to_microseconds(time), editor.wgpuContext.config.width, editor.wgpuContext.config.height);
	}
	editorReset(editor);
}

windowInit :: (editor: *Editor) {
	SDL_Init(SDL_INIT_VIDEO|SDL_INIT_AUDIO);
	currentWindowSize :Vector2UInt = .{1280, 720};

	display_mode: SDL_DisplayMode;
	get_display_mode_result := SDL_GetDesktopDisplayMode(0, *display_mode);
	if(get_display_mode_result == 0){
		display_name :string= to_string(SDL_GetDisplayName(0));
		currentWindowSize = .{xx display_mode.w, xx display_mode.h};
	}

	window:*SDL_Window = SDL_CreateWindow("Polygon",
		SDL_WINDOWPOS_UNDEFINED,
		SDL_WINDOWPOS_UNDEFINED,
		xx currentWindowSize.x,
		xx currentWindowSize.y,
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
		editor.imguiPolygonContext.windowContext.window = window;
		imguiPolygonContextInit(*editor.imguiPolygonContext);

		sdl_init_success := ImGui_ImplSdl_Init(*editor.imguiPolygonContext, window);
		assert(sdl_init_success, "ImGui_ImplSdl_Init returns false");
		// imgui_style := ImGui.GetStyle(); // ImGuiStyle
		// imgui_style.AntiAliasedLinesUseTex = false;
		// ImGui.StyleColorsLight(/*imgui_style*/);
	}

	wgpuSetLogCallback(wgpu_log_callback, null);
	wgpuSetLogLevel(.Error); //(.Warn);

	#if USE_WGPU {
		wgpuContextInitIfAllowed(*editor.wgpuContext, window, currentWindowSize);
	}

}
headlessInit :: (wgpuContext: *WGPUContext, windowSize: Vector2UInt) {
	// currentWindowSize := Vector2UInt.{4, 4};
	wgpuContextInitHeadless(wgpuContext, windowSize);
	// return currentWindowSize;
}

#scope_file

wgpu_log_callback :: (level: WGPULogLevel, msg: *u8, userdata: *void) #c_call {
	new_context: #Context;
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
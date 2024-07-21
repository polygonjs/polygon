cursor_arrow: *SDL_Cursor;
cursor_text_input: *SDL_Cursor;
cursor_move: *SDL_Cursor;
cursor_resize_ns: *SDL_Cursor;
cursor_resize_ew: *SDL_Cursor;
cursor_resize_nesw: *SDL_Cursor;
cursor_resize_nwse: *SDL_Cursor;

ImGui_ImplSdl_GetClipboardText :: (data: *void) -> *u8 #c_call {
	return SDL_GetClipboardText();
}

ImGui_ImplSdl_SetClipboardText :: (data: *void, text: *u8) #c_call {
	SDL_SetClipboardText(text);
}

ImGui_ImplSdl_InvalidateDeviceObjects :: () {
    // if g_FontTexture {
    //     glDeleteTextures(1, *g_FontTexture);
    //     ImGui.GetIO().Fonts.TexID = null;
    //     g_FontTexture = 0;
    // }
}

ImGui_ImplSdl_Init :: (window: *SDL_Window) -> bool {
	io := ImGui.GetIO();
	io.KeyMap[ImGuiKey.Tab] = xx SDLK_TAB;                     // Keyboard mapping. ImGui will use those indices to peek into the io.KeyDown[] array.
	io.KeyMap[ImGuiKey.LeftArrow] = xx SDL_SCANCODE_LEFT;
	io.KeyMap[ImGuiKey.RightArrow] = xx SDL_SCANCODE_RIGHT;
	io.KeyMap[ImGuiKey.UpArrow] = xx SDL_SCANCODE_UP;
	io.KeyMap[ImGuiKey.DownArrow] = xx SDL_SCANCODE_DOWN;
	io.KeyMap[ImGuiKey.PageUp] = xx SDL_SCANCODE_PAGEUP;
	io.KeyMap[ImGuiKey.PageDown] = xx SDL_SCANCODE_PAGEDOWN;
	io.KeyMap[ImGuiKey.Home] = xx SDL_SCANCODE_HOME;
	io.KeyMap[ImGuiKey.End] = xx SDL_SCANCODE_END;
	io.KeyMap[ImGuiKey.Delete] = xx SDLK_DELETE;
	io.KeyMap[ImGuiKey.Backspace] = xx SDLK_BACKSPACE;
	io.KeyMap[ImGuiKey.Enter] = xx SDLK_RETURN;
	io.KeyMap[ImGuiKey.Escape] = xx SDLK_ESCAPE;
	io.KeyMap[ImGuiKey.A] = xx SDLK_a;
	io.KeyMap[ImGuiKey.C] = xx SDLK_c;
	io.KeyMap[ImGuiKey.V] = xx SDLK_v;
	io.KeyMap[ImGuiKey.X] = xx SDLK_x;
	io.KeyMap[ImGuiKey.Y] = xx SDLK_y;
	io.KeyMap[ImGuiKey.Z] = xx SDLK_z;

	io.SetClipboardTextFn = ImGui_ImplSdl_SetClipboardText;
	io.GetClipboardTextFn = ImGui_ImplSdl_GetClipboardText;
	io.ClipboardUserData = null;

	#if OS == .WINDOWS {
		wmInfo: SDL_SysWMinfo ;
		SDL_VERSION(*wmInfo.version);
		SDL_GetWindowWMInfo(window, *wmInfo);
		io.ImeWindowHandle = wmInfo.info.win.window;
	}

	cursor_arrow = SDL_CreateSystemCursor(.ARROW);
	cursor_text_input = SDL_CreateSystemCursor(.IBEAM);
	cursor_move = SDL_CreateSystemCursor(.HAND);
	cursor_resize_ns = SDL_CreateSystemCursor(.SIZENS);
	cursor_resize_ew = SDL_CreateSystemCursor(.SIZEWE);
	cursor_resize_nesw = SDL_CreateSystemCursor(.SIZENESW);
	cursor_resize_nwse = SDL_CreateSystemCursor(.SIZENWSE);

	return true;
}

ImGui_ImplSdl_Shutdown :: () {
    ImGui_ImplSdl_InvalidateDeviceObjects();
}

ImGui_ImplSdl_NewFrame :: (window: *SDL_Window) {
	// if !g_FontTexture ImGui_ImplSdl_CreateDeviceObjects();

	io := ImGui.GetIO();

	// Setup display size (every frame to accommodate for window resizing)
	w, h: s32;
	display_w, display_h: s32;
	SDL_GetWindowSize(window, *w, *h);
	SDL_GL_GetDrawableSize(window, *display_w, *display_h);
	io.DisplaySize = .{xx w, xx h};
	io.DisplayFramebufferScale = .{cast(float) display_w / w, cast(float) display_h / h};

	// Setup time step
	frequency := SDL_GetPerformanceFrequency();
	current_time := SDL_GetPerformanceCounter();
	// if g_Time > 0 {
	//     io.DeltaTime = cast(float)((cast(float64)(current_time - g_Time)) / frequency);
	// } else {
	//     io.DeltaTime = (1.0/60.0);
	// }
	// // if (io.DeltaTime <= 0.0) {
	// //     io.DeltaTime = (1.0/60.0);
	// // }
	// g_Time = current_time;

	// Setup inputs
	// (we already got mouse wheel, keyboard keys & characters from SDL_PollEvent())
	mx, my: s32;
	mouseMask := SDL_GetMouseState(*mx, *my);
	if (SDL_GetWindowFlags(window) & SDL_WINDOW_MOUSE_FOCUS) {
		io.MousePos = .{xx mx, xx my};   // Mouse position, in pixels (set to -1,-1 if no mouse / on another screen, etc.)
	} else {
		io.MousePos = .{-FLOAT32_MAX,-FLOAT32_MAX};
	}

	// io.MouseDown[0] = (g_MousePressed[0] || (mouseMask & SDL_BUTTON(SDL_BUTTON_LEFT)) != 0);      // If a mouse press event came, always pass it as "mouse held this frame", so we don't miss click-release events that are shorter than 1 frame.
	// io.MouseDown[1] = (g_MousePressed[1] || (mouseMask & SDL_BUTTON(SDL_BUTTON_RIGHT)) != 0);
	// io.MouseDown[2] = (g_MousePressed[2] || (mouseMask & SDL_BUTTON(SDL_BUTTON_MIDDLE)) != 0);
	// g_MousePressed[0], g_MousePressed[1], g_MousePressed[2] = false, false, false;

	// io.MouseWheel = g_MouseWheel;
	// g_MouseWheel = 0.0;

	// Hide OS mouse cursor if ImGui is drawing it
	SDL_ShowCursor(xx (io.MouseDrawCursor == false));
}
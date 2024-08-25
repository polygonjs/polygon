// g_MousePressed := bool.[false, false, false];
// g_MouseWheel: float = 0.0;

cursor_arrow: *SDL_Cursor;
cursor_text_input: *SDL_Cursor;
cursor_move: *SDL_Cursor;
cursor_resize_all: *SDL_Cursor;
cursor_resize_ns: *SDL_Cursor;
cursor_resize_ew: *SDL_Cursor;
cursor_resize_nesw: *SDL_Cursor;
cursor_resize_nwse: *SDL_Cursor;
cursor_hand: *SDL_Cursor;
cursor_no: *SDL_Cursor;

CURSORS_COUNT :: 10;

imgui_cursors: [CURSORS_COUNT]ImGuiMouseCursor = .[
	ImGuiMouseCursor.None,
	ImGuiMouseCursor.Arrow,
	ImGuiMouseCursor.TextInput,
	ImGuiMouseCursor.ResizeAll,
	ImGuiMouseCursor.ResizeNS,
	ImGuiMouseCursor.ResizeEW,
	ImGuiMouseCursor.ResizeNESW,
	ImGuiMouseCursor.ResizeNWSE,
	ImGuiMouseCursor.Hand,
	ImGuiMouseCursor.NotAllowed
];

sdl_cursors: [CURSORS_COUNT]*SDL_Cursor;

ImGui_ImplSdl_GetClipboardText :: (data: *void) -> *u8 #c_call {
	return SDL_GetClipboardText();
}

ImGui_ImplSdl_SetClipboardText :: (data: *void, text: *u8) #c_call {
	SDL_SetClipboardText(text);
}

// You can read the io.WantCaptureMouse, io.WantCaptureKeyboard flags to tell if dear imgui wants to use your inputs.
// - When io.WantCaptureMouse is true, do not dispatch mouse input data to your main application.
// - When io.WantCaptureKeyboard is true, do not dispatch keyboard input data to your main application.
// Generally you may always pass all inputs to dear imgui, and hide them from your application based on those two flags.
ImGui_ImplSdl_ProcessEvent :: (event: *SDL_Event) -> bool {
	io := ImGui.GetIO();
	if event.type == {
		// case SDL_MOUSEWHEEL;
		// 	if event.wheel.y > 0 g_MouseWheel = 1;
		// 	if event.wheel.y < 0 g_MouseWheel = -1;
		// 	return true;
		// case SDL_MOUSEBUTTONDOWN;
		// 	if event.button.button == SDL_BUTTON_LEFT   g_MousePressed[0] = true;
		// 	if event.button.button == SDL_BUTTON_RIGHT  g_MousePressed[1] = true;
		// 	if event.button.button == SDL_BUTTON_MIDDLE g_MousePressed[2] = true;
		// 	return true;
		case SDL_TEXTINPUT;
			// io.AddInputCharactersUTF8(io, xx event.text.text.data);
			return true;
		case SDL_KEYDOWN; #through;
		case SDL_KEYUP;
			//@@key := event.key.keysym.sym & ~SDLK_SCANCODE_MASK;
			key := event.key.keysym.sym & (xx ~(1<<30));
			io.KeysDown[key] = (event.type == SDL_KEYDOWN);
			kmod := SDL_GetModState();
			io.KeyShift = ((kmod & KMOD_SHIFT) != 0);
			io.KeyCtrl = ((kmod & KMOD_CTRL) != 0);
			io.KeyAlt = ((kmod & KMOD_ALT) != 0);
			io.KeySuper = ((kmod & KMOD_GUI) != 0);
			return true;
	}
	return false;
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
	// cursor_move = SDL_CreateSystemCursor(.CROSSHAIR);
	cursor_resize_all = SDL_CreateSystemCursor(.SIZEALL);
	cursor_resize_ns = SDL_CreateSystemCursor(.SIZENS);
	cursor_resize_ew = SDL_CreateSystemCursor(.SIZEWE);
	cursor_resize_nesw = SDL_CreateSystemCursor(.SIZENESW);
	cursor_resize_nwse = SDL_CreateSystemCursor(.SIZENWSE);
	cursor_hand = SDL_CreateSystemCursor(.HAND);
	cursor_no = SDL_CreateSystemCursor(.NO);


	for imgui_cursors {
		if it == {
			case .None;			sdl_cursors[it_index] = cursor_no;
			case .Arrow;		sdl_cursors[it_index] = cursor_arrow;
			case .TextInput;	sdl_cursors[it_index] = cursor_text_input;
			case .ResizeAll;	sdl_cursors[it_index] = cursor_resize_all;
			case .ResizeNS;		sdl_cursors[it_index] = cursor_resize_ns;
			case .ResizeEW;		sdl_cursors[it_index] = cursor_resize_ew;
			case .ResizeNESW;	sdl_cursors[it_index] = cursor_resize_nesw;
			case .ResizeNWSE;	sdl_cursors[it_index] = cursor_resize_nwse;
			case .Hand;			sdl_cursors[it_index] = cursor_hand;
			case .NotAllowed;	sdl_cursors[it_index] = cursor_no;
			case;				sdl_cursors[it_index] = cursor_arrow;
		}
	}
	return true;
}

ImGui_ImplSdl_Shutdown :: () {
	ImGui_ImplSdl_InvalidateDeviceObjects();
}

ImGui_ImplSdl_NewFrame :: (window: *SDL_Window, events_data: *EventsData) {
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

	io.MouseDown[0] = events_data.mouseButton.left;//(g_MousePressed[0] || (mouseMask & SDL_BUTTON(SDL_BUTTON_LEFT)) != 0);      // If a mouse press event came, always pass it as "mouse held this frame", so we don't miss click-release events that are shorter than 1 frame.
	io.MouseDown[1] = events_data.mouseButton.right;//(g_MousePressed[1] || (mouseMask & SDL_BUTTON(SDL_BUTTON_RIGHT)) != 0);
	io.MouseDown[2] = events_data.mouseButton.middle;//(g_MousePressed[2] || (mouseMask & SDL_BUTTON(SDL_BUTTON_MIDDLE)) != 0);
	// g_MousePressed[0], g_MousePressed[1], g_MousePressed[2] = false, false, false;

	io.MouseWheel = events_data.wheel;
	// g_MouseWheel = 0.0;

	io.AddInputCharactersUTF8(io, xx events_data.text.data);

	// Hide OS mouse cursor if ImGui is drawing it
	SDL_ShowCursor(xx (io.MouseDrawCursor == false));
	// display cursor
	cursor := ImGui.GetMouseCursor();
	for imgui_cursors {
		if it == cursor {
			SDL_SetCursor(sdl_cursors[it_index]);
			break;
		}
	}
}
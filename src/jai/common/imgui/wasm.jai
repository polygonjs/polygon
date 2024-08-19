
ImGui_ImplWasm_NewFrame :: () {
	// if !g_FontTexture ImGui_ImplSdl_CreateDeviceObjects();
	
	io := ImGui.GetIO();

	// Setup display size (every frame to accommodate for window resizing)
	// w, h: s32;
	w :u32= 1;
	h :u32= 1;
	imguiGetWindowData(*w, *h);
	// display_w, display_h: s32;
	// SDL_GetWindowSize(window, *w, *h);
	// SDL_GL_GetDrawableSize(window, *display_w, *display_h);
	io.DisplaySize = .{xx w, xx h};
	io.DisplayFramebufferScale = .{xx 1, xx 1};//.{cast(float) display_w / w, cast(float) display_h / h};
	// print("io.DisplaySize:%, io.DisplayFramebufferScale:%\n",io.DisplaySize, io.DisplayFramebufferScale);

	// Setup time step
	// frequency := SDL_GetPerformanceFrequency();
	// current_time := SDL_GetPerformanceCounter();
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
	// mx, my: s32;
	// left_button_pressed:bool = false;
	// mouseMask := SDL_GetMouseState(*mx, *my);
	imguiGetMouseData(*io.MousePos.x, *io.MousePos.y, *io.MouseDown[0]);
	// print("size_of(bool):%\n", size_of(bool));
	// print("io.MousePos:%\n",io.MousePos.x);
	// print("io.MouseDown:%,%\n",io.MouseDown[0],io.MouseDown[1]);
	// if (SDL_GetWindowFlags(window) & SDL_WINDOW_MOUSE_FOCUS) {
	// 	io.MousePos = .{xx mx, xx my};   // Mouse position, in pixels (set to -1,-1 if no mouse / on another screen, etc.)
	// } else {
	// 	io.MousePos = .{-FLOAT32_MAX,-FLOAT32_MAX};
	// }

	// io.MouseDown[0] = (g_MousePressed[0] || (mouseMask & SDL_BUTTON(SDL_BUTTON_LEFT)) != 0);      // If a mouse press event came, always pass it as "mouse held this frame", so we don't miss click-release events that are shorter than 1 frame.
	// io.MouseDown[1] = (g_MousePressed[1] || (mouseMask & SDL_BUTTON(SDL_BUTTON_RIGHT)) != 0);
	// io.MouseDown[2] = (g_MousePressed[2] || (mouseMask & SDL_BUTTON(SDL_BUTTON_MIDDLE)) != 0);
	// g_MousePressed[0], g_MousePressed[1], g_MousePressed[2] = false, false, false;

	// io.MouseWheel = g_MouseWheel;
	// g_MouseWheel = 0.0;

	// // Hide OS mouse cursor if ImGui is drawing it
	// SDL_ShowCursor(xx (io.MouseDrawCursor == false));
}


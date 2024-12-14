ImGui_ImplWasm_Init :: (imguiPolygonContext: *ImguiPolygonContext) {
	assert(imguiPolygonContext.io != null, "imguiPolygonContext.io is null");
	io := ImGui.GetIO();
	io.KeyMap[ImGuiKey.LeftArrow] = 0;
	io.KeyMap[ImGuiKey.RightArrow] = 1;
	io.KeyMap[ImGuiKey.UpArrow] = 2;
	io.KeyMap[ImGuiKey.DownArrow] = 3;
	io.KeyMap[ImGuiKey.PageUp] = 4;
	io.KeyMap[ImGuiKey.PageDown] = 5;
	io.KeyMap[ImGuiKey.Home] = 6;
	io.KeyMap[ImGuiKey.End] = 7;
	io.KeyMap[ImGuiKey.Delete] = 8;
	io.KeyMap[ImGuiKey.Backspace] = 9;
	io.KeyMap[ImGuiKey.Enter] = 10;
	io.KeyMap[ImGuiKey.Escape] = 11;
	// I'm not sure if the ones below are required,
	// but for now, we set them just like in ./native.jai
	io.KeyMap[ImGuiKey.A] = 12;
	io.KeyMap[ImGuiKey.C] = 13;
	io.KeyMap[ImGuiKey.V] = 14;
	io.KeyMap[ImGuiKey.X] = 15;
	io.KeyMap[ImGuiKey.Y] = 16;
	io.KeyMap[ImGuiKey.Z] = 17;
	// return true;
}

last_cursor:ImGuiMouseCursor;
ImGui_ImplWasm_NewFrame :: (imguiPolygonContext: *ImguiPolygonContext, eventsData: EventsData) {
	assert(imguiPolygonContext.io != null, "imguiPolygonContext.io is null");
	io := ImGui.GetIO();

	io.DisplaySize = .{xx eventsData.windowSize.w, xx eventsData.windowSize.h};
	io.DisplayFramebufferScale = .{xx 1, xx 1};

	io.MousePos.x = xx eventsData.cursor.x;
	io.MousePos.y = xx eventsData.cursor.y;
	io.MouseDown[0] = eventsData.mouseButton.left;
	io.MouseDown[1] = eventsData.mouseButton.right;
	io.MouseDown[2] = eventsData.mouseButton.middle;
	io.MouseWheel = eventsData.wheel;
	io.KeyShift = eventsData.modifiers.shift;
	io.KeyCtrl  = eventsData.modifiers.ctrl;
	io.KeyAlt   = eventsData.modifiers.alt;
	io.KeySuper = eventsData.modifiers.meta;

	// we don't need to copy the full io.KeysDown for now
	memcpy(io.KeysDown.data, eventsData.keys.data, 18);

	io.AddInputCharactersUTF8(io, xx eventsData.text.data);

	cursor := ImGui.GetMouseCursor();
	if(cursor != last_cursor) {
		eventsSetCursor(xx cursor);
		last_cursor = cursor;
	}
}

qsort :: (basePointer: *void, nitems: u32, size: u32, comparePointer: *void) {
	// print("qsort native %,%,%,%\n", basePointer, nitems, size, comparePointer);
};
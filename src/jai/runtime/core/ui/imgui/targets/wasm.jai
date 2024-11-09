ImGui_ImplWasm_Init :: () {
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
ImGui_ImplWasm_NewFrame :: (events_data: *EventsData) {
	io := ImGui.GetIO();

	io.DisplaySize = .{xx events_data.windowSize.w, xx events_data.windowSize.h};
	io.DisplayFramebufferScale = .{xx 1, xx 1};

	io.MousePos.x = xx events_data.cursor.x;
	io.MousePos.y = xx events_data.cursor.y;
	io.MouseDown[0] = events_data.mouseButton.left;
	io.MouseDown[1] = events_data.mouseButton.right;
	io.MouseDown[2] = events_data.mouseButton.middle;
	io.MouseWheel = events_data.wheel;
	io.KeyShift = events_data.modifiers.shift;
	io.KeyCtrl  = events_data.modifiers.ctrl;
	io.KeyAlt   = events_data.modifiers.alt;
	io.KeySuper = events_data.modifiers.meta;

	// we don't need to copy the full io.KeysDown for now
	memcpy(io.KeysDown.data, events_data.keys.data, 18);

	io.AddInputCharactersUTF8(io, xx events_data.text.data);

	cursor := ImGui.GetMouseCursor();
	if(cursor != last_cursor) {
		eventsSetCursor(xx cursor);
		last_cursor = cursor;
	}
}

qsort :: (basePointer: *void, nitems: u32, size: u32, comparePointer: *void) {
	// print("qsort native %,%,%,%\n", basePointer, nitems, size, comparePointer);
};
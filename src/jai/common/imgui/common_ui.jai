WGPUColor32 :: struct {
	r: float;
	g: float;
	b: float;
	a: float;
}


gui_update :: (
	window_context: *WindowContext,
	wgpu_context: *WGPUContext,
	render_pass: WGPURenderPassEncoder,
	bd: *ImGui_ImplWGPU_Data,
	iwc: *ImGui_WGPU_Common,
	ui_data: *UiData,
	scene_data: *SceneData,
	events_data: *EventsData
){

	width := wgpu_texture_get_width_surface(wgpu_context);
	height := wgpu_texture_get_height_surface(wgpu_context);
	if (bd.resolution.width != width || bd.resolution.height != height || bd.pipeline==null) {
		// print_yellow(tprint("invalidate and create START: %x% -> %x%\n", bd.resolution.width, bd.resolution.height, width, height));
		ImGui_ImplWGPU_InvalidateDeviceObjects();
		ImGui_ImplWGPU_CreateDeviceObjects(bd, iwc, wgpu_context);
		// print_yellow("invalidate and create DONE");
		bd.resolution.width = width;
		bd.resolution.height = height;
	}

	#if WASM {
		ImGui_ImplWasm_NewFrame(events_data);
	} else {
		ImGui_ImplSdl_NewFrame(window_context.window, events_data);
	}
	ImGui.NewFrame();
	{

		ImGui.SetNextWindowSize(.{300, 600}, ImGuiCond.FirstUseEver);
		ImGui.Begin("SDF Controls");                          // Create a window called "Hello, world!" and append into it.

		ImGui.Text_CFormat("This is some useful text");               // Display some text (you can use a format string too)
		ImGui.Checkbox("Demo Window", *ui_data.show_demo_window);      // Edit bools storing our window open/close state
		ImGui.Checkbox("Another Window", *ui_data.show_another_window);

		// v3_array: [3]float = .[scene_data.sdf_data[0].offset.x, scene_data.sdf_data[0].offset.y, scene_data.sdf_data[0].offset.z];
		// ImGui.InputFloat3("offset", *v3_array);//, -1.0, 1.0);

		bg_color :WGPUColor32= .{
			r = xx wgpu_context.bg_color.r,
			g = xx wgpu_context.bg_color.g,
			b = xx wgpu_context.bg_color.b,
			a = xx wgpu_context.bg_color.a,
		};
		ImGui.Text_CFormat("BG Color");
		ImGui.SliderFloat("r", *bg_color.r, 0.0, 1.0);
		ImGui.SliderFloat("g", *bg_color.g, 0.0, 1.0);
		ImGui.SliderFloat("b", *bg_color.b, 0.0, 1.0);
		ImGui.SliderFloat("a", *bg_color.a, 0.0, 1.0);
		wgpu_context.bg_color.r = clamp(bg_color.r, 0.0, 1.0);
		wgpu_context.bg_color.g = clamp(bg_color.g, 0.0, 1.0);
		wgpu_context.bg_color.b = clamp(bg_color.b, 0.0, 1.0);
		wgpu_context.bg_color.a = clamp(bg_color.a, 0.0, 1.0);


		ImGui.Text_CFormat("Box Size");
		ImGui.SliderFloat("sx", *scene_data.box_size.x, 0.1, 5.0);
		ImGui.SliderFloat("sy", *scene_data.box_size.y, 0.1, 5.0);
		ImGui.SliderFloat("sz", *scene_data.box_size.z, 0.1, 5.0);

		ImGui.Text_CFormat("Position");
		// print("%\n", scene_data.sdf_data[0].offset.x);
		ImGui.SliderFloat("x", *scene_data.sdf_data[0].offset.x, -1.0, 1.0);
		ImGui.SliderFloat("y", *scene_data.sdf_data[0].offset.y, -1.0, 1.0);
		ImGui.SliderFloat("z", *scene_data.sdf_data[0].offset.z, -1.0, 1.0);

		ImGui.Text_CFormat("Offset");
		ImGui.SliderFloat("offset x", *scene_data.offset.x, -1.0, 1.0);
		ImGui.SliderFloat("offset y", *scene_data.offset.y, -1.0, 1.0);
		ImGui.SliderFloat("offset z", *scene_data.offset.z, -1.0, 1.0);

		// scene_data.sdf_data[0].offset.x = v3_array[0];
		// scene_data.sdf_data[0].offset.y = v3_array[1];
		// scene_data.sdf_data[0].offset.z = v3_array[2];

		if (ImGui.Button("Reset")) {
			scene_data.box_size.x = 1;
			scene_data.box_size.y = 1;
			scene_data.box_size.z = 1;
			scene_data.sdf_data[0].offset.x = 0;
			scene_data.sdf_data[0].offset.y = 0;
			scene_data.sdf_data[0].offset.z = 0;
		}
		ImGui.InputText("input text", scene_data.node_name.data, xx scene_data.node_name.count);
		// ImGui.ColorEdit3("clear color", clear_color); // Edit 3 floats representing a color

		// if (ImGui.Button("Button")==true){
		// 		ui_data.counter+=1;
		// }
		ImGui.SameLine();
		// ImGui.Text("counter = %d", *ui_data.counter);

		ImGui.End();
	}
	// if (ui_data.show_another_window) {
	// 	ImGui.SetNextWindowPos(.{400, 100}, ImGuiCond.Always);
	// 	ImGui.SetNextWindowSize(.{300, 100}, ImGuiCond.Always);
	// 	ImGui.Begin("Another Window", *ui_data.show_another_window);
	// 	ImGui.Text("Hello from another window!");
	// 	if (ImGui.Button("Close Me!")) {
	// 		ui_data.show_another_window = false;
	// 	}
	// 	ImGui.End();
	// }
	// if ui_data.show_demo_window {
	// 	ImGui.SetNextWindowPos(.{650, 20}, ImGuiCond.FirstUseEver, .{0,0}); // Normally user code doesn't need/want to call this because positions are saved in .ini file anyway. Here we just want to make the demo initial state a bit more friendly!
	// 	ImGui.ShowDemoWindow(*ui_data.show_demo_window);
	// }
	ImGui.EndFrame();
	ImGui.Render();
	draw_data := ImGui.GetDrawData();
	ImGui_ImplWGPU_RenderDrawData(*iwc.draw, draw_data, render_pass);
	events_data_clear_text(events_data);
}



// gui_update :: (
// 	window_context: *WindowContext,
// 	wgpu_context: *WGPUContext,
// 	render_pass: WGPURenderPassEncoder,
// 	bd: *ImGui_ImplWGPU_Data,
// 	iwc: *ImGui_WGPU_Common,
// 	ui_data: *UiData,
// 	scene_data: *SceneData
// ){

// 	width := wgpu_texture_get_width_surface(wgpu_context);
// 	height := wgpu_texture_get_height_surface(wgpu_context);
// 	if (bd.resolution.width != width || bd.resolution.height != height || bd.pipeline==null) {
// 		print_yellow("invalidate and create START");
// 		ImGui_ImplWGPU_InvalidateDeviceObjects();
// 		ImGui_ImplWGPU_CreateDeviceObjects(bd, iwc, wgpu_context);
// 		print_yellow("invalidate and create DONE");
// 		bd.resolution.width = width;
// 		bd.resolution.height = height;
// 	}

// 	// ImGui_ImplWGPU_NewFrame();
// 	#if WASM {
// 		ImGui_ImplWasm_NewFrame();
// 	} else {
// 		ImGui_ImplSdl_NewFrame(window_context.window);
// 	}
// 	ImGui.NewFrame();
// 	{

// 		ImGui.SetNextWindowSize(.{300, 600}, ImGuiCond.FirstUseEver);
// 		ImGui.Begin("SDF Controls");                          // Create a window called "Hello, world!" and append into it.

// 		ImGui.Text("This is some useful text.");               // Display some text (you can use a format string too)
// 		// ImGui.Checkbox("Demo Window", *show_demo_window);      // Edit bools storing our window open/close state
// 		ImGui.Checkbox("Another Window", *ui_data.show_another_window);

// 		// v3_array: [3]float = .[scene_data.sdf_data[0].offset.x, scene_data.sdf_data[0].offset.y, scene_data.sdf_data[0].offset.z];
// 		// ImGui.InputFloat3("offset", *v3_array);//, -1.0, 1.0);
// 		ImGui.Text("Box Size");
// 		ImGui.SliderFloat("sx", *scene_data.box_size.x, 0.1, 5.0);
// 		ImGui.SliderFloat("sy", *scene_data.box_size.y, 0.1, 5.0);
// 		ImGui.SliderFloat("sz", *scene_data.box_size.z, 0.1, 5.0);

// 		ImGui.Text("Position");
// 		print("%\n", scene_data.sdf_data[0].offset.x);
// 		ImGui.SliderFloat("x", *scene_data.sdf_data[0].offset.x, -1.0, 1.0);
// 		ImGui.SliderFloat("y", *scene_data.sdf_data[0].offset.y, -1.0, 1.0);
// 		ImGui.SliderFloat("z", *scene_data.sdf_data[0].offset.z, -1.0, 1.0);

// 		// scene_data.sdf_data[0].offset.x = v3_array[0];
// 		// scene_data.sdf_data[0].offset.y = v3_array[1];
// 		// scene_data.sdf_data[0].offset.z = v3_array[2];

// 		if (ImGui.Button("Reset")) {
// 			scene_data.box_size.x = 1;
// 			scene_data.box_size.y = 1;
// 			scene_data.box_size.z = 1;
// 			scene_data.sdf_data[0].offset.x = 0;
// 			scene_data.sdf_data[0].offset.y = 0;
// 			scene_data.sdf_data[0].offset.z = 0;
// 		}
// 		// ImGui.ColorEdit3("clear color", clear_color); // Edit 3 floats representing a color

// 		// if (ImGui.Button("Button")==true){
// 		// 		ui_data.counter+=1;
// 		// }
// 		ImGui.SameLine();
// 		ImGui.Text("counter = %d", *ui_data.counter);

// 		ImGui.End();
// 	}
// 	if (ui_data.show_another_window) {
// 		ImGui.Begin("Another Window", *ui_data.show_another_window);         // Pass a pointer to our bool variable (the window will have a closing button that will clear the bool when clicked)
// 		ImGui.Text("Hello from another window!");
// 		if (ImGui.Button("Close Me")) {
// 			ui_data.show_another_window = false;
// 		}
// 		ImGui.End();
// 	}
// 	ImGui.EndFrame();
// 	ImGui.Render();
// 	draw_data := ImGui.GetDrawData();
// 	ImGui_ImplWGPU_RenderDrawData(*iwc.draw, draw_data, render_pass);

// }

// gui_free :: (iwc: *ImGui_WGPU_Common){
// 	#if FREE_MEMORY {
// 		array_reset(*iwc.draw.im_draw_verts);
// 		array_reset(*iwc.draw.im_draw_idxs);
// 	}
// }
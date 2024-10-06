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

		ImGui.SetNextWindowSize(.{300, 900}, ImGuiCond.FirstUseEver);
		ImGui.SetNextWindowPos(.{0, 0}, ImGuiCond.FirstUseEver);
		ImGui.Begin("Controls");

		frame_rate_str := to_c_string(tprint("Frame Rate: %\n", ui_data.fps));
		defer free(frame_rate_str);
		ImGui.Text_CFormat(frame_rate_str);
		// ImGui.Checkbox("Demo Window", *ui_data.show_demo_window);      // Edit bools storing our window open/close state
		// ImGui.Checkbox("Another Window", *ui_data.show_another_window);


		bg_color :WGPUColor32= wgpu_color_32_create(scene_data.bg_color);
		ImGui.Text_CFormat("BG Color");
		ImGui.SliderFloat("r", *bg_color.r, 0.0, 1.0);
		ImGui.SliderFloat("g", *bg_color.g, 0.0, 1.0);
		ImGui.SliderFloat("b", *bg_color.b, 0.0, 1.0);
		ImGui.SliderFloat("a", *bg_color.a, 0.0, 1.0);
		color_set_from_wgpu_color_32(*scene_data.bg_color, *bg_color);



		ImGui.Text_CFormat("Box Size");
		ImGui.SliderFloat("sx", *scene_data.box_size.x, 0.1, 5.0);
		ImGui.SliderFloat("sy", *scene_data.box_size.y, 0.1, 5.0);
		ImGui.SliderFloat("sz", *scene_data.box_size.z, 0.1, 5.0);

		ImGui.Text_CFormat("Raymarching");
		ImGui.SliderFloat("sdf x", *MATERIAL_RAYMARCHING.uniforms.offset.x, -1.0, 1.0);
		ImGui.SliderFloat("sdf y", *MATERIAL_RAYMARCHING.uniforms.offset.y, -1.0, 1.0);
		ImGui.SliderFloat("sdf z", *MATERIAL_RAYMARCHING.uniforms.offset.z, -1.0, 1.0);

		ImGui.Text_CFormat("Offset");
		ImGui.SliderFloat("offset x", *scene_data.offset.x, -1.0, 1.0);
		ImGui.SliderFloat("offset y", *scene_data.offset.y, -1.0, 1.0);
		ImGui.SliderFloat("offset z", *scene_data.offset.z, -1.0, 1.0);

		ImGui.Text_CFormat("Segments");
		previous_segments := scene_data.segments;
		ImGui.SliderInt("segments x", *scene_data.segments.x, 1, 128);
		ImGui.SliderInt("segments y", *scene_data.segments.y, 1, 128);
		ImGui.SliderInt("segments z", *scene_data.segments.z, 1, 128);
		if( previous_segments != scene_data.segments){
			// print("updated: %x%x% = %\n", scene_data.segments.x, scene_data.segments.y, scene_data.segments.z, scene_data.segments.x*scene_data.segments.y*scene_data.segments.z);
			geometry_box_update(*scene_data.meshes0[0].geometry, xx scene_data.segments, scene_data.freq);
			pipeline_controller_mesh_update_draw_data(*PIPELINE_CONTROLLERS[0], *scene_data.meshes0[0]);
		}

		ImGui.Text_CFormat("Noise");
		previous_freq := scene_data.freq;
		ImGui.SliderFloat("freq x", *scene_data.freq.x, 0.01, 20);
		ImGui.SliderFloat("freq y", *scene_data.freq.y, 0.01, 20);
		ImGui.SliderFloat("freq z", *scene_data.freq.z, 0.01, 20);
		if(previous_freq != scene_data.freq){
			print("freq:%\n", scene_data.freq);
			geometry_box_update(*scene_data.meshes0[0].geometry, xx scene_data.segments, scene_data.freq);
			draw_data_update(*PIPELINE_CONTROLLERS[0], *PIPELINE_CONTROLLERS[0].meshes_draw_data[0], *scene_data.meshes0[0]);
		}

		if(scene_data.meshes0.count>=1){
			mesh00 := *scene_data.meshes0[0];
			ImGui.Text_CFormat("Mesh 0");
			ImGui.SliderFloat("tx 0", *mesh00.position.x, -2.0, 2.0);
			ImGui.SliderFloat("ty 0", *mesh00.position.y, -2.0, 2.0);
			ImGui.SliderFloat("tz 0", *mesh00.position.z, -2.0, 2.0);
			rx0, ry0, rz0, theta0 := get_axis_and_angle(*mesh00.quaternion);
			theta0_32: float32 = xx theta0;
			ImGui.SliderFloat("ry 0", *theta0_32, -PI, PI);
			ImGui.SliderFloat("sx 0", *mesh00.scale.x, 0.0, 2.0);
			ImGui.SliderFloat("sy 0", *mesh00.scale.y, 0.0, 2.0);
			ImGui.SliderFloat("sz 0", *mesh00.scale.z, 0.0, 2.0);
			set_from_axis_and_angle(*mesh00.quaternion, 0,1,0, theta0_32);
		}
		if(scene_data.meshes0.count>=2){
			mesh10 := *scene_data.meshes0[1];
			ImGui.Text_CFormat("Mesh 1");
			ImGui.SliderFloat("tx 1", *mesh10.position.x, -2.0, 2.0);
			ImGui.SliderFloat("ty 1", *mesh10.position.y, -2.0, 2.0);
			ImGui.SliderFloat("tz 1", *mesh10.position.z, -2.0, 2.0);
			rx1, ry1, rz1, theta1 := get_axis_and_angle(*mesh10.quaternion);
			theta1_32: float32 = xx theta1;
			ImGui.SliderFloat("ry 1", *theta1_32, -PI, PI);
			ImGui.SliderFloat("sx 1", *mesh10.scale.x, 0.0, 2.0);
			ImGui.SliderFloat("sy 1", *mesh10.scale.y, 0.0, 2.0);
			ImGui.SliderFloat("sz 1", *mesh10.scale.z, 0.0, 2.0);
			set_from_axis_and_angle(*mesh10.quaternion, 0,1,0, theta1_32);
		}
		for scene_data.meshes0 {
			mesh_update_matrix(*it);
		}
		for scene_data.meshes1 {
			mesh_update_matrix(*it);
		}

		if (ImGui.Button("Reset")) {
			scene_data.box_size.x = 1;
			scene_data.box_size.y = 1;
			scene_data.box_size.z = 1;
			// scene_data.sdf_data[0].offset.x = 0;
			// scene_data.sdf_data[0].offset.y = 0;
			// scene_data.sdf_data[0].offset.z = 0;
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


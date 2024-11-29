
renderUIFrameStart :: (renderer:*Renderer){
	bd := *BD;
	iwc := *IWC;
	// ui_data: *UiData = *UI_DATA;
	events_data: *EventsData = *EVENTS_DATA;

	width := wgpu_texture_get_width_surface(renderer.wgpu_context);
	height := wgpu_texture_get_height_surface(renderer.wgpu_context);
	if (bd.resolution.width != width || bd.resolution.height != height || bd.pipeline==null) {
		// print_yellow(tprint("invalidate and create START: %x% -> %x%\n", bd.resolution.width, bd.resolution.height, width, height));
		ImGui_ImplWGPU_InvalidateDeviceObjects();
		ImGui_ImplWGPU_CreateDeviceObjects(bd, iwc, renderer);
		// print_yellow("invalidate and create DONE");
		bd.resolution.width = width;
		bd.resolution.height = height;
	}

	#if WASM {
		ImGui_ImplWasm_NewFrame(events_data);
	} else {
		assert(renderer.wgpu_context.mode == .HEADLESS || WINDOW_CONTEXT.window != null, "WINDOW_CONTEXT.window is null");
		if renderer.wgpu_context.mode == .SURFACE {
			ImGui_ImplSdl_NewFrame(WINDOW_CONTEXT.window, events_data);
		}
	}
	ImGui.NewFrame();
}
renderUIFrameEnd :: (render_pass: WGPURenderPassEncoder){
	iwc := *IWC;
	events_data: *EventsData = *EVENTS_DATA;

	ImGui.EndFrame();
	ImGui.Render();
	draw_data := ImGui.GetDrawData();
	ImGui_ImplWGPU_RenderDrawData(*iwc.draw, draw_data, render_pass);
	events_data_clear_text(events_data);
}

// gui_update :: ( renderer:*Renderer, render_pass: WGPURenderPassEncoder ){
// 	#if WASM == false {
// 		if renderer.wgpu_context.mode == .HEADLESS {
// 			return;
// 		}
// 	}

	
// 	{

// 		ImGui.SetNextWindowSize(.{xx renderer.viewport.size.x, xx renderer.viewport.size.y}, .Always);
// 		ImGui.SetNextWindowPos(.{xx renderer.viewport.start.x, xx renderer.viewport.start.y}, .Always);
// 		ImGui.Begin("Controls");

// 		// frame_rate_str := to_c_string(tprint("Frame Rate: %\n", ui_data.fps));
// 		// defer free(frame_rate_str);
// 		// ImGui.Text_CFormat(frame_rate_str);
// 		// ImGui.Checkbox("Demo Window", *ui_data.show_demo_window);      // Edit bools storing our window open/close state
// 		// ImGui.Checkbox("Another Window", *ui_data.show_another_window);


// 		// bgColor :WGPUColor32= wgpu_color_32_create(scene_data.bgColor);
// 		// ImGui.Text_CFormat("BG Color");
// 		// ImGui.SliderFloat("r", *bgColor.r, 0.0, 1.0);
// 		// ImGui.SliderFloat("g", *bgColor.g, 0.0, 1.0);
// 		// ImGui.SliderFloat("b", *bgColor.b, 0.0, 1.0);
// 		// ImGui.SliderFloat("a", *bgColor.a, 0.0, 1.0);
// 		// color_set_from_wgpu_color_32(*scene_data.bgColor, *bgColor);



// 		// ImGui.Text_CFormat("Box Size");
// 		// ImGui.SliderFloat("sx", *scene.box_size.x, 0.1, 5.0);
// 		// ImGui.SliderFloat("sy", *scene.box_size.y, 0.1, 5.0);
// 		// ImGui.SliderFloat("sz", *scene.box_size.z, 0.1, 5.0);

// 		// ImGui.Text_CFormat("Raymarching");
// 		// ImGui.SliderFloat("sdf x", *MATERIAL_RAYMARCHING.uniforms.offset.x, -1.0, 1.0);
// 		// ImGui.SliderFloat("sdf y", *MATERIAL_RAYMARCHING.uniforms.offset.y, -1.0, 1.0);
// 		// ImGui.SliderFloat("sdf z", *MATERIAL_RAYMARCHING.uniforms.offset.z, -1.0, 1.0);

// 		// ImGui.Text_CFormat("Translate");
// 		// previous_translate := scene_data.translate;
// 		// ImGui.SliderFloat("translate x", *scene_data.translate.x, -1.0, 1.0);
// 		// ImGui.SliderFloat("translate y", *scene_data.translate.y, -1.0, 1.0);
// 		// ImGui.SliderFloat("translate z", *scene_data.translate.z, -1.0, 1.0);
// 		// if( previous_translate != scene_data.translate ){
// 		// 	compute_controller_update_buffer_translate(cast(*ComputeControllerTranslate)COMPUTE_CONTROLLER_COLLECTION.controllers[0], scene_data);
// 		// }

// 		// ImGui.Text_CFormat("Segments");
// 		// previous_segments := scene.segments;
// 		// ImGui.SliderInt("segments x", *scene.segments.x, 1, 128);
// 		// ImGui.SliderInt("segments y", *scene.segments.y, 1, 128);
// 		// ImGui.SliderInt("segments z", *scene.segments.z, 1, 128);
// 		// if( previous_segments != scene.segments ){
// 		// 	// print("updated: %x%x% = %\n", scene_data.segments.x, scene_data.segments.y, scene_data.segments.z, scene_data.segments.x*scene_data.segments.y*scene_data.segments.z);
// 		// 	// geometry_box_update(*scene_data.meshes0[0].geometry, xx scene_data.segments, scene_data.freq);
// 		// 	// pipeline_controller_mesh_update_draw_data(*PIPELINE_CONTROLLERS[0], *scene_data.meshes0[0]);
// 		// }

// 		// ImGui.Text_CFormat("Noise");
// 		// previous_freq := scene.noise.freq;
// 		// ImGui.SliderFloat("freq x", *scene.noise.freq.x, 0.01, 20);
// 		// ImGui.SliderFloat("freq y", *scene.noise.freq.y, 0.01, 20);
// 		// ImGui.SliderFloat("freq z", *scene.noise.freq.z, 0.01, 20);

// 		// previous_offset := scene.noise.offset;
// 		// ImGui.SliderFloat("offset x", *scene.noise.offset.x, -2, 2);
// 		// ImGui.SliderFloat("offset y", *scene.noise.offset.y, -2, 2);
// 		// ImGui.SliderFloat("offset z", *scene.noise.offset.z, -2, 2);

// 		// previous_amount := scene.noise.amount;
// 		// ImGui.SliderFloat("amount x", *scene.noise.amount.x, -2, 2);
// 		// ImGui.SliderFloat("amount y", *scene.noise.amount.y, -2, 2);
// 		// ImGui.SliderFloat("amount z", *scene.noise.amount.z, -2, 2);

// 		// if(
// 		// 	previous_freq != scene.noise.freq ||
// 		// 	previous_offset != scene.noise.offset ||
// 		// 	previous_amount != scene.noise.amount
// 		// ){
// 		// 	// geometry_add_noise(*scene_data.meshes0[0].geometry, scene_data.freq);
// 		// 	// draw_data_update(*PIPELINE_CONTROLLERS[0], *PIPELINE_CONTROLLERS[0].meshes_draw_data[0], *scene_data.meshes0[0]);
// 		// 	if renderer.computes.controllers.count > 0 {
// 		// 		controller := renderer.computes.controllers[0];
// 		// 		controller.update_buffer(controller, scene);
// 		// 	}
// 		// }

// 		// if(scene_data.meshes0.count>=1){
// 		// 	mesh00 := *scene_data.meshes0[0];
// 		// 	ImGui.Text_CFormat("Mesh 0");
// 		// 	previous_position := mesh00.position;
// 		// 	ImGui.SliderFloat("tx 0", *mesh00.position.x, -2.0, 2.0);
// 		// 	ImGui.SliderFloat("ty 0", *mesh00.position.y, -2.0, 2.0);
// 		// 	ImGui.SliderFloat("tz 0", *mesh00.position.z, -2.0, 2.0);
// 		// 	if(previous_position != mesh00.position){
// 		// 		PIPELINE_CONTROLLERS[0].uniforms_dirty = true;
// 		// 	}
// 		// 	rx0, ry0, rz0, theta0 := get_axis_and_angle(*mesh00.quaternion);
// 		// 	theta0_32: float32 = xx theta0;
// 		// 	ImGui.SliderFloat("ry 0", *theta0_32, -PI, PI);
// 		// 	ImGui.SliderFloat("sx 0", *mesh00.scale.x, 0.0, 2.0);
// 		// 	ImGui.SliderFloat("sy 0", *mesh00.scale.y, 0.0, 2.0);
// 		// 	ImGui.SliderFloat("sz 0", *mesh00.scale.z, 0.0, 2.0);
// 		// 	set_from_axis_and_angle(*mesh00.quaternion, 0,1,0, theta0_32);
// 		// }
// 		// if(scene_data.meshes0.count>=2){
// 		// 	mesh10 := *scene_data.meshes0[1];
// 		// 	ImGui.Text_CFormat("Mesh 1");
// 		// 	ImGui.SliderFloat("tx 1", *mesh10.position.x, -2.0, 2.0);
// 		// 	ImGui.SliderFloat("ty 1", *mesh10.position.y, -2.0, 2.0);
// 		// 	ImGui.SliderFloat("tz 1", *mesh10.position.z, -2.0, 2.0);
// 		// 	rx1, ry1, rz1, theta1 := get_axis_and_angle(*mesh10.quaternion);
// 		// 	theta1_32: float32 = xx theta1;
// 		// 	ImGui.SliderFloat("ry 1", *theta1_32, -PI, PI);
// 		// 	ImGui.SliderFloat("sx 1", *mesh10.scale.x, 0.0, 2.0);
// 		// 	ImGui.SliderFloat("sy 1", *mesh10.scale.y, 0.0, 2.0);
// 		// 	ImGui.SliderFloat("sz 1", *mesh10.scale.z, 0.0, 2.0);
// 		// 	set_from_axis_and_angle(*mesh10.quaternion, 0,1,0, theta1_32);
// 		// }
// 		// for scene_data.meshes0 {
// 		// 	mesh_update_matrix(*it);
// 		// }
// 		// for scene_data.meshes1 {
// 		// 	mesh_update_matrix(*it);
// 		// }
// 		// for scene_data.meshes2 {
// 		// 	mesh_update_matrix(*it);
// 		// }

// 		// if (ImGui.Button("Reset")) {
// 		// 	scene.box_size.x = 1;
// 		// 	scene.box_size.y = 1;
// 		// 	scene.box_size.z = 1;
// 		// 	// scene_data.sdf_data[0].offset.x = 0;
// 		// 	// scene_data.sdf_data[0].offset.y = 0;
// 		// 	// scene_data.sdf_data[0].offset.z = 0;
// 		// }
// 		// ImGui.InputText("input text", scene.node_name.data, xx scene.node_name.count);
// 		// ImGui.ColorEdit3("clear color", clear_color); // Edit 3 floats representing a color

// 		// if (ImGui.Button("Button")==true){
// 		// 		ui_data.counter+=1;
// 		// }
// 		// ImGui.SameLine();
// 		// ImGui.Text("counter = %d", *ui_data.counter);

// 		ImGui.End();
// 	}
// 	// if (ui_data.show_another_window) {
// 	// 	ImGui.SetNextWindowPos(.{400, 100}, ImGuiCond.Always);
// 	// 	ImGui.SetNextWindowSize(.{300, 100}, ImGuiCond.Always);
// 	// 	ImGui.Begin("Another Window", *ui_data.show_another_window);
// 	// 	ImGui.Text("Hello from another window!");
// 	// 	if (ImGui.Button("Close Me!")) {
// 	// 		ui_data.show_another_window = false;
// 	// 	}
// 	// 	ImGui.End();
// 	// }
// 	// if ui_data.show_demo_window {
// 	// 	ImGui.SetNextWindowPos(.{650, 20}, ImGuiCond.FirstUseEver, .{0,0}); // Normally user code doesn't need/want to call this because positions are saved in .ini file anyway. Here we just want to make the demo initial state a bit more friendly!
// 	// 	ImGui.ShowDemoWindow(*ui_data.show_demo_window);
// 	// }
	
// }


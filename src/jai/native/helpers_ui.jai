// UiInit :: struct {
// 	imgui_context : ImGuiContext;
// 	io :ImGuiIO;
// }
UiData :: struct {
	f:float = 0.0;
	counter:u32 = 0;
	show_another_window:bool = true;
}

// gui_init :: (window:*SDL_Window)->*ImGuiContext,*ImGuiIO{
// 	imgui_context := ImGui.CreateContext();
//     // Setup ImGui binding
//     ImGui_ImplSdl_Init(window);
//     // Setup style
//     // ImGuiStyleColorsClassic();
//     ImGui.StyleColorsDark();
//     //ImGui.StyleColorsLight();
//     io := ImGui.GetIO();

// 	return imgui_context, io;
// }


gui_update :: (
	window:*SDL_Window,
	wgpu_context: *WGPUContext,
	render_pass: WGPURenderPassEncoder,
	bd: *ImGui_ImplWGPU_Data,
	iwc: *ImGui_WGPU_Common,
	ui_data: *UiData
){

	width := wgpuTextureGetWidth(wgpu_context.surface_texture.texture);
	height := wgpuTextureGetHeight(wgpu_context.surface_texture.texture);
	if (bd.resolution.width != width || bd.resolution.height != height || bd.pipelineState==null) {
		print_yellow("invalidate and create START");
		ImGui_ImplWGPU_InvalidateDeviceObjects();
		ImGui_ImplWGPU_CreateDeviceObjects(bd, iwc);
		print_yellow("invalidate and create DONE");
		bd.resolution.width = width;
		bd.resolution.height = height;
	}

	// ImGui_ImplWGPU_NewFrame();
	ImGui_ImplSdl_NewFrame(window);
	ImGui.NewFrame();
	{

		ImGui.Begin("Hello, world!");                          // Create a window called "Hello, world!" and append into it.

		ImGui.Text("This is some useful text.");               // Display some text (you can use a format string too)
		// ImGui.Checkbox("Demo Window", *show_demo_window);      // Edit bools storing our window open/close state
		ImGui.Checkbox("Another Window", *ui_data.show_another_window);

		ImGui.SliderFloat("float", *ui_data.f, 0.0, 1.0);            // Edit 1 float using a slider from 0.0f to 1.0f
		// // ImGui.ColorEdit3("clear color", clear_color); // Edit 3 floats representing a color

		// if (ImGui.Button("Button")==true){
		// 		ui_data.counter+=1;
		// }
		ImGui.SameLine();
		ImGui.Text("counter = %d", *ui_data.counter);

		ImGui.End();
	}
	if (ui_data.show_another_window) {
		ImGui.Begin("Another Window", *ui_data.show_another_window);         // Pass a pointer to our bool variable (the window will have a closing button that will clear the bool when clicked)
		ImGui.Text("Hello from another window!");
		if (ImGui.Button("Close Me")) {
			ui_data.show_another_window = false;
		}
		ImGui.End();
	}
	ImGui.EndFrame();
	ImGui.Render();
	draw_data := ImGui.GetDrawData();
	ImGui_ImplWGPU_RenderDrawData(*iwc.draw, draw_data, render_pass);
}

gui_free :: (iwc: *ImGui_WGPU_Common){
	#if FREE_MEMORY {
		array_reset(*iwc.draw.im_draw_verts);
		array_reset(*iwc.draw.im_draw_idxs);
	}
}
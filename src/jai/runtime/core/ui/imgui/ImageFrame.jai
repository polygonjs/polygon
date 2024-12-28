
renderUIFrameStart :: (renderer:*Renderer, eventsData: EventsData, imguiPolygonContext: *ImguiPolygonContext){

	width := wgpu_texture_get_width_surface(renderer.wgpuContext);
	height := wgpu_texture_get_height_surface(renderer.wgpuContext);
	if (imguiPolygonContext.bd.resolution.width != width || imguiPolygonContext.bd.resolution.height != height || imguiPolygonContext.bd.pipeline==null) {
		ImGui_ImplWGPU_InvalidateDeviceObjects(*imguiPolygonContext.bd);
		ImGui_ImplWGPU_CreateDeviceObjects(imguiPolygonContext, renderer);
		imguiPolygonContext.bd.resolution.width = width;
		imguiPolygonContext.bd.resolution.height = height;
	}

	#if WASM {
		ImGui_ImplWasm_NewFrame(imguiPolygonContext, eventsData, renderer.wgpuContext);
	} else {
		assert(renderer.wgpuContext.mode == .HEADLESS || imguiPolygonContext.windowContext.window != null, "imguiPolygonContext.windowContext.window is null");
		if renderer.wgpuContext.mode == .SURFACE {
			ImGui_ImplSdl_NewFrame(imguiPolygonContext, eventsData);
		}
	}
	ImGui.NewFrame();
}
renderUIFrameEnd :: (renderPass: WGPURenderPassEncoder, imguiPolygonContext: *ImguiPolygonContext){
	ImGui.EndFrame();
	ImGui.Render();
	drawData := ImGui.GetDrawData();
	ImGui_ImplWGPU_RenderDrawData(imguiPolygonContext, drawData, renderPass);
}

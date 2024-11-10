renderer_init_ui :: (renderer:*Renderer){
	#if USE_IMGUI {
		bd := *BD;
		ImGui.CreateContext(null);

		#if WASM {
			io := ImGui.GetIO();
			io.IniFilename = null;
			ImGui_ImplWasm_Init();
		}

		// imgui_style := ImGui.GetStyle();
		// imgui_style.AntiAliasedLinesUseTex = false;
		// ImGui.StyleColorsLight();

		bd.wgpuDevice = WGPU_CONTEXT.device;
		imgui_init_info := ImGui_ImplWGPU_InitInfo.{
			// Device = wgpu_context.device,
			NumFramesInFlight = 3,
			RenderTargetFormat = WGPU_CONTEXT.preferred_texture_format,
			DepthStencilFormat = ifx renderer.use_depth_buffer then DEPTH_TEXTURE_FORMAT else WGPUTextureFormat.Undefined,
		};
		ImGui_ImplWGPU_Init(bd, imgui_init_info);
	}
}
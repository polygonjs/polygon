rendererInitUI :: (use_depth_buffer:bool){
	#if USE_IMGUI {
		if IMGUI_INITIALIZED {
			return;
		}
		IMGUI_INITIALIZED = true;

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
			DepthStencilFormat = ifx use_depth_buffer then DEPTH_TEXTURE_FORMAT else WGPUTextureFormat.Undefined,
		};
		ImGui_ImplWGPU_Init(bd, imgui_init_info);
	}
}

renderUIStart :: (data:*RenderCollectionData, renderer: *Renderer)->(cmdEncoder:WGPUCommandEncoder, renderPassEncoder:WGPURenderPassEncoder) {
	create_multi_sample_texture_if_needed( renderer );
	create_depth_texture_if_needed( renderer );
	device := WGPU_CONTEXT.device;

	colorAttachment := WGPURenderPassColorAttachment.{
		loadOp = ifx renderer.clear then WGPULoadOp.Clear else WGPULoadOp.Load,
		storeOp = WGPUStoreOp.Store,
		clearValue = wgpu_color_create(renderer.bgColor),
	};

	update_render_pass_descriptor_multisample(renderer, *colorAttachment, *data.frame);

	cmdEncoder :WGPUCommandEncoder= wgpuDeviceCreateCommandEncoder(
		WGPU_CONTEXT.device,
		*(WGPUCommandEncoderDescriptor.{label = "Command Encoder Render"}),
	);
	

	renderPassDescriptorLabel := tprint("Render Pass UI %", WGPU_CONTEXT.framesCount,, temp);
	renderPassDescriptorLabel_c := to_c_string_temp(renderPassDescriptorLabel);
	render_pass_descriptor := WGPURenderPassDescriptor.{
		label = renderPassDescriptorLabel_c,
		colorAttachmentCount = 1,
		colorAttachments = *colorAttachment,
	};
	update_render_pass_descriptor_depth(renderer, *render_pass_descriptor);

	renderPassEncoder :WGPURenderPassEncoder= wgpuCommandEncoderBeginRenderPass(cmdEncoder, *render_pass_descriptor);
	

	return cmdEncoder, renderPassEncoder;
}
renderUIEnd :: (data:*RenderCollectionData, renderer: *Renderer, cmdEncoder:WGPUCommandEncoder, renderPassEncoder: WGPURenderPassEncoder) {

	wgpuRenderPassEncoderEnd(renderPassEncoder);

	cmdBuffer1Label := to_c_string_temp(tprint("% %", renderer.label, WGPU_CONTEXT.framesCount));
	cmdBuffer1 := wgpuCommandEncoderFinish(cmdEncoder, *(WGPUCommandBufferDescriptor.{label = cmdBuffer1Label}));
	defer wgpuCommandBufferRelease(cmdBuffer1);

	wgpuQueueSubmit(data.queue, 1, *cmdBuffer1);

	defer wgpuCommandEncoderRelease(cmdEncoder);
	defer wgpuRenderPassEncoderRelease(renderPassEncoder);
}
// renderUI :: (data:*RenderCollectionData, renderer: *Renderer){
// 	gui_update(renderer, render_pass_encoder, *WGPU_CONTEXT);
// }

#scope_file

IMGUI_INITIALIZED :bool = false;
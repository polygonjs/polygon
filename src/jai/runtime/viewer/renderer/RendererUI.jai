rendererInitUI :: (wgpuContext: *WGPUContext, imguiPolygonContext: *ImguiPolygonContext, useDepthBuffer:bool){
	#if USE_IMGUI {
		imguiPolygonContextInit(imguiPolygonContext);
		imguiPolygonContextWGPUInit(imguiPolygonContext, wgpuContext, useDepthBuffer);
	}
}
rendererUIDestroy :: (imguiPolygonContext: *ImguiPolygonContext) {
	#if USE_IMGUI {
		ImGui_ImplWGPU_Shutdown(imguiPolygonContext);
	}
}

renderUIStart :: (data:*RenderCollectionData, renderer: *Renderer)->(cmdEncoder:WGPUCommandEncoder, renderPassEncoder:WGPURenderPassEncoder) {
	create_multi_sample_texture_if_needed( renderer );
	create_depth_texture_if_needed( renderer );
	device := renderer.wgpuContext.device;

	colorAttachment := WGPURenderPassColorAttachment.{
		loadOp = ifx renderer.clear then WGPULoadOp.Clear else WGPULoadOp.Load,
		storeOp = WGPUStoreOp.Store,
		clearValue = wgpu_color_create(renderer.bgColor),
	};

	update_render_pass_descriptor_multisample(renderer, *colorAttachment, *data.frame);

	cmdEncoder :WGPUCommandEncoder= wgpuDeviceCreateCommandEncoder(
		renderer.wgpuContext.device,
		*(WGPUCommandEncoderDescriptor.{label = "Command Encoder Render"}),
	);
	

	renderPassDescriptorLabel := tprint("Render Pass UI %", renderer.wgpuContext.framesCount,, temp);
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

	cmdBuffer1Label := to_c_string_temp(tprint("% %", renderer.label, renderer.wgpuContext.framesCount));
	cmdBuffer1 := wgpuCommandEncoderFinish(cmdEncoder, *(WGPUCommandBufferDescriptor.{label = cmdBuffer1Label}));
	defer wgpuCommandBufferRelease(cmdBuffer1);

	wgpuQueueSubmit(data.queue, 1, *cmdBuffer1);

	defer wgpuCommandEncoderRelease(cmdEncoder);
	defer wgpuRenderPassEncoderRelease(renderPassEncoder);
}
// renderUI :: (data:*RenderCollectionData, renderer: *Renderer){
// 	gui_update(renderer, render_pass_encoder, renderer.wgpuContext);
// }

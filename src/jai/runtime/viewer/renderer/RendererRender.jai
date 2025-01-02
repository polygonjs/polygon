rendererPreRender :: inline (renderer:*Renderer) {
	rendererFlushCommands(renderer);
	// cameraUniformsUpdate(camera);
}

render :: (data:*RenderCollectionData, renderer: *Renderer, scene:*Scene){
	rendererPreRender(renderer);

	create_multi_sample_texture_if_needed( renderer );
	create_depth_texture_if_needed( renderer );
	device := renderer.wgpuContext.device;

	colorAttachment := WGPURenderPassColorAttachment.{
		loadOp = ifx renderer.clear then WGPULoadOp.Clear else WGPULoadOp.Load,
		storeOp = WGPUStoreOp.Store,
		clearValue = wgpu_color_create(renderer.bgColor),
	};

	updateRenderPassDescriptorMultisample(renderer, *colorAttachment, data.frame);

	cmdEncoderLabel := tprint("Command Encoder %", renderer.label,, temp);
	cmdEncoderLabel_c := to_c_string_temp(cmdEncoderLabel);
	cmdEncoder := wgpuDeviceCreateCommandEncoder(
		device,
		*(WGPUCommandEncoderDescriptor.{label = cmdEncoderLabel_c}),
	);
	defer wgpuCommandEncoderRelease(cmdEncoder);

	renderPassDescriptorLabel := tprint("Render Pass 3D %", renderer.wgpuContext.framesCount,, temp);
	renderPassDescriptorLabel_c := to_c_string_temp(renderPassDescriptorLabel);
	// defer free(renderPassDescriptorLabel_c);
	renderPassDescriptor := WGPURenderPassDescriptor.{
		label = renderPassDescriptorLabel_c,
		colorAttachmentCount = 1,
		colorAttachments = *colorAttachment,
	};
	update_render_pass_descriptor_depth(renderer, *renderPassDescriptor);

	compute_controller_collection_compute(*renderer.computes);

	rendererSceneUniformBufferUpdate(renderer, scene, scene.sceneUniforms);
	
	for renderer.pipelines_by_mat_type {
		// pipelineControllerUpdateRenderableUniformBuffers(it);
		pipelineControllerUpdateMaterialUniformBuffers(it);
	}
	
	// if(renderer.fullScreen == false && renderer.clearViewport == true) {
	// 	using renderer.viewport;
	// 	// Create a separate render pass for clearing the viewport
	// 	clearColorAttachment := WGPURenderPassColorAttachment.{
	// 		view = data.frame,
	// 		resolveTarget = null,
	// 		loadOp = WGPULoadOp.Clear,
	// 		storeOp = WGPUStoreOp.Store,
	// 		clearValue = wgpu_color_create(renderer.bgColor),
	// 	};
	// 	// updateRenderPassDescriptorMultisample(renderer, *clearColorAttachment, data.frame);
	// 	// Add depth attachment for clearing
	// 	// clear_depth_attachment := WGPURenderPassDepthStencilAttachment.{
	// 	// 	view = renderer.wgpuContext.depthTextureView,
	// 	// 	depthLoadOp = WGPULoadOp.Clear,
	// 	// 	depthStoreOp = WGPUStoreOp.Store,
	// 	// 	depthClearValue = 1.0,  // Clear to the furthest depth
	// 	// 	stencilLoadOp = WGPULoadOp.Clear,
	// 	// 	stencilStoreOp = WGPUStoreOp.Store,
	// 	// 	stencilClearValue = 0,
	// 	// };
	// 	clearRenderPassDescriptor := WGPURenderPassDescriptor.{
	// 		label = "Clear Viewport Pass",
	// 		colorAttachmentCount = 1,
	// 		colorAttachments = *clearColorAttachment,
	// 		depthStencilAttachment = *renderer.wgpuContext.depthTextureStencilAttachment,
	// 	};
	// 	clearPassEncoder := wgpuCommandEncoderBeginRenderPass(cmdEncoder, *clearRenderPassDescriptor);
	// 	set_viewport(clearPassEncoder, xx start.x, xx start.y, xx size.x, xx size.y);
	// 	set_scissor_rect(clearPassEncoder, xx start.x, xx start.y, xx size.x, xx size.y);
	// 	wgpuRenderPassEncoderEnd(clearPassEncoder);
	// }

	renderPassEncoder := wgpuCommandEncoderBeginRenderPass(cmdEncoder, *renderPassDescriptor);
	defer wgpuRenderPassEncoderRelease(renderPassEncoder);
	if(renderer.fullScreen == false) {
		using renderer.viewport;
		// renderer_set_viewport(render_pass_encoder, start.x, start.y, size.x, size.y);
		set_viewport(renderPassEncoder, xx start.x, xx start.y, xx size.x, xx size.y);
		// Clear only the viewport area
		set_scissor_rect(renderPassEncoder, xx start.x, xx start.y, xx size.x, xx size.y);
	}


	for renderer.pipelines_by_mat_type pipelineControllerUpdateRenderPass(it, renderPassEncoder);
	// #if USE_IMGUI {
	// 	if renderer.render_ui {
	// 		gui_update(renderer, scene, render_pass_encoder, *rendererwgpuContext);
	// 	}
	// }
	wgpuRenderPassEncoderEnd(renderPassEncoder);

	cmd_buffer1_label := to_c_string_temp(tprint("% %", renderer.label, renderer.wgpuContext.framesCount));
	// defer free(cmd_buffer1_label);
	cmd_buffer1 := wgpuCommandEncoderFinish(cmdEncoder, *(WGPUCommandBufferDescriptor.{label = cmd_buffer1_label}));
	defer wgpuCommandBufferRelease(cmd_buffer1);

	wgpuQueueSubmit(data.queue, 1, *cmd_buffer1);

}

rendererFormat :: (renderer:*Renderer) -> WGPUTextureFormat {
	if renderer.useReadback {
		return .BGRA8Unorm; // .RGBA32Uint; // could potentially work with RGBA32Float
	} else {
		return renderer.wgpuContext.preferred_texture_format;
	}
}
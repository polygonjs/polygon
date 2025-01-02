rendererPreRender :: inline (renderer:*Renderer, camera:*Camera) {
	rendererFlushCommands(renderer);
	// cameraUniformsUpdate(camera);
}

render :: (data:*RenderCollectionData, renderer: *Renderer, scene:*Scene, camera: *Camera){
	rendererPreRender(renderer, camera);

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
	cmd_encoder := wgpuDeviceCreateCommandEncoder(
		device,
		*(WGPUCommandEncoderDescriptor.{label = cmdEncoderLabel_c}),
	);
	defer wgpuCommandEncoderRelease(cmd_encoder);

	renderPassDescriptorLabel := tprint("Render Pass 3D %", renderer.wgpuContext.framesCount,, temp);
	renderPassDescriptorLabel_c := to_c_string_temp(renderPassDescriptorLabel);
	// defer free(renderPassDescriptorLabel_c);
	render_pass_descriptor := WGPURenderPassDescriptor.{
		label = renderPassDescriptorLabel_c,
		colorAttachmentCount = 1,
		colorAttachments = *colorAttachment,
	};
	update_render_pass_descriptor_depth(renderer, *render_pass_descriptor);

	compute_controller_collection_compute(*renderer.computes);

	renderer_scene_uniform_buffer_update(renderer, scene, scene.sceneUniforms);
	
	for renderer.pipelines_by_mat_type {
		// pipelineControllerUpdateRenderableUniformBuffers(it);
		pipelineControllerUpdateMaterialUniformBuffers(it);
	}
	
	// if(renderer.fullScreen == false) {
	// 	using renderer.viewport;
	// 	// Create a separate render pass for clearing the viewport
	// 	clear_color_attachment := WGPURenderPassColorAttachment.{
	// 		view = data.frame,
	// 		resolveTarget = null,
	// 		loadOp = WGPULoadOp.Clear,
	// 		storeOp = WGPUStoreOp.Store,
	// 		clearValue = wgpu_color_create(renderer.bgColor),
	// 	};
	// 	clear_render_pass_descriptor := WGPURenderPassDescriptor.{
	// 		label = "Clear Viewport Pass",
	// 		colorAttachmentCount = 1,
	// 		colorAttachments = *clear_color_attachment,
	// 	};
	// 	clear_pass_encoder := wgpuCommandEncoderBeginRenderPass(cmd_encoder, *clear_render_pass_descriptor);
	// 	set_viewport(clear_pass_encoder, start.x, start.y, size.x, size.y);
	// 	set_scissor_rect(clear_pass_encoder, xx start.x, xx start.y, xx size.x, xx size.y);
	// 	wgpuRenderPassEncoderEnd(clear_pass_encoder);
	// }

	render_pass_encoder := wgpuCommandEncoderBeginRenderPass(cmd_encoder, *render_pass_descriptor);
	defer wgpuRenderPassEncoderRelease(render_pass_encoder);
	if(renderer.fullScreen == false) {
		using renderer.viewport;
		// renderer_set_viewport(render_pass_encoder, start.x, start.y, size.x, size.y);
		set_viewport(render_pass_encoder, xx start.x, xx start.y, xx size.x, xx size.y);
		// Clear only the viewport area
		set_scissor_rect(render_pass_encoder, xx start.x, xx start.y, xx size.x, xx size.y);
	}


	for renderer.pipelines_by_mat_type pipeline_controller_update_render_pass(it, render_pass_encoder);
	// #if USE_IMGUI {
	// 	if renderer.render_ui {
	// 		gui_update(renderer, scene, render_pass_encoder, *rendererwgpuContext);
	// 	}
	// }
	wgpuRenderPassEncoderEnd(render_pass_encoder);

	cmd_buffer1_label := to_c_string_temp(tprint("% %", renderer.label, renderer.wgpuContext.framesCount));
	// defer free(cmd_buffer1_label);
	cmd_buffer1 := wgpuCommandEncoderFinish(cmd_encoder, *(WGPUCommandBufferDescriptor.{label = cmd_buffer1_label}));
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
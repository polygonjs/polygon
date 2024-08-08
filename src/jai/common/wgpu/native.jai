

wgpu_create_shader_module :: (device: WGPUDevice, source: string, label :string) -> WGPUShaderModule {
	wgslDescriptor: WGPUShaderModuleWGSLDescriptor;
	wgslDescriptor.chain.next = null;
	wgslDescriptor.chain.sType=.ShaderModuleWGSLDescriptor;
	wgslDescriptor.code = to_c_string(source);
	#if FREE_MEMORY defer free(wgslDescriptor.code);

	shaderModuleDescriptor: WGPUShaderModuleDescriptor;
	shaderModuleDescriptor.label = to_c_string(label);
	#if FREE_MEMORY defer free(shaderModuleDescriptor.label);
	shaderModuleDescriptor.nextInChain = xx *wgslDescriptor;
	shader_module := wgpuDeviceCreateShaderModule(device, *shaderModuleDescriptor);


	return shader_module;
}



// wgpu_create_pipeline_layout :: (device:WGPUDevice, pipeline_layout_descriptor: *WGPUPipelineLayoutDescriptor)->WGPUPipelineLayout {
// 	return wgpuDeviceCreatePipelineLayout(device, pipeline_layout_descriptor);
// }

wgpu_texture_get_width_surface :: (wgpu_context: *WGPUContext) -> u32 {
	return wgpuTextureGetWidth(wgpu_context.surface_texture.texture);
}
wgpu_texture_get_height_surface :: (wgpu_context: *WGPUContext) -> u32 {
	return wgpuTextureGetHeight(wgpu_context.surface_texture.texture);
}

wgpu_device_create_render_pipeline :: (device: WGPUDevice, pipeline_descriptor: *WGPURenderPipelineDescriptor) -> WGPURenderPipeline {
	return wgpuDeviceCreateRenderPipeline(wgpu_context.device, *pipeline_descriptor);
}

// wgpu_device_create_buffer :: (device: WGPUDevice, descriptor: *WGPUBufferDescriptor) -> WGPUBuffer {
// 	return wgpuDeviceCreateBuffer(device, descriptor);
// }
// wgpu_queue_write_buffer :: (queue: WGPUQueue, buffer: WGPUBuffer, bufferOffset: u64, data: *void, size: u64) -> void {
// 	return wgpuQueueWriteBuffer(queue, buffer, bufferOffset, vertices.data, size);
// }
// wgpu_render_pipeline_get_bind_group_layout :: (pipeline: WGPURenderPipeline, index: u32) -> WGPUBindGroupLayout {
// 	return wgpuRenderPipelineGetBindGroupLayout(pipeline, 0);
// }

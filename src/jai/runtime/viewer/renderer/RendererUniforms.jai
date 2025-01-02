
renderer_scene_uniform_buffer_assign :: (renderer: *Renderer, pipeline: WGPURenderPipeline, bind_group_layout_index: u32) {
	renderer_uniform_buffer_assign(renderer, pipeline, *renderer.scene_data, bind_group_layout_index, "scene");
}
renderer_camera_uniform_buffer_assign :: (renderer: *Renderer, pipeline: WGPURenderPipeline, bind_group_layout_index: u32) {
	renderer_uniform_buffer_assign(renderer, pipeline, *renderer.camera_data, bind_group_layout_index, "camera");
}

renderer_uniform_buffer_create :: (renderer: *Renderer, buffer_data: *RendererBufferData, uniforms: $UniformType, label: string) {
	assert(renderer.wgpuContext != null, "renderer.wgpuContext is null");
	// TODO: This is a hack to make sure the buffer is at least 16 bytes
	size := cast(u64) max( 16, size_of(UniformType));

	buffer_label := to_c_string_temp(label);
	buffer_desc: WGPUBufferDescriptor = .{
		usage = xx (WGPUBufferUsage.Uniform | WGPUBufferUsage.CopyDst),
		size = size,
		label = buffer_label,
	};
	buffer := wgpuDeviceCreateBuffer(renderer.wgpuContext.device, *buffer_desc);
	assert(buffer != null, "Buffer is not created correctly");

	wgpuQueueWriteBuffer(renderer.wgpuContext.queue, buffer, 0, *uniforms, size);

	buffer_data.buffer_container = .{buffer=buffer, buffer_size=size};
}

renderer_scene_uniform_buffer_create :: (renderer: *Renderer, scene:*Scene) {
	renderer_uniform_buffer_create(renderer, *renderer.scene_data, scene.sceneUniforms, "scene");
}
renderer_camera_uniform_buffer_create :: (renderer: *Renderer, camera:*CameraAny) {
	renderer_uniform_buffer_create(renderer, *renderer.camera_data, camera.cameraUniforms, "camera");
}

rendererSceneUniformBufferUpdate :: (renderer: *Renderer, scene:*Scene, uniforms: $UniformType){
	wgpuQueueWriteBuffer(renderer.wgpuContext.queue, renderer.scene_data.buffer_container.buffer, 0, *scene.sceneUniforms, size_of(UniformType));
}
renderer_camera_uniform_buffer_update :: (renderer: *Renderer, camera:*CameraAny, uniforms: $UniformType){
	wgpuQueueWriteBuffer(renderer.wgpuContext.queue, renderer.camera_data.buffer_container.buffer, 0, *camera.cameraUniforms, size_of(UniformType));
}

#scope_file

renderer_uniform_buffer_assign :: (renderer: *Renderer, pipeline: WGPURenderPipeline, buffer_data:*RendererBufferData, bind_group_layout_index: u32, label: string) {
	assert(buffer_data.buffer_container.buffer_size>0, tprint("% buffer_size is 0\n", label));
	entries := NewArray(1, WGPUBindGroupEntry,, temp);
	entries[0] = WGPUBindGroupEntry.{
		binding=0,
		size=buffer_data.buffer_container.buffer_size,
		offset=0,
		buffer=buffer_data.buffer_container.buffer,
	};
	bind_group_descriptor_label := tprint("renderer_uniform_buffer_assign:uniforms_bind_group/%", label);
	bind_group_descriptor_label_c := to_c_string_temp(bind_group_descriptor_label);
	bind_group_descriptor := WGPUBindGroupDescriptor.{
		label = bind_group_descriptor_label_c,
		layout = wgpuRenderPipelineGetBindGroupLayout(pipeline, bind_group_layout_index),
		entryCount = xx entries.count,
		entries = entries.data
	};
	bind_group := wgpuDeviceCreateBindGroup(renderer.wgpuContext.device, *bind_group_descriptor);

	buffer_data.bind_group = bind_group;
	buffer_data.bind_group_entries = entries;
}
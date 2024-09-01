wgpu_object_uniform_to_buffer :: (
	wgpu_context: *WGPUContext,
	pipeline: WGPURenderPipeline,
	uniforms: Object3DUniforms
) -> WGPUBuffer, WGPUBindGroup, []WGPUBindGroupEntry {
	// TODO: This is a hack to make sure the buffer is at least 16 bytes
	size := max( cast(u64)16, cast(u64) 1 * size_of(Object3DUniforms));

	buffer_desc: WGPUBufferDescriptor = .{
		usage = xx (WGPUBufferUsage.Uniform | WGPUBufferUsage.CopyDst),
		size = size
	};
	buffer := wgpuDeviceCreateBuffer(wgpu_context.device, *buffer_desc);
	assert(buffer != null, "Buffer is not created correctly");

	wgpuQueueWriteBuffer(wgpu_context.queue, buffer, 0, *uniforms, size);

	entries := NewArray(1, WGPUBindGroupEntry);
	entries[0] = WGPUBindGroupEntry.{
		binding=0,
		size=size,
		offset=0,
		buffer=buffer,
	};
	bind_group_descriptor := WGPUBindGroupDescriptor.{
		label = "uniforms_bind_group/object",
		layout = wgpuRenderPipelineGetBindGroupLayout(pipeline, 0),
		entryCount = xx entries.count,
		entries = entries.data
	};
	bind_group := wgpuDeviceCreateBindGroup(wgpu_context.device, *bind_group_descriptor);

	return buffer, bind_group, entries;
}

wgpu_camera_uniform_to_buffer :: (
	wgpu_context: *WGPUContext,
	pipeline: WGPURenderPipeline,
	uniforms: [1]CameraUniforms
) -> WGPUBuffer,  WGPUBindGroup, []WGPUBindGroupEntry {
	// TODO: This is a hack to make sure the buffer is at least 16 bytes
	size := max( cast(u64)16, cast(u64) uniforms.count * size_of(CameraUniforms));

	buffer := wgpuDeviceCreateBuffer(wgpu_context.device, *(WGPUBufferDescriptor.{
		usage = xx (WGPUBufferUsage.Uniform | WGPUBufferUsage.CopyDst),
		size = size
	}));
	assert(buffer != null, "Buffer is not created correctly");

	wgpuQueueWriteBuffer(wgpu_context.queue, buffer, 0, uniforms.data, size);

	entries := NewArray(1, WGPUBindGroupEntry); // TODO: free this
	entries[0] = WGPUBindGroupEntry.{
		binding=0,
		size=size,
		offset=0,
		buffer=buffer,
	};
	// entries[1] = WGPUBindGroupEntry.{
	// 	binding=0,
	// 	size=size_of(Matrix4),
	// 	offset=size_of(Matrix4),
	// 	buffer=buffer,
	// };
	bind_group_descriptor := WGPUBindGroupDescriptor.{
		label = "uniforms_bind_group/camera",
		layout = wgpuRenderPipelineGetBindGroupLayout(pipeline, 1),
		entryCount = xx entries.count,
		entries = entries.data
	};
	bind_group := wgpuDeviceCreateBindGroup(wgpu_context.device, *bind_group_descriptor);

	return buffer, bind_group, entries;
}


wgpu_sdf_uniform_to_buffer :: (
	wgpu_context: *WGPUContext,
	pipeline: WGPURenderPipeline,
	uniforms: [1]SDFUniforms
) -> WGPUBuffer, WGPUBindGroup, []WGPUBindGroupEntry {
	// the difference with camera_uniform_to_buffer are:
	// 1. the uniforms argument
	// 2. the size_of(SDFUniforms) instead of size_of(CameraUniforms)
	// 3. the wgpuRenderPipelineGetBindGroupLayout(pipeline, <number>)

	// TODO: This is a hack to make sure the buffer is at least 16 bytes
	size := max( cast(u64)16, cast(u64) uniforms.count * size_of(SDFUniforms));

	buffer_desc: WGPUBufferDescriptor = .{
		usage = xx (WGPUBufferUsage.Uniform | WGPUBufferUsage.CopyDst),
		size = size
	};
	buffer := wgpuDeviceCreateBuffer(wgpu_context.device, *buffer_desc);
	assert(buffer != null, "Buffer is not created correctly");

	wgpuQueueWriteBuffer(wgpu_context.queue, buffer, 0, uniforms.data, size);

	entries := NewArray(1, WGPUBindGroupEntry);
	entries[0] = WGPUBindGroupEntry.{
		binding=0,
		size=size,
		offset=0,
		buffer=buffer,
	};
	// entries[1] = WGPUBindGroupEntry.{
	// 	binding=0,
	// 	size=size_of(Matrix4),
	// 	offset=size_of(Matrix4),
	// 	buffer=buffer,
	// };
	bind_group_descriptor := WGPUBindGroupDescriptor.{
		label = "uniforms_bind_group/sdf",
		layout = wgpuRenderPipelineGetBindGroupLayout(pipeline, 2),
		entryCount = xx entries.count,
		entries = entries.data
	};
	bind_group := wgpuDeviceCreateBindGroup(wgpu_context.device, *bind_group_descriptor);

	return buffer, bind_group, entries;
}

update_object_uniforms_to_buffer :: (wgpu_context: *WGPUContext, buffer:WGPUBuffer, mesh: *Mesh) {
	// TODO: This is a hack to make sure the buffer is at least 16 bytes
	// size := cast(u64) /*vertices.count **/ size_of(ObjectUniforms);
	size := max( cast(u64)16, cast(u64) /*uniforms.count **/ size_of(Object3DUniforms));
	wgpuQueueWriteBuffer(wgpu_context.queue, buffer, 0, *mesh.uniforms, size);
}


update_camera_uniforms_to_buffer :: (wgpu_context: *WGPUContext, buffer:WGPUBuffer, scene_data: *SceneData) {
	// TODO: This is a hack to make sure the buffer is at least 16 bytes
	// size := cast(u64) /*vertices.count **/ size_of(ObjectUniforms);
	size := max( cast(u64)16, cast(u64) size_of(CameraUniforms));
	wgpuQueueWriteBuffer(wgpu_context.queue, buffer, 0, scene_data.camera_uniforms.data, size);
}


update_sdf_uniforms_to_buffer :: (wgpu_context: *WGPUContext, buffer:WGPUBuffer, scene_data: *SceneData) {
	// TODO: This is a hack to make sure the buffer is at least 16 bytes
	// size := cast(u64) /*vertices.count **/ size_of(ObjectUniforms);
	size := max( cast(u64)16, cast(u64) size_of(SDFUniforms));
	wgpuQueueWriteBuffer(wgpu_context.queue, buffer, 0, scene_data.sdf_uniforms.data, size);
}
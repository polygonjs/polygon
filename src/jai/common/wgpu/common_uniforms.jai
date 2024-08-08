wgpu_object_uniform_to_buffer :: (
	device: WGPUDevice,
	queue: WGPUQueue,
	pipeline: WGPURenderPipeline,
	uniforms: [1]ObjectUniforms
) -> WGPUBuffer, WGPUBindGroup, []WGPUBindGroupEntry {
	// TODO: This is a hack to make sure the buffer is at least 16 bytes
	size := max( cast(u64)16, cast(u64) uniforms.count * size_of(ObjectUniforms));

	buffer_desc: WGPUBufferDescriptor = .{
		usage = xx (WGPUBufferUsage.Uniform | WGPUBufferUsage.CopyDst),
		size = size
	};
	buffer := wgpuDeviceCreateBuffer(device, *buffer_desc);
	assert(buffer != null, "Buffer is not created correctly");

	print("wgpu_object_uniform_to_buffer\n");
	wgpuQueueWriteBuffer(queue, buffer, 0, uniforms.data, size);

	entries := NewArray(1, WGPUBindGroupEntry);
	entries[0] = WGPUBindGroupEntry.{
		binding=0,
		size=size,
		offset=0,
		buffer=buffer,
	};
	bind_group_descriptor := WGPUBindGroupDescriptor.{
		layout = wgpuRenderPipelineGetBindGroupLayout(pipeline, 0),
		entryCount = xx entries.count,
		entries = entries.data
	};
	bind_group := wgpuDeviceCreateBindGroup(device, *bind_group_descriptor);

	return buffer, bind_group, entries;
}

wgpu_camera_uniform_to_buffer :: (
	device: WGPUDevice,
	queue: WGPUQueue,
	pipeline: WGPURenderPipeline,
	uniforms: [1]CameraUniforms
) -> WGPUBuffer,  WGPUBindGroup, []WGPUBindGroupEntry {
	// TODO: This is a hack to make sure the buffer is at least 16 bytes
	size := max( cast(u64)16, cast(u64) uniforms.count * size_of(CameraUniforms));

	buffer := wgpuDeviceCreateBuffer(device, *(WGPUBufferDescriptor.{
		usage = xx (WGPUBufferUsage.Uniform | WGPUBufferUsage.CopyDst),
		size = size
	}));
	assert(buffer != null, "Buffer is not created correctly");

	print("wgpu_camera_uniform_to_buffer\n");
	print("uniforms:%\n",uniforms);
	wgpuQueueWriteBuffer(queue, buffer, 0, uniforms.data, size);

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
		layout = wgpuRenderPipelineGetBindGroupLayout(pipeline, 1),
		entryCount = xx entries.count,
		entries = entries.data
	};
	bind_group := wgpuDeviceCreateBindGroup(device, *bind_group_descriptor);

	return buffer, bind_group, entries;
}


wgpu_sdf_uniform_to_buffer :: (
	device: WGPUDevice,
	queue: WGPUQueue,
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
	buffer := wgpuDeviceCreateBuffer(device, *buffer_desc);
	assert(buffer != null, "Buffer is not created correctly");

	print("wgpu_sdf_uniform_to_buffer\n");
	wgpuQueueWriteBuffer(queue, buffer, 0, uniforms.data, size);

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
		layout = wgpuRenderPipelineGetBindGroupLayout(pipeline, 2),
		entryCount = xx entries.count,
		entries = entries.data
	};
	bind_group := wgpuDeviceCreateBindGroup(device, *bind_group_descriptor);

	return buffer, bind_group, entries;
}

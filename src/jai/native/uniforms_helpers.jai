object_uniform_to_buffer :: (device: wgpu.Device, queue: wgpu.Queue, pipeline: wgpu.RenderPipeline, uniforms: [1]ObjectUniforms) -> wgpu.Buffer, u64, wgpu.BindGroup {
	// TODO: This is a hack to make sure the buffer is at least 16 bytes
	size := max( cast(u64)16, cast(u64) uniforms.count * size_of(ObjectUniforms));

	buffer := wgpu.DeviceCreateBuffer(device, *(wgpu.BufferDescriptor.{
		usage = xx (wgpu.BufferUsage.Uniform | wgpu.BufferUsage.CopyDst),
		size = size
	}));
	assert(buffer != null, "Buffer is not created correctly");

	wgpu.QueueWriteBuffer(queue, buffer, 0, uniforms.data, size);

	entries := NewArray(1, wgpu.BindGroupEntry);
	entries[0] = wgpu.BindGroupEntry.{
		binding=0,
		size=size,
		offset=0,
		buffer=buffer,
	};
	bind_group_descriptor := wgpu.BindGroupDescriptor.{
		layout = wgpu.RenderPipelineGetBindGroupLayout(pipeline, 0),
		entryCount = xx entries.count,
		entries = entries.data
	};
	bind_group := wgpu.DeviceCreateBindGroup(device, *bind_group_descriptor);

	return buffer, size, bind_group;
}

update_object_uniforms_to_buffer :: (buffer:wgpu.Buffer, queue: wgpu.Queue, scene_data: *SceneData) {
	// TODO: This is a hack to make sure the buffer is at least 16 bytes
	// size := cast(u64) /*vertices.count **/ size_of(ObjectUniforms);
	size := max( cast(u64)16, cast(u64) /*uniforms.count **/ size_of(ObjectUniforms));
	wgpu.QueueWriteBuffer(queue, buffer, 0, scene_data.object_uniforms.data, size);
}

camera_uniform_to_buffer :: (device: wgpu.Device, queue: wgpu.Queue, pipeline: wgpu.RenderPipeline, uniforms: [1]CameraUniforms) -> wgpu.Buffer, u64, wgpu.BindGroup {
	// TODO: This is a hack to make sure the buffer is at least 16 bytes
	size := max( cast(u64)16, cast(u64) uniforms.count * size_of(CameraUniforms));

	buffer := wgpu.DeviceCreateBuffer(device, *(wgpu.BufferDescriptor.{
		usage = xx (wgpu.BufferUsage.Uniform | wgpu.BufferUsage.CopyDst),
		size = size
	}));
	assert(buffer != null, "Buffer is not created correctly");

	wgpu.QueueWriteBuffer(queue, buffer, 0, uniforms.data, size);

	entries := NewArray(1, wgpu.BindGroupEntry);
	entries[0] = wgpu.BindGroupEntry.{
		binding=0,
		size=size,
		offset=0,
		buffer=buffer,
	};
	// entries[1] = wgpu.BindGroupEntry.{
	// 	binding=0,
	// 	size=size_of(Matrix4),
	// 	offset=size_of(Matrix4),
	// 	buffer=buffer,
	// };
	bind_group_descriptor := wgpu.BindGroupDescriptor.{
		layout = wgpu.RenderPipelineGetBindGroupLayout(pipeline, 1),
		entryCount = xx entries.count,
		entries = entries.data
	};
	bind_group := wgpu.DeviceCreateBindGroup(device, *bind_group_descriptor);

	return buffer, size, bind_group;
}

update_camera_uniforms_to_buffer :: (buffer:wgpu.Buffer, queue: wgpu.Queue, scene_data: *SceneData) {
	// TODO: This is a hack to make sure the buffer is at least 16 bytes
	// size := cast(u64) /*vertices.count **/ size_of(ObjectUniforms);
	size := max( cast(u64)16, cast(u64) size_of(CameraUniforms));
	wgpu.QueueWriteBuffer(queue, buffer, 0, scene_data.camera_uniforms.data, size);
}

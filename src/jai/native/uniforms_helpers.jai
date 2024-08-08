// object_uniform_to_buffer :: (
// 	device: WGPUDevice,
// 	queue: WGPUQueue,
// 	pipeline: WGPURenderPipeline,
// 	uniforms: [1]ObjectUniforms
// ) -> WGPUBuffer, WGPUBindGroup, []WGPUBindGroupEntry {
// 	// TODO: This is a hack to make sure the buffer is at least 16 bytes
// 	size := max( cast(u64)16, cast(u64) uniforms.count * size_of(ObjectUniforms));

// 	buffer := wgpuDeviceCreateBuffer(device, *(WGPUBufferDescriptor.{
// 		usage = xx (WGPUBufferUsage.Uniform | WGPUBufferUsage.CopyDst),
// 		size = size
// 	}));
// 	assert(buffer != null, "Buffer is not created correctly");

// 	wgpuQueueWriteBuffer(queue, buffer, 0, uniforms.data, size);

// 	entries := NewArray(1, WGPUBindGroupEntry);
// 	entries[0] = WGPUBindGroupEntry.{
// 		binding=0,
// 		size=size,
// 		offset=0,
// 		buffer=buffer,
// 	};
// 	bind_group_descriptor := WGPUBindGroupDescriptor.{
// 		layout = wgpuRenderPipelineGetBindGroupLayout(pipeline, 0),
// 		entryCount = xx entries.count,
// 		entries = entries.data
// 	};
// 	bind_group := wgpuDeviceCreateBindGroup(device, *bind_group_descriptor);

// 	return buffer, bind_group, entries;
// }

update_object_uniforms_to_buffer :: (buffer:WGPUBuffer, queue: WGPUQueue, scene_data: *SceneData) {
	// TODO: This is a hack to make sure the buffer is at least 16 bytes
	// size := cast(u64) /*vertices.count **/ size_of(ObjectUniforms);
	size := max( cast(u64)16, cast(u64) /*uniforms.count **/ size_of(ObjectUniforms));
	wgpuQueueWriteBuffer(queue, buffer, 0, scene_data.object_uniforms.data, size);
}


update_camera_uniforms_to_buffer :: (buffer:WGPUBuffer, queue: WGPUQueue, scene_data: *SceneData) {
	// TODO: This is a hack to make sure the buffer is at least 16 bytes
	// size := cast(u64) /*vertices.count **/ size_of(ObjectUniforms);
	size := max( cast(u64)16, cast(u64) size_of(CameraUniforms));
	wgpuQueueWriteBuffer(queue, buffer, 0, scene_data.camera_uniforms.data, size);
}


update_sdf_uniforms_to_buffer :: (buffer:WGPUBuffer, queue: WGPUQueue, scene_data: *SceneData) {
	// TODO: This is a hack to make sure the buffer is at least 16 bytes
	// size := cast(u64) /*vertices.count **/ size_of(ObjectUniforms);
	size := max( cast(u64)16, cast(u64) size_of(SDFUniforms));
	wgpuQueueWriteBuffer(queue, buffer, 0, scene_data.sdf_uniforms.data, size);
}
BufferContainer :: struct {
	buffer:WGPUBuffer;
	buffer_size: u64;
}

wgpu_buffer_from_geometry_attribute :: (wgpu_context: *WGPUContext, attribute: *GeometryAttribute, $T: Type/*, compute:bool=false*/) -> BufferContainer {
	assert(attribute.values.count > 0, "Attribute values count is 0");
	size := cast(u64) attribute.values.count * size_of(T);


	usage :WGPUBufferUsageFlags= xx WGPUBufferUsage.Vertex | WGPUBufferUsage.CopyDst;
	// if(compute){
	// 	#if MAP_BUFFER {
	// 		usage = xx WGPUBufferUsage.Storage | WGPUBufferUsage.CopySrc | WGPUBufferUsage.CopyDst | WGPUBufferUsage.Vertex;
	// 	} else {
	// 		usage = xx WGPUBufferUsage.Storage | WGPUBufferUsage.CopyDst | WGPUBufferUsage.Vertex;
	// 	}
	// }

	buffer_desc:WGPUBufferDescriptor = .{
		usage = usage,
		size=size
	};
	buffer := wgpuDeviceCreateBuffer(wgpu_context.device, *buffer_desc);
	assert(buffer != null, "Buffer is not created correctly");

	wgpuQueueWriteBuffer(wgpu_context.queue, buffer, 0, attribute.values.data, size);

	container :BufferContainer= .{buffer, size};
	return container;
}


wgpu_buffer_for_compute :: (wgpu_context: *WGPUContext, size: u64) -> BufferContainer {
	assert(size > 0, "size is 0");
	// size := cast(u64) attribute.values.count * size_of(T);


	// usage :WGPUBufferUsageFlags= xx WGPUBufferUsage.Vertex | WGPUBufferUsage.CopyDst;
	// if(compute){
	#if MAP_BUFFER {
		usage :WGPUBufferUsageFlags= xx WGPUBufferUsage.Storage | WGPUBufferUsage.CopySrc | WGPUBufferUsage.CopyDst | WGPUBufferUsage.Vertex;
	} else {
		usage :WGPUBufferUsageFlags= xx WGPUBufferUsage.Storage | WGPUBufferUsage.CopyDst | WGPUBufferUsage.Vertex;
	}
	// }

	buffer_desc:WGPUBufferDescriptor = .{
		usage = usage,
		size=size
	};
	buffer := wgpuDeviceCreateBuffer(wgpu_context.device, *buffer_desc);
	assert(buffer != null, "Buffer is not created correctly");

	// wgpuQueueWriteBuffer(wgpu_context.queue, buffer, 0, attribute.values.data, size);

	container :BufferContainer= .{buffer, size};
	return container;
}
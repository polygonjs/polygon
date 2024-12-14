wgpu_uniform_to_buffer :: (
	wgpuContext: *WGPUContext,
	pipeline: WGPURenderPipeline,
	bind_group_layout_index: u32,
	uniforms: $UniformType,
	label: string
) -> WGPUBuffer, WGPUBindGroup, []WGPUBindGroupEntry {
	buffer, bind_group, entries := wgpu_uniform_to_buffer_with_size(wgpuContext, pipeline, bind_group_layout_index, *uniforms, size_of(UniformType), label);
	return buffer, bind_group, entries;
}

wgpu_uniform_to_buffer_with_size :: (
	wgpuContext: *WGPUContext,
	pipeline: WGPURenderPipeline,
	bind_group_layout_index: u32,
	uniforms: *void,
	uniformTypeSize: u32,
	label: string
) -> WGPUBuffer, WGPUBindGroup, []WGPUBindGroupEntry {
	// TODO: This is a hack to make sure the buffer is at least 16 bytes
	size := cast(u64) max( 16, uniformTypeSize);

	buffer_label := to_c_string_temp(label);
	// defer free(buffer_label);
	buffer_desc: WGPUBufferDescriptor = .{
		usage = xx (WGPUBufferUsage.Uniform | WGPUBufferUsage.CopyDst),
		size = size,
		label = buffer_label,
	};
	buffer := wgpuDeviceCreateBuffer(wgpuContext.device, *buffer_desc);
	assert(buffer != null, "Buffer is not created correctly");

	wgpuQueueWriteBuffer(wgpuContext.queue, buffer, 0, uniforms, size);

	entries := NewArray(1, WGPUBindGroupEntry,, temp);
	entries[0] = WGPUBindGroupEntry.{
		binding=0,
		size=size,
		offset=0,
		buffer=buffer,
	};
	bind_group_descriptor_label := tprint("uniforms_bind_group/%", label,, temp);
	bind_group_descriptor_label_c := to_c_string_temp(bind_group_descriptor_label);
	// defer free(bind_group_descriptor_label_c);
	bind_group_descriptor := WGPUBindGroupDescriptor.{
		label = bind_group_descriptor_label_c,
		layout = wgpuRenderPipelineGetBindGroupLayout(pipeline, bind_group_layout_index),
		entryCount = xx entries.count,
		entries = entries.data
	};
	bind_group := wgpuDeviceCreateBindGroup(wgpuContext.device, *bind_group_descriptor);

	return buffer, bind_group, entries;
}
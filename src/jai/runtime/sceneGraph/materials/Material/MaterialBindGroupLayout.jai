materialInitDrawDataBindGroupLayouts :: (wgpuContext: *WGPUContext, mesh: *Mesh, pc: *PipelineController, drawData: *MeshDrawData) {
	array_init(*drawData.vertex);
	materialInitDrawDataVertexBuffers(wgpuContext, mesh, pc.material, pc, drawData);
	materialInitDrawDataIndex(wgpuContext, mesh, drawData);
	materialInitDrawDataObjectUniforms(wgpuContext, mesh, pc, drawData);
	generatedMaterialInitDrawDataMaterialUniforms(wgpuContext, pc.material, pc, drawData);
}
materialInitDrawDataIndex :: (wgpuContext: *WGPUContext, mesh: *Mesh, drawData: *MeshDrawData) {
	using drawData.index;
	buffer,
	buffer_size = wgpu_index_array_to_buffer(wgpuContext, mesh.geometry.indices);
}
materialInitDrawDataObjectUniforms :: (wgpuContext: *WGPUContext, mesh: *Mesh, pc: *PipelineController, drawData: *MeshDrawData) {
	using drawData.uniforms.object;
	buffer,
	bind_group,
	bind_group_entries = _wgpuUniformToBuffer(wgpuContext, pc.pipeline, xx UniformBindingIndex.OBJECT, mesh.transformableUniforms, "object");
}
materialInitDrawDataMaterialUniforms :: (wgpuContext: *WGPUContext, material: *$T, pc: *PipelineController, drawData: *MeshDrawData) {
	using drawData.uniforms.material;
	buffer,
	bind_group,
	bind_group_entries = _wgpuUniformToBufferWithSize(wgpuContext, pc.pipeline, xx UniformBindingIndex.MATERIAL, *pc.material.uniforms, pc.material.uniformTypeSize, "material");
}

materialApplyBindGroupLayout :: (wgpuContext: *WGPUContext, material: *$T, bindGroupLayouts: *[]WGPUBindGroupLayout) {
	materialApplyBindGroupLayoutDefault(wgpuContext, xx material, bindGroupLayouts);
}

materialApplyBindGroupLayoutDefault :: (wgpuContext: *WGPUContext, material: *Material, bindGroupLayouts: *[]WGPUBindGroupLayout) {
	_materialApplyBindGroupLayoutDefault_Scene(wgpuContext, bindGroupLayouts);
	_materialApplyBindGroupLayoutDefault_Camera(wgpuContext, bindGroupLayouts);
	_materialApplyBindGroupLayoutDefault_Object(wgpuContext, bindGroupLayouts);
	generatedMaterialApplyBindGroupLayoutDefault_MaterialUniforms(wgpuContext, material, bindGroupLayouts);
}

materialApplyBindGroupLayoutDefault_MaterialUniforms :: (wgpuContext: *WGPUContext, material: *$T, bindGroupLayouts: *[]WGPUBindGroupLayout){
	groupIndex := UniformBindingIndex.MATERIAL;
	bind_group_layout_entries:[1]WGPUBindGroupLayoutEntry; //:= NewArray(1, WGPUBindGroupLayoutEntry);
	// 	#if FREE_MEMORY defer array_reset(*bind_group_layout_entries);
	bind_group_layout_entries[0] = WGPUBindGroupLayoutEntry.{
		binding = 0,
		visibility = xx WGPUShaderStage.Vertex|WGPUShaderStage.Fragment,
		buffer = .{ type = WGPUBufferBindingType.Uniform },
	};
	layout, desc := _wgpuCreateBindGroupLayout(wgpuContext.device, bind_group_layout_entries.count, bind_group_layout_entries.data, "material uniforms");
	(<<bindGroupLayouts)[groupIndex] = layout;
}

_wgpuCreateBindGroupLayout :: (device: WGPUDevice, entryCount: s64, data: *WGPUBindGroupLayoutEntry, label:string) -> WGPUBindGroupLayout, WGPUBindGroupLayoutDescriptor {
	desc :WGPUBindGroupLayoutDescriptor= .{
		label = to_c_string_temp(label),
		entryCount = xx entryCount,
		entries = data,
	};
	bind_group_layout := wgpuDeviceCreateBindGroupLayout(device, *desc);
	return bind_group_layout, desc;
}

#scope_file

_materialApplyBindGroupLayoutDefault_Scene :: (wgpuContext: *WGPUContext, bindGroupLayouts: *[]WGPUBindGroupLayout){
	groupIndex := UniformBindingIndex.SCENE;
	bind_group_layout_entries:[1]WGPUBindGroupLayoutEntry; //:= NewArray(1, WGPUBindGroupLayoutEntry);
	// #if FREE_MEMORY defer array_reset(*bind_group_layout_entries);
	bind_group_layout_entries[0] = WGPUBindGroupLayoutEntry.{
		binding = 0,
		visibility = xx WGPUShaderStage.Vertex|WGPUShaderStage.Fragment,
		buffer = .{ type = WGPUBufferBindingType.Uniform },
	};
	layout, desc := _wgpuCreateBindGroupLayout(wgpuContext.device, bind_group_layout_entries.count, bind_group_layout_entries.data, "scene uniforms");
	(<<bindGroupLayouts)[groupIndex] = layout;
}
_materialApplyBindGroupLayoutDefault_Camera :: (wgpuContext: *WGPUContext, bindGroupLayouts: *[]WGPUBindGroupLayout){
	groupIndex := UniformBindingIndex.CAMERA;
	bind_group_layout_entries:[1]WGPUBindGroupLayoutEntry; //:= NewArray(1, WGPUBindGroupLayoutEntry);
	// #if FREE_MEMORY defer array_reset(*bind_group_layout_entries);
	bind_group_layout_entries[0] = WGPUBindGroupLayoutEntry.{
		binding = 0,
		visibility = xx WGPUShaderStage.Vertex|WGPUShaderStage.Fragment,
		buffer = .{ type = WGPUBufferBindingType.Uniform },
	};
	layout, desc := _wgpuCreateBindGroupLayout(wgpuContext.device, bind_group_layout_entries.count, bind_group_layout_entries.data, "camera uniforms");
	(<<bindGroupLayouts)[groupIndex] = layout;
}
_materialApplyBindGroupLayoutDefault_Object :: (wgpuContext: *WGPUContext, bindGroupLayouts: *[]WGPUBindGroupLayout){
	groupIndex := UniformBindingIndex.OBJECT;
	bind_group_layout_entries:[1]WGPUBindGroupLayoutEntry; //:= NewArray(1, WGPUBindGroupLayoutEntry);
	// #if FREE_MEMORY defer array_reset(*bind_group_layout_entries);
	bind_group_layout_entries[0] = WGPUBindGroupLayoutEntry.{
		binding = 0,
		visibility = xx WGPUShaderStage.Vertex,
		buffer = .{ type = WGPUBufferBindingType.Uniform },
	};
	layout, desc := _wgpuCreateBindGroupLayout(wgpuContext.device, bind_group_layout_entries.count, bind_group_layout_entries.data, "object uniforms");
	(<<bindGroupLayouts)[groupIndex] = layout;
}





_wgpuUniformToBuffer :: (
	wgpuContext: *WGPUContext,
	pipeline: WGPURenderPipeline,
	bind_group_layout_index: u32,
	uniforms: $UniformType,
	label: string
) -> WGPUBuffer, WGPUBindGroup, []WGPUBindGroupEntry {
	buffer, bind_group, entries := _wgpuUniformToBufferWithSize(wgpuContext, pipeline, bind_group_layout_index, *uniforms, size_of(UniformType), label);
	return buffer, bind_group, entries;
}

_wgpuUniformToBufferWithSize :: (
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
materialInitDrawData :: (wgpuContext: *WGPUContext, mesh: *Mesh, pc: *PipelineController, drawData: *MeshDrawData) {

	// vertex
	materialInitDrawData_CreateVertexBuffers(wgpuContext, mesh, pc.material, pc, drawData);
	materialInitDrawData_UploadVertexBuffers(wgpuContext, mesh, pc.material, pc, drawData);

	// index
	materialInitDrawData_CreateIndexBuffer(wgpuContext, mesh, drawData);
	materialInitDrawData_UploadIndexBuffer(wgpuContext, mesh, drawData);

	// object uniforms
	materialInitDrawData_ObjectGroup(wgpuContext, mesh, pc, drawData);

	// material group (uniforms + custom bindings like samplers/textures)
	generatedMaterialInitDrawData_MaterialGroup(wgpuContext, pc.material, pc, drawData);

}

materialInitDrawData_ObjectGroup :: (wgpuContext: *WGPUContext, mesh: *Mesh, pc: *PipelineController, drawData: *MeshDrawData) {
	using drawData.uniforms.object;
	bufferContainer,
	bind_group,
	bind_group_entries = _wgpuUniformToBuffer_Create(wgpuContext, pc.pipeline, xx UniformBindingIndex.OBJECT, *mesh.transformableUniforms, size_of(type_of(mesh.transformableUniforms)), "object");

	_wgpuUniformToBuffer_Upload(wgpuContext, *mesh.transformableUniforms, bufferContainer);


}
materialInitDrawData_MaterialGroup :: (wgpuContext: *WGPUContext, material: *$T, pc: *PipelineController, drawData: *MeshDrawData) {
	using drawData.uniforms.material;
	bufferContainer,
	bind_group,
	bind_group_entries = _wgpuUniformToBuffer_Create(wgpuContext, pc.pipeline, xx UniformBindingIndex.MATERIAL, *pc.material.uniforms, pc.material.uniformTypeSize, "material");

	_wgpuUniformToBuffer_Upload(wgpuContext, *pc.material.uniforms, bufferContainer);
}

materialApplyBindGroupLayout :: (wgpuContext: *WGPUContext, material: *$T, bindGroupLayouts: *[]WGPUBindGroupLayout) {
	materialApplyBindGroupLayoutDefault(wgpuContext, xx material, bindGroupLayouts);
}

materialApplyBindGroupLayoutDefault :: (wgpuContext: *WGPUContext, material: *$T, bindGroupLayouts: *[]WGPUBindGroupLayout) {
	_materialApplyBindGroupLayoutDefault_Scene(wgpuContext, bindGroupLayouts);
	_materialApplyBindGroupLayoutDefault_Camera(wgpuContext, bindGroupLayouts);
	_materialApplyBindGroupLayoutDefault_Object(wgpuContext, bindGroupLayouts);
	generatedMaterialApplyBindGroupLayout_MaterialGroup(wgpuContext, material, bindGroupLayouts);
}

materialApplyBindGroupLayout_MaterialGroup :: (wgpuContext: *WGPUContext, material: *$T, bindGroupLayouts: *[]WGPUBindGroupLayout){
	bindGroupLayoutEntries:[1]WGPUBindGroupLayoutEntry;
	materialApplyBindGroupLayout_MaterialGroup_addUniforms(wgpuContext, material, *bindGroupLayoutEntries, binding=0);
	materialApplyBindGroupLayout_MaterialGroup_close(wgpuContext, material, *bindGroupLayoutEntries, bindGroupLayouts);
}
materialApplyBindGroupLayout_MaterialGroup_addUniforms :: (wgpuContext: *WGPUContext, material: *$T, bindGroupLayoutEntries:*$B, binding:u32){
	// 	#if FREE_MEMORY defer array_reset(*bind_group_layout_entries);
	(<<bindGroupLayoutEntries)[binding] = WGPUBindGroupLayoutEntry.{
		binding = binding,
		visibility = xx WGPUShaderStage.Vertex|WGPUShaderStage.Fragment,
		buffer = .{ type = WGPUBufferBindingType.Uniform },
	};
}
materialApplyBindGroupLayout_MaterialGroup_addSampler :: (wgpuContext: *WGPUContext, material: *$T, bindGroupLayoutEntries:*$B, texture: *Texture, binding: u32){
	assert(texture != null, "texture is null");
	(<<bindGroupLayoutEntries)[binding] = WGPUBindGroupLayoutEntry.{
		binding = binding,
		visibility = xx WGPUShaderStage.Vertex|WGPUShaderStage.Fragment,
		sampler = samplerBindingLayout(texture)
	};
}
materialApplyBindGroupLayout_MaterialGroup_addTexture :: (wgpuContext: *WGPUContext, material: *$T, bindGroupLayoutEntries:*$B, texture: *Texture, binding: u32){
	assert(texture != null, "texture is null");
	(<<bindGroupLayoutEntries)[binding] = WGPUBindGroupLayoutEntry.{
		binding = binding,
		visibility = xx WGPUShaderStage.Vertex|WGPUShaderStage.Fragment,
		texture = textureBindingLayout(material.texture),
	};
}
materialApplyBindGroupLayout_MaterialGroup_close :: (wgpuContext: *WGPUContext, material: *$T, bindGroupLayoutEntries:*$B, bindGroupLayouts: *[]WGPUBindGroupLayout){
	groupIndex := UniformBindingIndex.MATERIAL;

	layout, desc := _wgpuCreateBindGroupLayout(wgpuContext.device, bindGroupLayoutEntries.count, bindGroupLayoutEntries.data, "material uniforms");
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

_wgpuUniformToBuffer_Create_AddMaterialUniforms :: (wgpuContext: *WGPUContext, uniformTypeSize: u32, entries:*[]WGPUBindGroupEntry, label: string, binding: u32)->BufferContainer {
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

	// wgpuQueueWriteBuffer(wgpuContext.queue, buffer, 0, uniforms, size);

	(<<entries)[binding] = WGPUBindGroupEntry.{
		binding=binding,
		size=size,
		offset=0,
		buffer=buffer,
	};

	bufferContainer :BufferContainer = .{buffer, size, label};
	return bufferContainer;
}

_wgpuUniformToBuffer_Create_Close :: (wgpuContext: *WGPUContext, pc: WGPURenderPipeline, bind_group_layout_index: u32, entries:*[]WGPUBindGroupEntry, label: string)-> WGPUBindGroup {
	bind_group_descriptor_label := tprint("uniforms_bind_group/%", label,, temp);
	bind_group_descriptor_label_c := to_c_string_temp(bind_group_descriptor_label);
	// defer free(bind_group_descriptor_label_c);
	bind_group_descriptor := WGPUBindGroupDescriptor.{
		label = bind_group_descriptor_label_c,
		layout = wgpuRenderPipelineGetBindGroupLayout(pc, bind_group_layout_index),
		entryCount = xx entries.count,
		entries = entries.data
	};
	bindGroup := wgpuDeviceCreateBindGroup(wgpuContext.device, *bind_group_descriptor);

	return bindGroup;
}

_wgpuUniformToBuffer_Upload :: (wgpuContext: *WGPUContext, uniforms: *void, bufferContainer:BufferContainer) {

	wgpuQueueWriteBuffer(wgpuContext.queue, bufferContainer.buffer, 0, uniforms, bufferContainer.buffer_size);

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






_wgpuUniformToBuffer_Create :: (wgpuContext: *WGPUContext, pipeline: WGPURenderPipeline, bind_group_layout_index: u32, uniforms: *void, uniformTypeSize: u32, label: string) -> (BufferContainer, WGPUBindGroup, []WGPUBindGroupEntry) {

	entries := NewArray(1, WGPUBindGroupEntry,, temp);

	bufferContainer := _wgpuUniformToBuffer_Create_AddMaterialUniforms(wgpuContext, uniformTypeSize, *entries, label, binding=0);
	bindGroup := _wgpuUniformToBuffer_Create_Close(wgpuContext, pipeline, bind_group_layout_index, *entries, label);

	return bufferContainer, bindGroup, entries;
}





MeshBasicTextureMaterialUniforms :: struct {
	color:Color;
	// sampler:WGPUSampler;
	// texture:WGPUTexture;
};

MeshBasicTextureMaterial :: struct {
	#as using material: MaterialBase(UNIFORM_TYPE, topology = .TriangleList);
	texture: *Texture;
};

registerMeshBasicTextureMaterial :: () #compile_time {
	materialRegister(TYPE);
}

// uniforms :: (material: *TYPE) -> *UNIFORM_TYPE {
// 	return cast(*UNIFORM_TYPE)material.uniforms;
// }
setColor :: (material: *TYPE, color: Color) {
	material.uniforms.color = color;
}
setTexture :: (material: *TYPE, texture: *Texture) {
	material.texture = texture;
}
materialInit :: (material: *TYPE) {
	baseMaterialInit(material);
	// material.name = MATERIAL_NAME;
	material.shader = SHADER_RAW;
	material.uniforms.color = .{1.0, 0.0, 0.0, 1.0};
}

materialApplyVertexBufferLayout :: (material: *TYPE, pc: *PipelineController) {
	materialApplyVertexBufferLayoutDefault(xx material, pc);
}

materialInitDrawDataMaterialUniforms :: (wgpuContext: *WGPUContext, material: *TYPE, pc: *PipelineController, drawData: *MeshDrawData) {
	using drawData.uniforms.material;
	buffer,
	bind_group,
	bind_group_entries = _wgpuUniformToBufferWithSize_TEMP(wgpuContext, material, pc.pipeline, xx UniformBindingIndex.MATERIAL, *pc.material.uniforms, pc.material.uniformTypeSize, "material");
}

materialApplyBindGroupLayoutDefault_MaterialUniforms :: (wgpuContext: *WGPUContext, material: *TYPE, bindGroupLayouts: *[]WGPUBindGroupLayout){
	groupIndex := UniformBindingIndex.MATERIAL;
	bind_group_layout_entries:[ENTRIES_COUNT]WGPUBindGroupLayoutEntry; //:= NewArray(1, WGPUBindGroupLayoutEntry);
	// 	#if FREE_MEMORY defer array_reset(*bind_group_layout_entries);
	bind_group_layout_entries[0] = WGPUBindGroupLayoutEntry.{
		binding = 0,
		visibility = xx WGPUShaderStage.Vertex|WGPUShaderStage.Fragment,
		buffer = .{ type = WGPUBufferBindingType.Uniform },
	};
	//
	// sampler
	//
	assert(material.texture != null, "texture is null");
	bind_group_layout_entries[1] = WGPUBindGroupLayoutEntry.{
		binding = 1,
		visibility = xx WGPUShaderStage.Vertex|WGPUShaderStage.Fragment,
		sampler = samplerBindingLayout(material.texture)
	};
	//
	// texture
	//
	bind_group_layout_entries[2] = WGPUBindGroupLayoutEntry.{
		binding = 2,
		visibility = xx WGPUShaderStage.Vertex|WGPUShaderStage.Fragment,
		texture = textureBindingLayout(material.texture),
	};
	layout, desc := _wgpuCreateBindGroupLayout(wgpuContext.device, bind_group_layout_entries.count, bind_group_layout_entries.data, "material uniforms");
	(<<bindGroupLayouts)[groupIndex] = layout;
}

textureCreateAndUpload :: (wgpuContext: *WGPUContext, material: *TYPE) {
	assert(material.texture != null, "texture is null");
	textureInit(wgpuContext, material.texture);
	textureUpload(material.texture);
}

#scope_file

SHADER_RAW :: #run import_shader();
import_shader :: () -> string { return "MeshBasicTextureMaterial.wgsl"; };
TYPE :: MeshBasicTextureMaterial;
UNIFORM_TYPE :: MeshBasicTextureMaterialUniforms;
// MATERIAL_NAME :: #run tprint("%", TYPE);


ENTRIES_COUNT :: 3;

_wgpuUniformToBufferWithSize_TEMP :: (
	wgpuContext: *WGPUContext,
	material: *TYPE,
	pipeline: WGPURenderPipeline,
	bind_group_layout_index: u32,
	uniforms: *void,
	uniformTypeSize: u32,
	label: string
) -> WGPUBuffer, WGPUBindGroup, []WGPUBindGroupEntry {
	// TODO: This is a hack to make sure the buffer is at least 16 bytes
	size := cast(u64) max( 16, uniformTypeSize);
	print("_wgpuUniformToBufferWithSize_TEMP\n");

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

	entries := NewArray(ENTRIES_COUNT, WGPUBindGroupEntry,, temp);
	entries[0] = WGPUBindGroupEntry.{
		binding=0,
		size=size,
		offset=0,
		buffer=buffer,
	};

	assert(material.texture != null, "texture is null");

	//
	// sampler
	//
	samplerDesc := samplerDescriptor(material.texture);
	sampler := wgpuDeviceCreateSampler(wgpuContext.device, *samplerDesc);
	entries[1] = WGPUBindGroupEntry.{
		binding=1,
		sampler=sampler,
	};

	//
	// textureView
	//
	textureCreateAndUpload(wgpuContext, material);
	entries[2] = WGPUBindGroupEntry.{
		binding=2,
		textureView=textureView(material.texture),
	};


	//
	//
	//
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










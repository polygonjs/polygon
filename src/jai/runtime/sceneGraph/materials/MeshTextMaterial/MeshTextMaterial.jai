MeshTextMaterialUniforms :: struct {
	color:Color;
	// sampler:WGPUSampler;
	// texture:WGPUTexture;
};

MeshTextMaterial :: struct {
	#as using material: MaterialBase(UNIFORM_TYPE, topology = .TriangleList);
	texture: *Texture;
};

registerMeshTextMaterial :: () #compile_time {
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
	material.texture = *FONT_TEXTURE;
	// material.name = MATERIAL_NAME;
	material.shader = SHADER_RAW;
	material.uniforms.color = .{1.0, 1.0, 1.0, 1.0};
}

materialApplyVertexBufferLayout :: (material: *TYPE, pc: *PipelineController) {
	materialApplyVertexBufferLayoutDefault(xx material, pc);
}

materialApplyBindGroupLayout_MaterialGroup :: (wgpuContext: *WGPUContext, material: *TYPE, bindGroupLayouts: *[]WGPUBindGroupLayout){

	bindGroupLayoutEntries:[ENTRIES_COUNT]WGPUBindGroupLayoutEntry;

	materialApplyBindGroupLayout_MaterialGroup_addUniforms(wgpuContext, material, *bindGroupLayoutEntries, binding=0);
	materialApplyBindGroupLayout_MaterialGroup_addSampler(wgpuContext, material, *bindGroupLayoutEntries, material.texture, binding=1);
	materialApplyBindGroupLayout_MaterialGroup_addTexture(wgpuContext, material, *bindGroupLayoutEntries, material.texture, binding=2);

	materialApplyBindGroupLayout_MaterialGroup_close(wgpuContext, material, *bindGroupLayoutEntries, bindGroupLayouts);
}

materialInitDrawData_MaterialGroup :: (wgpuContext: *WGPUContext, material: *TYPE, pc: *PipelineController, drawData: *MeshDrawData) {
	using drawData.uniforms.material;

	bind_group_entries = NewArray(ENTRIES_COUNT, WGPUBindGroupEntry,, temp);

	bufferContainer = _wgpuUniformToBuffer_Create_AddMaterialUniforms(wgpuContext, size_of(UNIFORM_TYPE), *bind_group_entries, "material", binding=0);
	_wgpuUniformToBuffer_Create_AddMaterialSampler(wgpuContext, material, *bind_group_entries, binding=1);
	_wgpuUniformToBuffer_Create_AddMaterialTexture(wgpuContext, material, *bind_group_entries, binding=2);

	bind_group = _wgpuUniformToBuffer_Create_Close(wgpuContext, pc.pipeline, xx UniformBindingIndex.MATERIAL, *bind_group_entries, "material");


	_wgpuUniformToBuffer_Upload(wgpuContext, *pc.material.uniforms, bufferContainer);
}


#scope_file

SHADER_RAW :: #run import_shader();
import_shader :: () -> string { return "MeshTextMaterial.wgsl"; };
TYPE :: MeshTextMaterial;
UNIFORM_TYPE :: MeshTextMaterialUniforms;
// MATERIAL_NAME :: #run tprint("%", TYPE);


ENTRIES_COUNT :: 3;

_textureInitAndUpload :: (wgpuContext: *WGPUContext, material: *TYPE) {
	assert(material.texture != null, "texture is null");
	textureInit(wgpuContext, material.texture);
	textureUpload(material.texture);
}

_wgpuUniformToBuffer_Create_AddMaterialSampler :: (wgpuContext: *WGPUContext,material: *TYPE, entries:*[]WGPUBindGroupEntry, binding: u32){

	samplerDesc := samplerDescriptor(material.texture);
	sampler := wgpuDeviceCreateSampler(wgpuContext.device, *samplerDesc);
	(<<entries)[binding] = WGPUBindGroupEntry.{
		binding=binding,
		sampler=sampler,
	};

}
_wgpuUniformToBuffer_Create_AddMaterialTexture :: (wgpuContext: *WGPUContext,material: *TYPE, entries:*[]WGPUBindGroupEntry, binding: u32){

	_textureInitAndUpload(wgpuContext, material);
	(<<entries)[binding] = WGPUBindGroupEntry.{
		binding=binding,
		textureView=textureView(material.texture),
	};

}









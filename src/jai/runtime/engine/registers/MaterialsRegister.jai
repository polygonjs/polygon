generatedMaterialTopology :: (material: *Material)->WGPUPrimitiveTopology {
	#insert GENERATED_MATERIAL_TOPOLOGY;
	assert(false, tprint("generatedMaterialTopology: material type '%' is not implemented", material.type));
	return .TriangleList;
}
generatedMaterialApplyVertexBufferLayout :: (material: *Material, pc : *PipelineController) {
	#insert GENERATED_MATERIAL_APPLY_VERTEX_BUFFER_LAYOUT;
	assert(false, tprint("generatedMaterialApplyVertexBufferLayout: material type '%' is not implemented", material.type));
}
generatedMaterialApplyBindGroupLayoutDefault_MaterialUniforms :: (wgpuContext: *WGPUContext, material: *Material, bindGroupLayouts: *[]WGPUBindGroupLayout) {
	#insert GENERATED_MATERIAL_APPLY_BIND_GROUP_LAYOUT_DEFAULT_MATERIAL_UNIFORMS;
	assert(false, tprint("generatedMaterialApplyBindGroupLayoutDefault_MaterialUniforms: material type '%' is not implemented", material.type));
}
generatedMaterialInitDrawDataMaterialUniforms :: (wgpuContext: *WGPUContext, material: *Material, pc: *PipelineController, drawData: *MeshDrawData) {
	#insert GENERATED_MATERIAL_INIT_DRAW_DATA_MATERIAL_UNIFORMS;
	assert(false, tprint("generatedMaterialInitDrawDataMaterialUniforms: material type '%' is not implemented", material.type));
}

registerMaterials :: () #compile_time {

	array_reset_keeping_memory(*TMP_METADATAS);

	registerLineBasicMaterial();

	registerMeshBackgroundBasicMaterial();
	registerMeshBackgroundGridMaterial();
	registerMeshBasicMaterial();
	registerMeshBasicTextureMaterial();
	registerMeshIdMaterial();
	registerMeshIdU32Material();
	registerMeshNormalMaterial();
	registerMeshRaymarchingMaterial();
	registerMeshUVMaterial();

	registerPointBasicMaterial();
}
materialsMetaDatasCount :: ()->u64 #compile_time {
	registerMaterials();
	return xx TMP_METADATAS.count;
}
materialsMetaDatas :: ()->[MATERIAL_METADATAS_COUNT]MaterialMetaData #compile_time {
	registerMaterials();

	list:[MATERIAL_METADATAS_COUNT]MaterialMetaData;

	for materialMetaData, i: TMP_METADATAS {
		list[i] = materialMetaData;
	}
	return list;
}


getMaterialTypeId :: (T:Type)->u64 {
	index := -1;
	found := false;
	for materialMetaData, i: MATERIAL_METADATAS {
		if materialMetaData.type == T {
			found = true;
			index = i;
			break;
		}
	}
	assert(found, tprint("material type not found: '%'", T));
	// assert(found, "node type not found");
	return xx index;
}

materialRegister :: (
	$T:Type //,
	// topology:WGPUPrimitiveTopology
	) #compile_time {
	array_add(*TMP_METADATAS, .{
		type = T //,
		// topology = topology
	});
}

MaterialMetaData :: struct {
	type: Type;
	// topology: WGPUPrimitiveTopology;
}

#no_reset MATERIAL_METADATAS_COUNT :u64: #run materialsMetaDatasCount();
#no_reset MATERIAL_METADATAS :[MATERIAL_METADATAS_COUNT]MaterialMetaData: #run materialsMetaDatas();


#scope_file

TMP_METADATAS: [..]MaterialMetaData;

GENERATED_MATERIAL_TOPOLOGY,
GENERATED_MATERIAL_APPLY_VERTEX_BUFFER_LAYOUT,
GENERATED_MATERIAL_APPLY_BIND_GROUP_LAYOUT_DEFAULT_MATERIAL_UNIFORMS,
GENERATED_MATERIAL_INIT_DRAW_DATA_MATERIAL_UNIFORMS :: #run registerMaterialsAndGenerateCode();


registerMaterialsAndGenerateCode :: () -> (
	materialTopology:string,
	materialApplyVertexBufferLayout:string,
	materialApplyBindGroupLayoutDefault_MaterialUniforms:string,
	materialInitDrawDataMaterialUniforms:string
) #compile_time {

	registerMaterials();

	materialTopology := _forMat("materialTopology");
	materialApplyVertexBufferLayout := _forMatPipelineController("materialApplyVertexBufferLayout");
	materialApplyBindGroupLayoutDefault_MaterialUniforms := _forMatBindGroupLayouts("materialApplyBindGroupLayoutDefault_MaterialUniforms");
	materialInitDrawDataMaterialUniforms := _forMatDrawData("materialInitDrawDataMaterialUniforms");
	return
		materialTopology,
		materialApplyVertexBufferLayout,
		materialApplyBindGroupLayoutDefault_MaterialUniforms,
		materialInitDrawDataMaterialUniforms;
}


_forMat :: (functionName:string)->string #compile_time {
	builder: String_Builder;
	print_to_builder(*builder, "if material.type == {\n");
	for metaData: MATERIAL_METADATAS {
		materialType := metaData.type;
		print_to_builder(*builder, tprint("\tcase %; return %(cast(*%) material);\n", materialType, functionName, materialType));
	}
	print_to_builder(*builder, "}");
	result := builder_to_string(*builder);
	reset(*builder);
	return result;
}
_forMatPipelineController :: (functionName:string)->string #compile_time {
	builder: String_Builder;
	print_to_builder(*builder, "if material.type == {\n");
	for metaData: MATERIAL_METADATAS {
		materialType := metaData.type;
		print_to_builder(*builder, tprint("\tcase %; %(cast(*%) material, pc); return;\n", materialType, functionName, materialType));
	}
	print_to_builder(*builder, "}");
	result := builder_to_string(*builder);
	reset(*builder);
	return result;
}
_forMatBindGroupLayouts :: (functionName:string)->string #compile_time {
	builder: String_Builder;
	print_to_builder(*builder, "if material.type == {\n");
	for metaData: MATERIAL_METADATAS {
		materialType := metaData.type;
		print_to_builder(*builder, tprint("\tcase %; %(wgpuContext, cast(*%) material, bindGroupLayouts); return;\n", materialType, functionName, materialType));
	}
	print_to_builder(*builder, "}");
	result := builder_to_string(*builder);
	reset(*builder);
	return result;
}
_forMatDrawData :: (functionName:string)->string #compile_time {
	builder: String_Builder;
	print_to_builder(*builder, "if material.type == {\n");
	for metaData: MATERIAL_METADATAS {
		materialType := metaData.type;
		print_to_builder(*builder, tprint("\tcase %; %(wgpuContext, cast(*%) material, pc, drawData); return;\n", materialType, functionName, materialType));
	}
	print_to_builder(*builder, "}");
	result := builder_to_string(*builder);
	reset(*builder);
	return result;
}
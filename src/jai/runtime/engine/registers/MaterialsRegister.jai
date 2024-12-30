generatedMaterialTopology :: (material: *Material)->WGPUPrimitiveTopology {
	#insert GENERATED_MATERIAL_TOPOLOGY;
	assert(false, tprint("generatedMaterialTopology: material type '%' is not implemented", material.type));
	return .TriangleList;
}

registerMaterials :: () #compile_time {

	array_reset_keeping_memory(*TMP_METADATAS);

	registerLineBasicMaterial();

	registerMeshBasicMaterial();
	registerMeshBackgroundBasicMaterial();
	registerMeshBackgroundGridMaterial();
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

GENERATED_MATERIAL_TOPOLOGY :: #run registerMaterialsAndGenerateCode();


registerMaterialsAndGenerateCode :: () -> (materialTopology:string) {

	registerMaterials();

	materialTopology := _forMat("materialTopology");

	return 	materialTopology;
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
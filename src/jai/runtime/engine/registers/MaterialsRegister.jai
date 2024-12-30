

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

// registerMaterialsAndGenerateCode :: () -> (materialTopology:string) {

// 	registerNodes();

// 	materialTopology := generateMaterialTopologies();

// 	return 	materialTopology;
// }

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
	$T:Type,
	topology:WGPUPrimitiveTopology
	) #compile_time {
	array_add(*TMP_METADATAS, .{
		type = T,
		topology = topology
	});
}

MaterialMetaData :: struct {
	type: Type;
	topology: WGPUPrimitiveTopology;
}

#no_reset MATERIAL_METADATAS_COUNT :u64: #run materialsMetaDatasCount();
#no_reset MATERIAL_METADATAS :[MATERIAL_METADATAS_COUNT]MaterialMetaData: #run materialsMetaDatas();


#scope_file

TMP_METADATAS: [..]MaterialMetaData;



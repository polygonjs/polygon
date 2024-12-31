EmptyUniforms :: struct {};

MaterialBase :: struct ($UniformType: Type, $topology: WGPUPrimitiveTopology) {
	allocator: Allocator;
	type: Type;
	materialTypeId:u64;
	uniformType: Type=UniformType;
	uniformTypeSize: u32=size_of(UniformType);
	id: u64;
	//
	// name: string;
	shader: string;
	uniforms: UniformType;
}
Material :: MaterialBase(Any, .TriangleList);


newMaterial :: (scene: *Scene, $T: Type) -> *T {
	return newMaterial(T, scene.allocator);
}
newMaterial :: ($T: Type, allocator: Allocator) -> *T {
	material: *T = New(T,,allocator);
	material.allocator = allocator;

	materialInit(material);

	return material;
}
baseMaterialInit :: (material: *$T) {
	material.type = T;

	material.materialTypeId = getMaterialTypeId(T);

	material.id = NEXT_MATERIAL_ID;
	NEXT_MATERIAL_ID += 1;
}
materialDelete :: (material: *$T) {
	free(material,, material.allocator);
}
materialTopology :: (material: *$T) ->WGPUPrimitiveTopology{
	return material.topology;//MATERIAL_METADATAS[material.materialTypeId].topology;
}




materialBindGroupLayoutsCount :: (material: *Material)->u32 {
	return 4;
}



#scope_file

NEXT_MATERIAL_ID :u64= 0;



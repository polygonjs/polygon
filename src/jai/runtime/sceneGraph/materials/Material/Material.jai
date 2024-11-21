EmptyUniforms :: struct {};

MaterialBase :: struct ($UniformType: Type) {
	type: Type;
	uniformType: Type=UniformType;
	uniformTypeSize: u32=size_of(UniformType);
	id: u64;
	//
	name: string;
	shader: string;
	uniforms: UniformType;
}
Material :: MaterialBase(Any);


newMaterial :: ($T: Type, scene: *NodesScene) -> *T {
	return newMaterial(T, scene.allocator);
}
newMaterial :: ($T: Type, allocator: Allocator) -> *T {
	previousAllocator := context.allocator;
	context.allocator = allocator;
	material: *T = alloc(size_of(T));
	context.allocator = previousAllocator;
	material.type = T;

	material.id = NEXT_MATERIAL_ID;
	NEXT_MATERIAL_ID += 1;

	materialInit(material);

	return material;
}
materialDelete :: (material: *$T) {
	free(material);
}

#scope_file

NEXT_MATERIAL_ID :u64= 0;

materialInit :: (material: *Material) {
}
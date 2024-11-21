EmptyUniforms :: struct {};

MaterialBase :: struct ($UniformType: Type) {
	allocator: Allocator;
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


newMaterial :: (scene: *Scene, $T: Type) -> *T {
	return newMaterial(T, scene.allocator);
}
newMaterial :: ($T: Type, allocator: Allocator) -> *T {
	material: *T = New(T,,allocator);
	material.allocator = allocator;
	material.type = T;

	material.id = NEXT_MATERIAL_ID;
	NEXT_MATERIAL_ID += 1;

	materialInit(material);

	return material;
}
materialDelete :: (material: *$T) {
	free(material,, material.allocator);
}

#scope_file

NEXT_MATERIAL_ID :u64= 0;

materialInit :: (material: *Material) {
}
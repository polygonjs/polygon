MaterialInitMethod :: #type (material: *Material);

EmptyUniforms :: struct {};

Material :: struct {
	type: Type;
	uniformType: Type;
	uniformTypeSize: u32;
	id: u64;
	//
	name: string;
	shader: string;
	uniforms: *void;
}



newMaterial :: ($T: Type) -> *T {
	material: *T = alloc(size_of(T));
	material.type = T;

	material.id = NEXT_MATERIAL_ID;
	NEXT_MATERIAL_ID += 1;

	materialInit(material);

	return material;
}

#scope_file

NEXT_MATERIAL_ID :u64= 0;

materialInit :: (material: *Material) {
}
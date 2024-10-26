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
	//
	init :MaterialInitMethod= init_material;
}



newMaterial :: ($T: Type) -> *T {
	material: *T = alloc(size_of(T));
	material.type = T;

	material.id = NEXT_MATERIAL_ID;
	NEXT_MATERIAL_ID+=1;

	tmp :T;
	material.init = tmp.init;
	material.init(material);

	return material;
}

#scope_file

NEXT_MATERIAL_ID :u64= 0;

init_material :: (material: *Material) {
}
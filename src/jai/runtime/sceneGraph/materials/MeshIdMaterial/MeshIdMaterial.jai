MeshIdMaterialUniforms :: struct {
	id:u32;
};

MeshIdMaterial :: struct {
	#as using material: MaterialBase(UNIFORM_TYPE);
};

materialInit :: (material: *MATERIAL_TYPE) {
	material.name = MATERIAL_NAME;
	material.shader = SHADER_RAW;
	material.uniforms.id = 0;
}
meshIdMaterialUnpackId :: (color: [4]u8) -> u32 {
	r := cast(u32) (color[0] + 0.5);
	g := cast(u32) (color[1] + 0.5);
	b := cast(u32) (color[2] + 0.5);
	
	return (b << 16) | (g << 8) | r;
}


#scope_file

SHADER_RAW :: #run import_shader();
import_shader :: () -> string { return "MeshIdMaterial.wgsl"; };
MATERIAL_TYPE :: MeshIdMaterial;
UNIFORM_TYPE :: MeshIdMaterialUniforms;
MATERIAL_NAME :: #run tprint("%", MATERIAL_TYPE);



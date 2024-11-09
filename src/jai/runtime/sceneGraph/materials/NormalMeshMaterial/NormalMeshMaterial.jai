NormalMeshMaterial :: struct {
	#as using material: MaterialBase(EmptyUniforms);
};

materialInit :: (material: *MATERIAL_TYPE) {
	material.name = MATERIAL_NAME;
	material.shader = SHADER_RAW;
}

#scope_file

SHADER_RAW :: #run import_shader();
import_shader :: () -> string { return "NormalMeshMaterial.wgsl"; };
MATERIAL_TYPE :: NormalMeshMaterial;
UNIFORM_TYPE :: EmptyUniforms;
MATERIAL_NAME :: #run tprint("%", MATERIAL_TYPE);


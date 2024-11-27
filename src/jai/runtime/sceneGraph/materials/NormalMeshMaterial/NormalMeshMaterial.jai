NormalMeshMaterial :: struct {
	#as using material: MaterialBase(EmptyUniforms);
};

materialInit :: (material: *TYPE) {
	material.name = MATERIAL_NAME;
	material.shader = SHADER_RAW;
}
registerMeshNormalMaterial :: (){
	materialRegister(TYPE, topology = .TriangleList);
}

#scope_file

SHADER_RAW :: #run import_shader();
import_shader :: () -> string { return "NormalMeshMaterial.wgsl"; };
TYPE :: NormalMeshMaterial;
UNIFORM_TYPE :: EmptyUniforms;
MATERIAL_NAME :: #run tprint("%", TYPE);


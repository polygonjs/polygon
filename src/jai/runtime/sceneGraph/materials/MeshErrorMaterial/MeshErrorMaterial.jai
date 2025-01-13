MeshErrorMaterial :: struct {
	#as using material: MaterialBase(EmptyUniforms, topology = .TriangleList);
};

materialInit :: (material: *TYPE) {
	baseMaterialInit(material);
	material.shader = SHADER_RAW;
}
registerMeshErrorMaterial :: () #compile_time {
	materialRegister(TYPE);
}

#scope_file

SHADER_RAW :: #run import_shader();
import_shader :: () -> string { return "MeshErrorMaterial.wgsl"; };
TYPE :: MeshErrorMaterial;
UNIFORM_TYPE :: EmptyUniforms;


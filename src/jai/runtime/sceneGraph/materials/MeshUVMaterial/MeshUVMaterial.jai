MeshUVMaterial :: struct {
	#as using material: MaterialBase(EmptyUniforms, topology = .TriangleList);
};

materialInit :: (material: *TYPE) {
	baseMaterialInit(material);
	// material.name = MATERIAL_NAME;
	material.shader = SHADER_RAW;
}
registerMeshUVMaterial :: () #compile_time {
	materialRegister(TYPE);
}

#scope_file

SHADER_RAW :: #run import_shader();
import_shader :: () -> string { return "MeshUVMaterial.wgsl"; };
TYPE :: MeshUVMaterial;
UNIFORM_TYPE :: EmptyUniforms;
// MATERIAL_NAME :: #run tprint("%", TYPE);


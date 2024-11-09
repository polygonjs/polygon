NormalMeshMaterial :: struct {
	#as using material: Material;
};

materialInit :: (material: *MATERIAL_TYPE) {
	material.uniformType = EmptyUniforms;
	material.uniformTypeSize = size_of(EmptyUniforms);

	material.name = MATERIAL_NAME;
	material.shader = SHADER_RAW;
	material.uniforms = alloc(size_of(EmptyUniforms));

	// assert(material.uniform_type, "uniform type is Undefined\n");
}

#scope_file

SHADER_RAW :: #run import_shader();
import_shader :: () -> string { return "NormalMeshMaterial.wgsl"; };
MATERIAL_TYPE :: NormalMeshMaterial;
MATERIAL_NAME :: #run tprint("%", MATERIAL_TYPE);


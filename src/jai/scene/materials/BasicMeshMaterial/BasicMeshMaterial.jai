BasicMeshMaterial :: struct {
	#as using material: Material;
	material.init = init_basic_mesh_material;

};

#scope_file

SHADER_RAW :: #run import_shader();
import_shader :: () -> string { return "BasicMeshMaterial.wgsl"; };

init_basic_mesh_material :: (base_material: *Material) {
	material := cast(*BasicMeshMaterial)base_material;
	material.uniformType = EmptyUniforms;
	material.uniformTypeSize = size_of(EmptyUniforms);

	material.name = "BasicMeshMaterial";
	material.shader = SHADER_RAW;
	material.uniforms = alloc(size_of(EmptyUniforms));


	// assert(material.uniform_type, "uniform type is Undefined\n");
}


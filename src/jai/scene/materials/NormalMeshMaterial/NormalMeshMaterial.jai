NormalMeshMaterial :: struct {
	#as using material: Material;
	material.init = init_normal_mesh_material;

};

#scope_file

SHADER_RAW :: #run import_shader();
import_shader :: () -> string { return "NormalMeshMaterial.wgsl"; };

init_normal_mesh_material :: (base_material: *Material) {
	material := cast(*NormalMeshMaterial)base_material;
	material.uniformType = EmptyUniforms;
	material.uniformTypeSize = size_of(EmptyUniforms);

	material.name = "NormalMeshMaterial";
	material.shader = SHADER_RAW;
	material.uniforms = alloc(size_of(EmptyUniforms));


	// assert(material.uniform_type, "uniform type is Undefined\n");
}


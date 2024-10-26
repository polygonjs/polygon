BasicMeshMaterialUniforms :: struct {
	color:Color;
};

BasicMeshMaterial :: struct {
	#as using material: Material;
	material.init = init_basic_mesh_material;

};

uniforms :: (material: *MATERIAL_TYPE) -> *UNIFORM_TYPE {
	return cast(*UNIFORM_TYPE)material.uniforms;
}
setColor :: (material: *MATERIAL_TYPE, color: Color) {
	uniforms(material).color = color;
}

#scope_file

SHADER_RAW :: #run import_shader();
import_shader :: () -> string { return "BasicMeshMaterial.wgsl"; };
MATERIAL_TYPE :: BasicMeshMaterial;
UNIFORM_TYPE :: BasicMeshMaterialUniforms;

init_basic_mesh_material :: (base_material: *Material) {
	material := cast(*MATERIAL_TYPE)base_material;
	material.uniformType = UNIFORM_TYPE;
	material.uniformTypeSize = size_of(UNIFORM_TYPE);

	material.name = "BasicMeshMaterial";
	material.shader = SHADER_RAW;
	material.uniforms = alloc(size_of(UNIFORM_TYPE));

	uniforms := cast(*UNIFORM_TYPE)material.uniforms;

	uniforms.color = .{1.0, 0.0, 0.0, 1.0};


	// assert(material.uniform_type, "uniform type is Undefined\n");
}


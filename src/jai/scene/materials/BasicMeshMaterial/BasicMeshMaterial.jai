BasicMeshMaterialUniforms :: struct {
	color:Color;
};

BasicMeshMaterial :: struct {
	#as using material: Material;
};

uniforms :: (material: *MATERIAL_TYPE) -> *UNIFORM_TYPE {
	return cast(*UNIFORM_TYPE)material.uniforms;
}
setColor :: (material: *MATERIAL_TYPE, color: Color) {
	uniforms(material).color = color;
}
materialInit :: (material: *MATERIAL_TYPE) {
	material.uniformType = UNIFORM_TYPE;
	material.uniformTypeSize = size_of(UNIFORM_TYPE);

	material.name = MATERIAL_NAME;
	material.shader = SHADER_RAW;
	material.uniforms = alloc(size_of(UNIFORM_TYPE));

	uniforms := cast(*UNIFORM_TYPE)material.uniforms;

	uniforms.color = .{1.0, 0.0, 0.0, 1.0};


	// assert(material.uniform_type, "uniform type is Undefined\n");
}


#scope_file

SHADER_RAW :: #run import_shader();
import_shader :: () -> string { return "BasicMeshMaterial.wgsl"; };
MATERIAL_TYPE :: BasicMeshMaterial;
UNIFORM_TYPE :: BasicMeshMaterialUniforms;
MATERIAL_NAME :: #run tprint("%", MATERIAL_TYPE);



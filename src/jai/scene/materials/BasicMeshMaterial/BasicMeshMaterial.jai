BasicMeshMaterialUniforms :: struct {
	color:Color;
};

BasicMeshMaterial :: struct {
	#as using material: MaterialBase(UNIFORM_TYPE);
};

// uniforms :: (material: *MATERIAL_TYPE) -> *UNIFORM_TYPE {
// 	return cast(*UNIFORM_TYPE)material.uniforms;
// }
setColor :: (material: *MATERIAL_TYPE, color: Color) {
	material.uniforms.color = color;
}
materialInit :: (material: *MATERIAL_TYPE) {
	material.name = MATERIAL_NAME;
	material.shader = SHADER_RAW;
	material.uniforms.color = .{1.0, 0.0, 0.0, 1.0};
}


#scope_file

SHADER_RAW :: #run import_shader();
import_shader :: () -> string { return "BasicMeshMaterial.wgsl"; };
MATERIAL_TYPE :: BasicMeshMaterial;
UNIFORM_TYPE :: BasicMeshMaterialUniforms;
MATERIAL_NAME :: #run tprint("%", MATERIAL_TYPE);



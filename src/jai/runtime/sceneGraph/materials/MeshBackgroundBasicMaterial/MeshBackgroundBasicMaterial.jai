MeshBackgroundBasicMaterialUniforms :: struct {
	color:Color;
};

MeshBackgroundBasicMaterial :: struct {
	#as using material: MaterialBase(UNIFORM_TYPE);
};
registerMeshBackgroundBasicMaterial :: () #compile_time {
	materialRegister(TYPE, topology = .TriangleList);
}
// uniforms :: (material: *MATERIAL_TYPE) -> *UNIFORM_TYPE {
// 	return cast(*UNIFORM_TYPE)material.uniforms;
// }
setColor :: (material: *TYPE, color: Color) {
	material.uniforms.color = color;
}
materialInit :: (material: *TYPE) {
	material.name = MATERIAL_NAME;
	material.shader = SHADER_RAW;
	material.uniforms.color = .{0.0, 0.0, 0.0, 1.0};
}


#scope_file

SHADER_RAW :: #run import_shader();
import_shader :: () -> string { return "MeshBackgroundBasicMaterial.wgsl"; };
TYPE :: MeshBackgroundBasicMaterial;
UNIFORM_TYPE :: MeshBackgroundBasicMaterialUniforms;
MATERIAL_NAME :: #run tprint("%", TYPE);



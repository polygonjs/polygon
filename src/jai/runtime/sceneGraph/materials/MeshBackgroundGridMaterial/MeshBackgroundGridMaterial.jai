MeshBackgroundGridMaterialUniforms :: struct {
	color:Color;
};

MeshBackgroundGridMaterial :: struct {
	#as using material: MaterialBase(UNIFORM_TYPE, topology = .TriangleList);
};
registerMeshBackgroundGridMaterial :: () #compile_time {
	materialRegister(TYPE);
}
// uniforms :: (material: *MATERIAL_TYPE) -> *UNIFORM_TYPE {
// 	return cast(*UNIFORM_TYPE)material.uniforms;
// }
setColor :: (material: *TYPE, color: Color) {
	material.uniforms.color = color;
}
materialInit :: (material: *TYPE) {
	baseMaterialInit(material);
	// material.name = MATERIAL_NAME;
	material.shader = SHADER_RAW;
	material.uniforms.color = .{0.0, 0.0, 0.0, 1.0};
}


#scope_file

SHADER_RAW :: #run import_shader();
import_shader :: () -> string { return "MeshBackgroundGridMaterial.wgsl"; };
TYPE :: MeshBackgroundGridMaterial;
UNIFORM_TYPE :: MeshBackgroundGridMaterialUniforms;
// MATERIAL_NAME :: #run tprint("%", TYPE);



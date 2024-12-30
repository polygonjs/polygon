PointBasicMaterialUniforms :: struct {
	color:Color;
};

PointBasicMaterial :: struct {
	#as using material: MaterialBase(UNIFORM_TYPE, topology = .PointList);
};

registerPointBasicMaterial :: () #compile_time {
	materialRegister(TYPE);
}

// uniforms :: (material: *TYPE) -> *UNIFORM_TYPE {
// 	return cast(*UNIFORM_TYPE)material.uniforms;
// }
setColor :: (material: *TYPE, color: Color) {
	material.uniforms.color = color;
}
materialInit :: (material: *TYPE) {
	baseMaterialInit(material);
	// material.name = MATERIAL_NAME;
	material.shader = SHADER_RAW;
	material.uniforms.color = .{1.0, 0.0, 0.0, 1.0};
}


#scope_file

SHADER_RAW :: #run import_shader();
import_shader :: () -> string { return "PointBasicMaterial.wgsl"; };
TYPE :: PointBasicMaterial;
UNIFORM_TYPE :: PointBasicMaterialUniforms;
// MATERIAL_NAME :: #run tprint("%", TYPE);



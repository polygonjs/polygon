RaymarchingMeshMaterialUniforms :: struct {
	offset:Vector4;
};

RaymarchingMeshMaterial :: struct {
	#as using material: MaterialBase(UNIFORM_TYPE);
};
registerMeshRaymarchingMaterial :: (){
	materialRegister(TYPE, topology = .TriangleList);
}

// uniforms :: (material: *MATERIAL_TYPE) -> *UNIFORM_TYPE {
// 	return cast(*UNIFORM_TYPE)material.uniforms;
// }

materialInit :: (material: *TYPE) {
	material.name = MATERIAL_NAME;
	material.shader = SHADER_RAW;
	material.uniforms.offset = .{0.0, 0.0, 0.0, 0.0};
}


#scope_file


SHADER_RAW :: #run import_shader();
import_shader :: () -> string { return "RaymarchingMeshMaterial.wgsl"; };
TYPE :: RaymarchingMeshMaterial;
UNIFORM_TYPE :: RaymarchingMeshMaterialUniforms;
MATERIAL_NAME :: #run tprint("%", TYPE);




MeshRaymarchingMaterialUniforms :: struct {
	offset:Vector4;
};

MeshRaymarchingMaterial :: struct {
	#as using material: MaterialBase(UNIFORM_TYPE, topology = .TriangleList);
};
registerMeshRaymarchingMaterial :: () #compile_time {
	materialRegister(TYPE);
}

// uniforms :: (material: *MATERIAL_TYPE) -> *UNIFORM_TYPE {
// 	return cast(*UNIFORM_TYPE)material.uniforms;
// }

materialInit :: (material: *TYPE) {
	baseMaterialInit(material);
	// material.name = MATERIAL_NAME;
	material.shader = SHADER_RAW;
	material.uniforms.offset = .{0.0, 0.0, 0.0, 0.0};
}


#scope_file


SHADER_RAW :: #run import_shader();
import_shader :: () -> string { return "MeshRaymarchingMaterial.wgsl"; };
TYPE :: MeshRaymarchingMaterial;
UNIFORM_TYPE :: MeshRaymarchingMaterialUniforms;
// MATERIAL_NAME :: #run tprint("%", TYPE);




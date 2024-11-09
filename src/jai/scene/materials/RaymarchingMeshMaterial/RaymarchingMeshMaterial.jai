RaymarchingMeshMaterialUniforms :: struct {
	offset:Vector4;
};

RaymarchingMeshMaterial :: struct {
	#as using material: Material;
};

uniforms :: (material: *MATERIAL_TYPE) -> *UNIFORM_TYPE {
	return cast(*UNIFORM_TYPE)material.uniforms;
}

materialInit :: (material: *MATERIAL_TYPE) {
	material.uniformType = UNIFORM_TYPE;
	material.uniformTypeSize = size_of(UNIFORM_TYPE);

	material.name = MATERIAL_NAME;
	material.shader = SHADER_RAW;
	material.uniforms = alloc(size_of(UNIFORM_TYPE));

	uniforms := cast(*UNIFORM_TYPE)material.uniforms;

	uniforms.offset = .{0.0, 0.0, 0.0, 0.0};

}


#scope_file


SHADER_RAW :: #run import_shader();
import_shader :: () -> string { return "RaymarchingMeshMaterial.wgsl"; };
MATERIAL_TYPE :: RaymarchingMeshMaterial;
UNIFORM_TYPE :: RaymarchingMeshMaterialUniforms;
MATERIAL_NAME :: #run tprint("%", MATERIAL_TYPE);




RaymarchingMeshMaterialUniforms :: struct {
	offset:Vector4;
};

RaymarchingMeshMaterial :: struct {
	#as using material: Material;
	material.init = init_raymarching_mesh_material;

};

uniforms :: (material: *MATERIAL_TYPE) -> *UNIFORM_TYPE {
	return cast(*UNIFORM_TYPE)material.uniforms;
}

#scope_file


SHADER_RAW :: #run import_shader();
import_shader :: () -> string { return "RaymarchingMeshMaterial.wgsl"; };
MATERIAL_TYPE :: RaymarchingMeshMaterial;
UNIFORM_TYPE :: RaymarchingMeshMaterialUniforms;


init_raymarching_mesh_material :: (base_material: *Material) {
	material := cast(*MATERIAL_TYPE)base_material;
	material.uniformType = UNIFORM_TYPE;
	material.uniformTypeSize = size_of(UNIFORM_TYPE);

	material.name = "RaymarchingMeshMaterial";
	material.shader = SHADER_RAW;
	material.uniforms = alloc(size_of(UNIFORM_TYPE));

	uniforms := cast(*UNIFORM_TYPE)material.uniforms;

	uniforms.offset = .{0.0, 0.0, 0.0, 0.0};

}


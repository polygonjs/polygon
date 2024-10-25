SDFUniforms :: struct {
	offset:Vector4;
};

RaymarchingMeshMaterial :: struct {
	#as using material: Material;
	material.init = init_raymarching_mesh_material;

};

#scope_file

SHADER_RAW :: #run import_shader();
import_shader :: () -> string { return "RaymarchingMeshMaterial.wgsl"; };

init_raymarching_mesh_material :: (base_material: *Material) {
	material := cast(*RaymarchingMeshMaterial)base_material;
	material.uniformType = SDFUniforms;
	material.uniformTypeSize = size_of(SDFUniforms);

	material.name = "RaymarchingMeshMaterial";
	material.shader = SHADER_RAW;
	material.uniforms = alloc(size_of(SDFUniforms));

	uniforms := cast(*SDFUniforms)material.uniforms;

	uniforms.offset = .{0.0, 0.0, 0.0, 0.0};

}


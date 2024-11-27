MeshIdU32MaterialUniforms :: struct {
	id:u32;
};

MeshIdU32Material :: struct {
	#as using material: MaterialBase(UNIFORM_TYPE);
};
registerMeshIdU32Material :: (){
	materialRegister(TYPE, topology = .TriangleList);
}

// uniforms :: (material: *MATERIAL_TYPE) -> *UNIFORM_TYPE {
// 	return cast(*UNIFORM_TYPE)material.uniforms;
// }
// setColor :: (material: *MATERIAL_TYPE, color: Color) {
// 	material.uniforms.color = color;
// }
materialInit :: (material: *TYPE) {
	material.name = MATERIAL_NAME;
	material.shader = SHADER_RAW;
	material.uniforms.id = 0;
}


#scope_file

SHADER_RAW :: #run import_shader();
import_shader :: () -> string { return "MeshIdU32Material.wgsl"; };
TYPE :: MeshIdU32Material;
UNIFORM_TYPE :: MeshIdU32MaterialUniforms;
MATERIAL_NAME :: #run tprint("%", TYPE);



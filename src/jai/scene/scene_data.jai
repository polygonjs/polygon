Time :: float32;
VertexIndex :: u32;
VertexLayoutBuffer :: u8;
Matrix4x4Buffer :: [16]float;



SceneData :: struct {
	time: Time;
	// object
	box_size: Vector3=.{3.0, 1.0, 1.0};
	offset: Vector3;
	//
	bg_color :Color =.{0.1, 0.3, 0.72, 1.0};
	camera: CameraData;
	//
	meshes0: [..]Mesh;
	meshes1: [..]Mesh;
	// string tests
	node_name: string;
};



matrix4x4_to_buffer :: (matrix: *Matrix4, buffer: *Matrix4x4Buffer) #expand {
	memcpy(buffer.data, matrix, 16 * size_of(float));
}


init_scene_data :: (scene_data: *SceneData, aspect:float32) {
	scene_data.camera.aspect = aspect;
	scene_data.camera = camera_data_create();

	{
		mesh0 := mesh_create();
		mesh1 := mesh_create();
		mesh0.position = .{x = -2.0, y = 0.0, z = -2.0};
		mesh1.position = .{x = 2.0, y = 1.0, z = -1.0};
		mesh_update_matrix(*mesh0);
		mesh_update_matrix(*mesh1);
		array_add(*scene_data.meshes0, mesh0);
		array_add(*scene_data.meshes0, mesh1);
	}
	{
		mesh2 := mesh_create();
		mesh3 := mesh_create();
		mesh2.material = cast(*Material(Any)) *MATERIAL_RAYMARCHING;
		mesh3.material = cast(*Material(Any)) *MATERIAL_RAYMARCHING;
		mesh2.position = .{x = -0.0, y = 1.0, z = 0.0};
		mesh3.position = .{x = -0.0, y = -1.0, z = 1.0};
		array_add(*scene_data.meshes1, mesh2);
		array_add(*scene_data.meshes1, mesh3);
	}
}

update_scene_data_uniforms :: (scene_data: *SceneData) {
	for scene_data.meshes0 {
		// mesh_update_matrix(*it);
		mesh_uniforms_update(*it);
	}
	for scene_data.meshes1 {
		// mesh_update_matrix(*it);
		mesh_uniforms_update(*it);
	}
	// update_object_uniforms(*scene_data.object_data, *scene_data.object_uniforms);
	camera_data_uniforms_update(*scene_data.camera, scene_data.time);
	// update_sdf_uniforms(*scene_data.sdf_data, *scene_data.sdf_uniforms, scene_data.time);
}


// update_sdf_uniforms :: (sdf_data: *[1]SDFData, sdf_uniforms: *[1]SDFUniforms, time: Time) {
// 	(<<sdf_uniforms)[0].offset = (<<sdf_data)[0].offset;
// }
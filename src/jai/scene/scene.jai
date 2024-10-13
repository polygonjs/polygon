Time :: float32;

Matrix4x4Buffer :: [16]float;

SceneDataNoise :: struct {
	freq: Vector3 = .{2.0, 2.0, 2.0};
	offset: Vector3 = .{0.0, 0.0, 0.0};
	amount: Vector3 = .{1.0, 1.0, 1.0};
}

Scene :: struct {
	time: Time;
	// object
	box_size: Vector3=.{3.0, 1.0, 1.0};
	translate: Vector3;
	//
	camera: CameraData;
	//
	meshes0: [..]Mesh;
	meshes1: [..]Mesh;
	meshes2: [..]Mesh;
	// string tests
	node_name: string;
	//
	segments: Vector3Int = .{128, 128, 128};
	noise:SceneDataNoise;
	//
	orbit_controls:OrbitControls;
};



matrix4x4_to_buffer :: (matrix: *Matrix4, buffer: *Matrix4x4Buffer) #expand {
	memcpy(buffer.data, matrix, 16 * size_of(float));
}


init_scene_world :: (scene: *Scene, aspect:float32) {
	scene.camera.aspect = aspect;
	scene.camera = camera_data_create();

	// {
	// 	mesh0 := mesh_create();
	// 	// mesh1 := mesh_create();
	// 	// mesh0.position = .{x = -2.0, y = 0.0, z = -4.0};
	// 	// mesh1.position = .{x = 2.0, y = 1.0, z = -3.0};
	// 	// mesh_update_matrix(*mesh0);
	// 	// mesh_update_matrix(*mesh1);
	// 	mesh_update_matrix(*mesh0);
	// 	array_add(*scene.meshes0, mesh0);
	// 	// array_add(*scene_data.meshes0, mesh1);
	// }
	// {
	// 	mesh0 := mesh_create();
	// 	geometry_add_noise(*mesh0.geometry, scene_data.freq);
	// 	mesh1 := mesh_create();
	// 	mesh0.material = cast(*Material(Any)) *MATERIAL_RAYMARCHING;
	// 	mesh1.material = cast(*Material(Any)) *MATERIAL_RAYMARCHING;
	// 	mesh0.position = .{x = -0.0, y = 1.0, z = -2.0};
	// 	mesh1.position = .{x = -0.0, y = -2.0, z = -1.0};
	// 	mesh_update_matrix(*mesh0);
	// 	mesh_update_matrix(*mesh1);
	// 	array_add(*scene_data.meshes1, mesh0);
	// 	array_add(*scene_data.meshes1, mesh1);
	// }
	{
		mesh0 := mesh_create();
		geometry_icosahedron_update(*mesh0.geometry, 18);
		// geometry_add_noise(*mesh0.geometry, scene_data.freq);
		// mesh1 := mesh_create();
		mesh0.material = cast(*Material(Any)) *MATERIAL_BASIC;
		// mesh1.material = cast(*Material(Any)) *MATERIAL_BASIC;
		mesh0.position = .{x = 0.0, y = 0.0, z = 0.0};
		// mesh1.position = .{x = -1.0, y = -1.0, z = 1.0};
		mesh_update_matrix(*mesh0);
		array_add(*scene.meshes2, mesh0);
		// array_add(*scene_data.meshes2, mesh1);
	}
}
init_scene_nodes :: (scene: *Scene, aspect:float32) {
	scene.camera.aspect = aspect;
	scene.camera = camera_data_create();

	{
		mesh0 := mesh_create();
		geometry_box_update(*mesh0.geometry, .{4,4,4});
		// mesh1 := mesh_create();
		// geometry_box_update(*mesh1.geometry, .{4,4,4});
		mesh0.position = .{x = -3.0, y = -1.0, z = -4.0};
		// mesh1.position = .{x = 3.0, y = 1.0, z = -3.0};
		// mesh_update_matrix(*mesh0);
		// mesh_update_matrix(*mesh1);
		mesh_update_matrix(*mesh0);
		// mesh_update_matrix(*mesh1);
		array_add(*scene.meshes0, mesh0);
		// array_add(*scene.meshes0, mesh1);
	}
	
}



update_scene_data_uniforms :: (scene: *Scene) {
	for scene.meshes0 {
		// mesh_update_matrix(*it);
		mesh_uniforms_update(*it);
	}
	for scene.meshes1 {
		// mesh_update_matrix(*it);
		mesh_uniforms_update(*it);
	}
	// update_object_uniforms(*scene_data.object_data, *scene_data.object_uniforms);
	camera_data_uniforms_update(*scene.camera, scene.time);
	// update_sdf_uniforms(*scene_data.sdf_data, *scene_data.sdf_uniforms, scene_data.time);
}


// update_sdf_uniforms :: (sdf_data: *[1]SDFData, sdf_uniforms: *[1]SDFUniforms, time: Time) {
// 	(<<sdf_uniforms)[0].offset = (<<sdf_data)[0].offset;
// }
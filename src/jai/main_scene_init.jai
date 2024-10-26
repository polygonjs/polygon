
init_scene_world :: (scene: *Scene, aspect:float32) {

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
	// normalMat := newMaterial(NormalMeshMaterial);
	{
		raymarchingMat := newMaterial(RaymarchingMeshMaterial);
		mesh := newObject3D(Mesh);
		
		geometry_icosahedron_update(mesh.geometry, 18);
		// geometry_add_noise(*mesh0.geometry, scene_data.freq);
		// mesh1 := mesh_create();
		mesh.material = raymarchingMat;
		// mesh1.material = cast(*Material(Any)) *MATERIAL_BASIC;
		mesh.position = .{x = 0.0, y = 0.0, z = 0.0};
		// mesh1.position = .{x = -1.0, y = -1.0, z = 1.0};
		transformable_update_matrix(mesh);
		array_add(*scene.children, mesh);
		// array_add(*scene_data.meshes2, mesh1);
	}
	{
		normalMat := newMaterial(NormalMeshMaterial);
		mesh := newObject3D(Mesh);
		
		geometry_box_update(mesh.geometry, segments=.{2,2,2});
		// geometry_add_noise(*mesh0.geometry, scene_data.freq);
		// mesh1 := mesh_create();
		mesh.material = normalMat;
		// mesh1.material = cast(*Material(Any)) *MATERIAL_BASIC;
		mesh.position = .{x = 0.0, y = -2.0, z = 0.0};
		// mesh1.position = .{x = -1.0, y = -1.0, z = 1.0};
		transformable_update_matrix(mesh);
		array_add(*scene.children, mesh);
		// array_add(*scene_data.meshes2, mesh1);
	}
}
init_scene_nodes :: (scene: *Scene, aspect:float32) {

	normalMat := newMaterial(NormalMeshMaterial);
	{
		mesh0 := newObject3D(Mesh);
		mesh0.material = normalMat;
		geometry_box_update(mesh0.geometry, .{4,4,4});
		mesh1 := newObject3D(Mesh);
		mesh1.material = normalMat;
		geometry_box_update(mesh1.geometry, .{4,4,4});
		mesh0.position = .{x = -3.0, y = -1.0, z = -4.0};
		mesh1.position = .{x = 3.0, y = 1.0, z = -3.0};
		// mesh_update_matrix(*mesh0);
		// mesh_update_matrix(*mesh1);
		transformable_update_matrix(mesh0);
		transformable_update_matrix(mesh1);
		array_add(*scene.children, mesh0);
		array_add(*scene.children, mesh1);
	}
	
}

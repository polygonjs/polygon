
init_scene_world :: (scene: *Scene, aspect:float32) {

	{
		mat := newMaterial(BackgroundMeshMaterial);
		setColor(mat, .{0.0, 0.0, 0.0, 1.0});
		mesh0 := newObject3D(Mesh);
		mesh0.material = mat;
		geometry_plane_update(mesh0.geometry, size=.{2,2}, segments=.{1,1});
		transformable_update_matrix(mesh0);
		array_add(*scene.children, mesh0);
	}
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
	{
		basicMat := newMaterial(BasicMeshMaterial);
		setColor(basicMat, .{1.0, 0.0, 0.0, 1.0});
		mesh := newObject3D(Mesh);
		
		geometry_box_update(mesh.geometry, segments=.{1,1,1});
		// geometry_add_noise(*mesh0.geometry, scene_data.freq);
		// mesh1 := mesh_create();
		mesh.material = basicMat;
		// mesh1.material = cast(*Material(Any)) *MATERIAL_BASIC;
		mesh.position = .{x = +2.0, y = -1.0, z = 0.0};
		// mesh1.position = .{x = -1.0, y = -1.0, z = 1.0};
		transformable_update_matrix(mesh);
		array_add(*scene.children, mesh);
		// array_add(*scene_data.meshes2, mesh1);
	}
	{
		basicMat := newMaterial(BasicMeshMaterial);
		setColor(basicMat, .{0.0, 0.0, 1.0, 1.0});
		mesh := newObject3D(Mesh);
		
		geometry_box_update(mesh.geometry, segments=.{1,1,1});
		// geometry_add_noise(*mesh0.geometry, scene_data.freq);
		// mesh1 := mesh_create();
		mesh.material = basicMat;
		// mesh1.material = cast(*Material(Any)) *MATERIAL_BASIC;
		mesh.position = .{x = -2.0, y = -1.0, z = 0.0};
		// mesh1.position = .{x = -1.0, y = -1.0, z = 1.0};
		transformable_update_matrix(mesh);
		array_add(*scene.children, mesh);
		// array_add(*scene_data.meshes2, mesh1);
	}
}
init_scene_nodes :: (scene: *Scene, aspect:float32) {

	{
		mat := newMaterial(BackgroundMeshMaterial);
		setColor(mat, .{0.1, 0.1, 0.1, 1.0});
		mesh0 := newObject3D(Mesh);
		mesh0.material = mat;
		geometry_plane_update(mesh0.geometry, size=.{2,2}, segments=.{1,1});
		transformable_update_matrix(mesh0);
		array_add(*scene.children, mesh0);
	}
	{
		mat := newMaterial(NormalMeshMaterial);
		mesh0 := newObject3D(Mesh);
		mesh0.material = mat;
		geometry_box_update(mesh0.geometry, .{4,4,4});
		mesh1 := newObject3D(Mesh);
		mesh1.material = mat;
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

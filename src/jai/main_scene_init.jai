
scene_init_world :: (scene: *Scene, aspect:float32) {

	{
		mat := newMaterial(BackgroundMeshMaterial);
		setColor(mat, .{0.0, 0.0, 0.0, 1.0});
		mesh0 := newObject3D(Mesh);
		mesh0.material = mat;
		geometry_plane_update(mesh0.geometry, size=.{2,2}, segments=.{1,1});
		transformable_update_matrix(mesh0);
		array_add(*scene.children, mesh0);
	}
	// {
	// 	raymarchingMat := newMaterial(RaymarchingMeshMaterial);
	// 	mesh := newObject3D(Mesh);
		
	// 	geometry_icosahedron_update(mesh.geometry, 18);
	// 	// geometry_add_noise(*mesh0.geometry, scene_data.freq);
	// 	// mesh1 := mesh_create();
	// 	mesh.material = raymarchingMat;
	// 	// mesh1.material = cast(*Material(Any)) *MATERIAL_BASIC;
	// 	mesh.position = .{x = 0.0, y = 0.0, z = 0.0};
	// 	// mesh1.position = .{x = -1.0, y = -1.0, z = 1.0};
	// 	transformable_update_matrix(mesh);
	// 	array_add(*scene.children, mesh);
	// 	// array_add(*scene_data.meshes2, mesh1);
	// }
	{
		mat := newMaterial(NormalMeshMaterial);
		mesh := newObject3D(Mesh);
		mesh.use_compute = true;
		geometry_icosahedron_update(mesh.geometry, 18);
		mesh.material = mat;
		mesh.position = .{x = 0.0, y = 0.0, z = 0.0};
		transformable_update_matrix(mesh);
		array_add(*scene.children, mesh);
	}
	{
		normalMat := newMaterial(NormalMeshMaterial);
		mesh := newObject3D(Mesh);
		geometry_box_update(mesh.geometry, segments=.{2,2,2});
		mesh.material = normalMat;
		mesh.position = .{x = 0.0, y = -2.0, z = 0.0};
		transformable_update_matrix(mesh);
		array_add(*scene.children, mesh);
	}
	{
		basicMat := newMaterial(BasicMeshMaterial);
		setColor(basicMat, .{1.0, 0.0, 0.0, 1.0});
		mesh := newObject3D(Mesh);
		geometry_box_update(mesh.geometry, segments=.{1,1,1});
		mesh.material = basicMat;
		mesh.position = .{x = +2.0, y = -1.0, z = 0.0};
		transformable_update_matrix(mesh);
		array_add(*scene.children, mesh);
	}
	{
		basicMat := newMaterial(BasicMeshMaterial);
		setColor(basicMat, .{0.0, 0.0, 1.0, 1.0});
		mesh := newObject3D(Mesh);
		geometry_box_update(mesh.geometry, segments=.{1,1,1});
		mesh.material = basicMat;
		mesh.position = .{x = -2.0, y = -1.0, z = 0.0};
		transformable_update_matrix(mesh);
		array_add(*scene.children, mesh);
	}
}

box1 :*BoxGeoNode;
scene_init_nodes :: (scene: *Scene, aspect:float32) {

	// box0 :BoxGeoNode;
	// handle_params(*box0);
	// print("box0: %\n", box0);
	// print("box0.p: %\n", box0.p);
	// print("box0.p.size: %\n", box0.p.size);
	// print("box0.p.size.type: %\n", box0.p.size.type);

	nodesScene := newNodesScene();
	box1 = newNode(nodesScene, BoxGeoNode);
	// print("box1 size: % % %\n", box1.p.size.id, box1.p.size.type, box1.p.size.value);
	// print("box1 scale: % % %\n", box1.p.scale.id, box1.p.scale.type, box1.p.scale.value);
	// sphere1 := newNode(nodesScene, SphereGeoNode);
	// switch1 := newNode(nodesScene, SwitchGeoNode);
	// print("is_constant:% (%)\n", is_constant(sphere1.ctx), sphere1.ctx);
	// setInput(switch1, 0, box1);
	// setInput(switch1, 1, sphere1);
	// print("nodes:%\n", nodesScene.nodes);
	// print("box1:%\n", box1.type);
	// print("sphere1:%\n", sphere1.type);
	// print("switch1:%\n", switch1.type);
	// print("box1==sphere1:%, %\n", type_of(box1.type), type_of(sphere1.type));

	onBoxDirty :CoreGraphNodeOnDirtyMethod: (node: *CoreGraphNode) {
		nodeCompute(box1);
	}
	box1.onDirty = onBoxDirty;

	paramSetValue(*box1.p.scale, 2.0);

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


scene_on_tick_world :: (scene: *Scene) {
	for mesh: scene.children {
		if mesh.material.type == RaymarchingMeshMaterial {
			material := cast(*RaymarchingMeshMaterial)mesh.material;
			uniforms := cast(*RaymarchingMeshMaterialUniforms)material.uniforms;
			uniforms.offset.y = sin(scene.time);
		}
	}
}
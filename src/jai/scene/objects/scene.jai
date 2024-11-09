Time :: float32;

SceneDataNoise :: struct {
	freq: Vector3 = .{2.0, 2.0, 2.0};
	offset: Vector3 = .{0.0, 0.0, 0.0};
	amount: Vector3 = .{1.0, 1.0, 1.0};
}

SceneUniforms :: struct {
	time:Vector4;
};


Scene :: struct {
	#as using object3D: Object3D;

	time: Time=0;
	children: [..]*Object3D;

	scene_uniforms: SceneUniforms;

	// old
	// object
	box_size: Vector3=.{3.0, 1.0, 1.0};
	translate: Vector3;
	// string tests
	node_name: string;
	//
	segments: Vector3Int = .{128, 128, 128};
	noise:SceneDataNoise;
};

object3DInit :: (scene: *Scene) {
	object3DInit(cast(*Object3D)scene);
	array_init(*scene.children, temp);
}

sceneObjectRemove :: (scene: *Scene, object: *Object3D) {
	for child, i: scene.children {
		if child == object {
			scene.children[i] = null;
			object3DDelete(object);
		}
	}
}

sceneUniformsUpdate :: (scene: *Scene) {
	scene.scene_uniforms.time.x = scene.time;

	for scene.children {
		// mesh_update_matrix(*it);
		if it!=null transformable_uniforms_update(it);
	}
	// for scene.children {
	// 	// mesh_update_matrix(*it);
	// 	if it!=null transformable_uniforms_update(it);
	// }
	// update_object_uniforms(*scene_data.object_data, *scene_data.object_uniforms);
	// update_sdf_uniforms(*scene_data.sdf_data, *scene_data.sdf_uniforms, scene_data.time);
}

#scope_file





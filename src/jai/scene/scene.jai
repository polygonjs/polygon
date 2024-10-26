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
	children: [..]*Mesh;
	// string tests
	node_name: string;
	//
	segments: Vector3Int = .{128, 128, 128};
	noise:SceneDataNoise;
};



matrix4x4_to_buffer :: (matrix: *Matrix4, buffer: *Matrix4x4Buffer) #expand {
	memcpy(buffer.data, matrix, 16 * size_of(float));
}


update_scene_data_uniforms :: (scene: *Scene) {
	for scene.children {
		// mesh_update_matrix(*it);
		if it!=null transformable_uniforms_update(it);
	}
	for scene.children {
		// mesh_update_matrix(*it);
		if it!=null transformable_uniforms_update(it);
	}
	// update_object_uniforms(*scene_data.object_data, *scene_data.object_uniforms);
	// update_sdf_uniforms(*scene_data.sdf_data, *scene_data.sdf_uniforms, scene_data.time);
}

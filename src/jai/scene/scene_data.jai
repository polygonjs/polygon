Time :: float32;
VertexIndex :: u32;
VertexLayoutBuffer :: u8;
Matrix4x4Buffer :: [16]float;


SDFData :: struct {
	offset:Vector4;
};
SDFUniforms :: struct {
	offset:Vector4;
};

SceneData :: struct {
	time: Time;
	// object
	box_size: Vector3=.{3.0, 1.0, 1.0};
	offset: Vector3;
	//
	bg_color :Color =.{0.1, 0.3, 0.72, 1.0};
	//
	// vertices: [..]Vertex;
	// indices: [..]VertexIndex;
	// object_data: [1]ObjectData;
	// object_uniforms: [1]ObjectUniforms;
	meshes: [..]Mesh;
	// camera
	camera: CameraData;
	// sdf
	sdf_data: [1]SDFData;
	sdf_uniforms: [1]SDFUniforms;
	// string tests
	node_name: string;
};



matrix4x4_to_buffer :: (matrix: *Matrix4, buffer: *Matrix4x4Buffer) #expand {
	memcpy(buffer.data, matrix, 16 * size_of(float));
}


init_scene_data :: (scene_data: *SceneData, aspect:float32) {
	// scene_data.vertices, scene_data.indices = create_vertices();
	array_add(*scene_data.meshes, mesh_create());
	// scene_data.mesh = mesh_create();
	// scene_data.object_uniforms = create_object_uniforms(*scene_data.object_data);
	// scene_data.camera_fov_in_degrees = fov_in_degrees;
	scene_data.camera = camera_data_create();
	// scene_data.camera_uniforms = create_camera_uniforms(*scene_data.camera_data);

	scene_data.camera.aspect = aspect;
}

update_scene_data_uniforms :: (scene_data: *SceneData) {
	for scene_data.meshes mesh_uniforms_update(*it);
	// update_object_uniforms(*scene_data.object_data, *scene_data.object_uniforms);
	camera_data_uniforms_update(*scene_data.camera, scene_data.time);
	update_sdf_uniforms(*scene_data.sdf_data, *scene_data.sdf_uniforms, scene_data.time);
}


update_sdf_uniforms :: (sdf_data: *[1]SDFData, sdf_uniforms: *[1]SDFUniforms, time: Time) {
	(<<sdf_uniforms)[0].offset = (<<sdf_data)[0].offset;
}
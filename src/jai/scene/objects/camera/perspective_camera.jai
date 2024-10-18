PerspectiveCamera :: struct {
	#as using camera: Camera;
	camera.init = init_perspective_camera;

	aspect: float32;
	fov_in_degrees: float32 = 50.0;
}

init_perspective_camera :: (object: *Object3D) {
	camera := cast(*PerspectiveCamera)object;
	tmp:PerspectiveCamera;
	camera.near = tmp.near;
	camera.far = tmp.far;
	camera.aspect = tmp.aspect;
	camera.fov_in_degrees = tmp.fov_in_degrees;
	camera_matrices_init(camera);
	camera_uniforms_update(camera, 0.0);
}


camera_projection_update :: (camera:*PerspectiveCamera) {
	// print("scene_data.camera_aspect:%, %\n", scene_data.camera_aspect, camera_data[0].projectionMatrix);
	camera.camera_matrices.projectionMatrix = make_projection_matrix(
		deg_to_rad(camera.fov_in_degrees),
		camera.aspect,
		camera.near,
		camera.far
	);
}

camera_uniforms_update :: (camera: *PerspectiveCamera, time: Time) {
	camera.camera_uniforms.time.x = time;
	camera.camera_uniforms.worldPos.x = camera.camera_matrices.transformMatrix._14;
	camera.camera_uniforms.worldPos.y = camera.camera_matrices.transformMatrix._24;
	camera.camera_uniforms.worldPos.z = camera.camera_matrices.transformMatrix._34;

	transformMatrixInverse := inverse(transpose(camera.camera_matrices.transformMatrix));
	projectionMatrix := transpose(camera.camera_matrices.projectionMatrix);
	matrix4x4_to_buffer(*transformMatrixInverse, *camera.camera_uniforms.transformMatrixInverse);
	matrix4x4_to_buffer(*projectionMatrix, *camera.camera_uniforms.projectionMatrix);
}

#scope_file

camera_matrices_init :: (camera:*PerspectiveCamera) {
	// camera_data[0].projectionMatrix = make_projection_matrix(deg_to_rad(fov), aspect, 0.1, 100);
	camera_projection_update(camera);
	identity(*camera.camera_matrices.transformMatrix);
	translate(*camera.camera_matrices.transformMatrix, .{x = 0.0, y = 0.0, z = 5.0});
}
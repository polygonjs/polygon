PerspectiveCamera :: struct {
	#as using camera: Camera;
	camera.init = init_perspective_camera;

	fov_in_degrees: float32 = 50.0;
}

camera_projection_update :: (camera:*PerspectiveCamera) {
	camera.camera_matrices.projectionMatrix = make_projection_matrix(
		deg_to_rad(camera.fov_in_degrees),
		camera.aspect,
		camera.near,
		camera.far
	);
	// print("perspective projectionMatrix: %\n", camera.camera_matrices.projectionMatrix);
}


#scope_file

init_perspective_camera :: (object: *Object3D) {
	camera := cast(*PerspectiveCamera)object;
	init_camera(camera);
	tmp:PerspectiveCamera;
	camera.fov_in_degrees = tmp.fov_in_degrees;

	camera_projection_update(camera);
	camera_uniforms_update(camera, 0.0);
}


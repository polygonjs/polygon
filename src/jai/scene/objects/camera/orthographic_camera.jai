OrthographicCamera :: struct {
	#as using camera: Camera;
	camera.init = init_orthographic_camera;

	size: float32 = 10;
}


camera_projection_update :: (camera:*OrthographicCamera) {
	camera.camera_matrices.projectionMatrix = orthographic_projection_matrix(
		left   = -camera.size * camera.aspect,
		right  = +camera.size * camera.aspect,
		bottom = -camera.size,
		top    = +camera.size,
		near   = camera.near,
		far    = camera.far,
		true
	);
}

#scope_file


init_orthographic_camera :: (object: *Object3D) {
	camera := cast(*OrthographicCamera)object;
	init_camera(camera);

	tmp:OrthographicCamera;
	camera.size = tmp.size;

	camera_projection_update(camera);
	camera_uniforms_update(camera, 0.0);
}
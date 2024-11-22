OrthographicCamera :: struct {
	#as using camera: Camera;

	size: float32 = DEFAULT_SIZE;
}

object3DInit :: (camera: *OrthographicCamera) {
	object3DInit(cast(*Camera)camera);

	camera.size = DEFAULT_SIZE;

	assert(camera.aspect != 0.0, "camera.aspect is 0.0");
	cameraProjectionUpdate(camera);
	cameraUniformsUpdate(camera);
}

cameraProjectionUpdate :: (camera:*OrthographicCamera) {
	assert(camera.aspect != 0.0, "camera.aspect is 0.0");
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

DEFAULT_SIZE :: 10.0;
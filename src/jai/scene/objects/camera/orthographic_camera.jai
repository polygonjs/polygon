OrthographicCamera :: struct {
	#as using camera: Camera;

	size: float32 = DEFAULT_SIZE;
}

object3DInit :: (camera: *OrthographicCamera) {
	object3DInit(cast(*Camera)camera);

	camera.size = DEFAULT_SIZE;

	cameraProjectionUpdate(camera);
	cameraUniformsUpdate(camera);
}

cameraProjectionUpdate :: (camera:*OrthographicCamera) {
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
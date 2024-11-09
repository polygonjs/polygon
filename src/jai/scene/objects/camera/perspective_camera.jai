
PerspectiveCamera :: struct {
	#as using camera: Camera;

	fov_in_degrees: float32 = DEFAULT_FOV_IN_DEGREES;
}

object3DInit :: (camera: *PerspectiveCamera) {
	object3DInit(cast(*Camera)camera);
	camera.fov_in_degrees = DEFAULT_FOV_IN_DEGREES;

	cameraProjectionUpdate(camera);
	cameraUniformsUpdate(camera);
}

cameraProjectionUpdate :: (camera:*PerspectiveCamera) {
	camera.camera_matrices.projectionMatrix = make_projection_matrix(
		deg_to_rad(camera.fov_in_degrees),
		camera.aspect,
		camera.near,
		camera.far
	);
}


#scope_file

DEFAULT_FOV_IN_DEGREES :: 50.0;




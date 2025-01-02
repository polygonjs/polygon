
PerspectiveCamera :: struct {
	#as using camera: Camera;

	fov_in_degrees: float32 = DEFAULT_FOV_IN_DEGREES;
}

object3DInit :: (camera: *TYPE) {
	worldObjectInit(camera);
	object3DInit(cast(*CameraAny)camera);
	camera.fov_in_degrees = DEFAULT_FOV_IN_DEGREES;

	cameraProjectionUpdate(camera);
	cameraUniformsUpdate(xx camera);
}

cameraProjectionUpdate :: (camera:*TYPE) {
	assert(camera.aspect != 0.0, "camera.aspect is 0.0");
	camera.projectionMatrix = make_projection_matrix(
		deg_to_rad(camera.fov_in_degrees),
		camera.aspect,
		camera.near,
		camera.far
	);
	cameraProjectionMatrixInverseUpdate(xx camera);
}

cameraSetRaycaster :: (camera: *TYPE, raycaster: *Raycaster, coords: Vector2) {
	assert(false, "PerspectiveCamera.cameraSetRaycaster not implemented");
}

#scope_file

TYPE :: PerspectiveCamera;
DEFAULT_FOV_IN_DEGREES :: 50.0;




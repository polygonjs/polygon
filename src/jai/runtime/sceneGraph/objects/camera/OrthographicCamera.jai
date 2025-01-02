OrthographicCamera :: struct {
	#as using camera: Camera;

	size: float32 = ORTHOGRAPHIC_CAMERA_DEFAULT_SIZE;
}

object3DInit :: (camera: *TYPE) {
	worldObjectInit(camera);
	object3DInit(cast(*CameraAny)camera);

	camera.size = ORTHOGRAPHIC_CAMERA_DEFAULT_SIZE;

	assert(camera.aspect != 0.0, "camera.aspect is 0.0");
	cameraProjectionUpdate(camera);
	cameraUniformsUpdate(xx camera);
}

cameraProjectionUpdate :: (camera:*TYPE) {
	assert(camera.aspect != 0.0, "camera.aspect is 0.0");
	camera.projectionMatrix = orthographic_projection_matrix(
		left   = -camera.size * camera.aspect,
		right  = +camera.size * camera.aspect,
		bottom = -camera.size,
		top    = +camera.size,
		near   = camera.near,
		far    = camera.far,
		true
	);
	cameraProjectionMatrixInverseUpdate(xx camera);
}

cameraSetRaycaster :: (camera: *TYPE, raycaster: *Raycaster, coords: Vector2) {
	originNDC :Vector3= .{
		coords.x,
		coords.y,
		( camera.near + camera.far ) / ( camera.near - camera.far )
	};

	raycaster.ray.origin = ndcToWorld( originNDC, xx camera );

	direction :Vector3=.{ 0, 0, - 1 };
	transformDirection( *direction, camera.matrix ); // .matrixWorld
	raycaster.ray.direction = direction;
}

object3DCopy :: (src: *TYPE, using target: *TYPE) {
	object3DCopy(cast(*CameraAny)src, cast(*CameraAny)target);

	size = src.size;
}

ORTHOGRAPHIC_CAMERA_DEFAULT_SIZE :: 1.0;

#scope_file

TYPE :: OrthographicCamera;

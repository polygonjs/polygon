OrthographicCamera :: struct {
	#as using camera: Camera;

	size: float32 = DEFAULT_SIZE;
}

object3DInit :: (camera: *TYPE) {
	worldObjectInit(camera);
	object3DInit(cast(*Camera)camera);

	camera.size = DEFAULT_SIZE;

	assert(camera.aspect != 0.0, "camera.aspect is 0.0");
	cameraProjectionUpdate(camera);
	cameraUniformsUpdate(camera);
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
	cameraProjectionMatrixInverseUpdate(camera);
}

cameraSetRaycaster :: (camera: *TYPE, raycaster: *Raycaster, coords: Vector2) {
	origin :Vector3= .{
		coords.x,
		coords.y,
		( camera.near + camera.far ) / ( camera.near - camera.far )
	};

	origin2 := unproject( origin, camera );
	raycaster.ray.origin = origin2;

	direction :Vector3=.{ 0, 0, - 1 };
	transformDirection( *direction, camera.matrix ); // .matrixWorld
	raycaster.ray.direction = direction;
}



#scope_file

TYPE :: OrthographicCamera;
DEFAULT_SIZE :: 10.0;
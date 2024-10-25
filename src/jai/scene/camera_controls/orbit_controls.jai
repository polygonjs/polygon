

OrbitControls :: struct {
	theta:float = -PI/4; // Angle around the Y-axis
	phi:float = -PI/4;  // Angle around the X-axis
	radius:float = 5.0; // Distance from the target
	target:Vector3 = .{x=0.0,y=0.0,z=0.0}; // Target point the camera looks at
	sensitivity:float = 0.0025;
	camera:*Camera=null;

	lastPointer: Vector2Int;
}




camera_controls_process_event :: (controls:*OrbitControls, events_data:*EventsData){
	using controls;

	if (events_data.mouseButton.left) {
		dx:int = cast(int)events_data.cursor.x - lastPointer.x;
		dy:int = cast(int)events_data.cursor.y - lastPointer.y;

		theta += dx * sensitivity;
		phi -= dy * sensitivity;

	}
	lastPointer.x = xx events_data.cursor.x;
	lastPointer.y = xx events_data.cursor.y;

	if(events_data.wheel != 0){
		radius -= events_data.wheel * 0.1;
		if (radius < 1.0) radius = 1.0; // Prevent radius from being too small
	}

	camera_controls_update_camera(controls);
}




#scope_file


PHI_MIN :: -PI/2;
PHI_MAX :: +PI/2;
AXIS_X	::Vector3.{x=1.0, y=0.0, z=0.0};
AXIS_Y	::Vector3.{x=0.0, y=1.0, z=0.0};
// UP		::Vector3.{x=0.0, y=1.0, z=0.0};

camera_controls_update_camera :: (controls:*OrbitControls){
	using controls;
	

	// Clamp phi to avoid flipping at the poles
	if (phi < PHI_MIN) phi = PHI_MIN;
	if (phi > PHI_MAX) phi = PHI_MAX;

	// quaternions
	quaternionX :Quaternion;
	quaternionY :Quaternion;
	set_from_axis_and_angle(*quaternionY, AXIS_Y, -theta);
	set_from_axis_and_angle(*quaternionX, AXIS_X, phi);
	
	// rotate + translate
	transformMatrix :Matrix4;
	identity(*transformMatrix);
	transformMatrix = rotate(transformMatrix, quaternionY);
	transformMatrix = rotate(transformMatrix, quaternionX);
	translate(*transformMatrix, .{x=0.0, y=0.0, z=radius});

	assert(camera != null, "camera is null\n");
	camera.camera_matrices.transformMatrix = transformMatrix;
}
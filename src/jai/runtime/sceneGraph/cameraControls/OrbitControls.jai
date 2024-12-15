

OrbitControls :: struct {
	theta:float = -PI/4; // Angle around the Y-axis
	phi:float = -PI/4;  // Angle around the X-axis
	radius:float = 5.0; // Distance from the target
	target:Vector3 = .{x=0.0,y=0.0,z=0.0}; // Target point the camera looks at
	sensitivity:float = 0.0025;
	camera:*Camera=null;

	actionStarted: bool = false;
	leftButtonPressed: bool = false;
	lastPointer: Vector2Int;
}




cameraControlsProcessEvent :: (controls:*TYPE, events_data:*EventsData, elementFocused:bool){
	using controls;

	if(actionStarted == false && elementFocused==true){
		if (events_data.mouseButtonJustPressed.left) {
			actionStarted = true;
			lastPointer.x = cast(s32)events_data.cursor.x;
		lastPointer.y = cast(s32)events_data.cursor.y;
		}
	}
	if(actionStarted==true){
		dx:int = cast(int)events_data.cursor.x - lastPointer.x;
		dy:int = cast(int)events_data.cursor.y - lastPointer.y;

		theta += dx * sensitivity;
		phi -= dy * sensitivity;

		if (events_data.mouseButton.left==false) {
			actionStarted = false;
		}
		lastPointer.x = cast(s32)events_data.cursor.x;
		lastPointer.y = cast(s32)events_data.cursor.y;
	}

	if(events_data.wheel != 0){
		radius -= events_data.wheel * 0.1;
		if (radius < 1.0) radius = 1.0; // Prevent radius from being too small
	}

	cameraControlsUpdateCamera(controls);
}

cameraControlsCommit :: (controls:*TYPE){
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
	camera.position = .{x=0.0, y=0.0, z=radius};
	camera.quaternion = quaternionY * quaternionX;
	transformableUpdateMatrix(camera);
	// transformMatrix :Matrix4;
	// identity(*transformMatrix);
	// transformMatrix = rotate(transformMatrix, quaternionY);
	// transformMatrix = rotate(transformMatrix, quaternionX);
	// translate(*transformMatrix, .{x=0.0, y=0.0, z=radius});

	// assert(camera != null, "camera is null\n");
	// camera.transformMatrix = transformMatrix;

	generatedCameraProjectionUpdate(camera);
}


#scope_file

TYPE :: OrbitControls;


PHI_MIN :: -PI/2;
PHI_MAX :: +PI/2;
AXIS_X	::Vector3.{x=1.0, y=0.0, z=0.0};
AXIS_Y	::Vector3.{x=0.0, y=1.0, z=0.0};
// UP		::Vector3.{x=0.0, y=1.0, z=0.0};

cameraControlsUpdateCamera :: (controls:*TYPE){
	if(controls.actionStarted == false)return;

	cameraControlsCommit(controls);
}
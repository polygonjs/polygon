

OrbitControls :: struct {
	#as using cameraControls: CameraControls;

	theta:float = -PI/4; // Angle around the Y-axis
	phi:float = -PI/4;  // Angle around the X-axis
	radius:float = 5.0; // Distance from the target
	target:Vector3 = .{x=0.0,y=0.0,z=0.0}; // Target point the camera looks at
	sensitivity:float = 0.0025;

	phiBound :[2]float = .[DEFAULT_PHI_MIN, DEFAULT_PHI_MAX];
	radiusBound :[2]float = .[DEFAULT_RADIUS_MIN, DEFAULT_RADIUS_MAX];

	panStarted: bool = false;
	zoomStarted: bool = false;
	leftButtonPressed: bool = false;
	lastPointer: Vector2Int;
}




cameraControlsProcessEvent :: (using controls:*TYPE, eventsData:*EventsData, elementFocused:bool){

	if(panStarted == false && elementFocused==true){
		if (eventsData.mouseButtonJustPressed.left) {
			panStarted = true;
			lastPointer.x = cast(s32)eventsData.cursor.x;
			lastPointer.y = cast(s32)eventsData.cursor.y;
		}
	}
	if(panStarted==true){
		dx:int = cast(int)eventsData.cursor.x - lastPointer.x;
		dy:int = cast(int)eventsData.cursor.y - lastPointer.y;

		theta += dx * sensitivity;
		phi = clamp(phi - dy * sensitivity, phiBound[0], phiBound[1]);

		if (eventsData.mouseButton.left==false) {
			panStarted = false;
		}
		lastPointer.x = cast(s32)eventsData.cursor.x;
		lastPointer.y = cast(s32)eventsData.cursor.y;
	}

	if(elementFocused && eventsData.wheel != 0){
		previousRadius := radius;
		radius = clamp(radius - eventsData.wheel * 0.1, radiusBound[0], radiusBound[1]);
		if previousRadius != radius {
			zoomStarted = true;
		}
	}

	cameraControlsUpdateCamera(controls);
}

cameraControlsCommit :: (using controls:*TYPE) {

	// quaternions
	quaternionX :Quaternion;
	quaternionY :Quaternion;
	set_from_axis_and_angle(*quaternionY, AXIS_Y, -theta);
	set_from_axis_and_angle(*quaternionX, AXIS_X, phi);
	
	// rotate + translate
	camera.position = .{x=0.0, y=0.0, z=radius};
	camera.quaternion = quaternionY * quaternionX;
	cameraControlsUpdateCameraMatrix(controls);
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


DEFAULT_PHI_MIN :: -PI/2;
DEFAULT_PHI_MAX :: +PI/2;
DEFAULT_RADIUS_MIN :: 1.0;
DEFAULT_RADIUS_MAX :: 50.0;
AXIS_X	::Vector3.{x=1.0, y=0.0, z=0.0};
AXIS_Y	::Vector3.{x=0.0, y=1.0, z=0.0};
// UP		::Vector3.{x=0.0, y=1.0, z=0.0};

cameraControlsUpdateCamera :: (using controls:*TYPE){
	if( (panStarted || zoomStarted) == false ){
		return;
	}

	cameraControlsCommit(controls);
}
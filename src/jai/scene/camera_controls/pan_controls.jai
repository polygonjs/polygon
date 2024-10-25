

PanControls :: struct {
	sensitivity:float = 0.025;
	camera:*Camera=null;

	middleButtonPressed: bool = false;
	startCameraPos: Vector2;
	startPointer: Vector2Int;
}




camera_controls_process_event :: (controls:*PanControls, events_data:*EventsData){
	using controls;

	if (events_data.mouseButton.middle) {
		if(middleButtonPressed == false){
			startCameraPos.x = controls.camera.position.x;
			startCameraPos.y = controls.camera.position.y;
			startPointer.x = cast(s32)events_data.cursor.x;
			startPointer.y = cast(s32)events_data.cursor.y;
		} else {
			delta.x = cast(s32)events_data.cursor.x - startPointer.x;
			delta.y = cast(s32)events_data.cursor.y - startPointer.y;
		}
		middleButtonPressed = true;
	}

	if(events_data.wheel != 0){
		// radius -= events_data.wheel * 0.1;
		// if (radius < 1.0) radius = 1.0; // Prevent radius from being too small
	}

	camera_controls_update_camera(controls);
}





#scope_file

delta:Vector2Int;
DEPTH:float:5;


camera_controls_update_camera :: (controls:*PanControls){
	using controls;

	// translate
	transformMatrix :Matrix4;
	identity(*transformMatrix);
	newCameraPos := Vector3.{
		x=startCameraPos.x + xx delta.x * sensitivity * -1,
		y=startCameraPos.y + xx delta.y * sensitivity,
		z=DEPTH
	};
	translate(*transformMatrix, newCameraPos);
	assert(camera != null, "camera is null\n");
	camera.camera_matrices.transformMatrix = transformMatrix;

	
}




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
		cursor :Vector2Int= .{ cast(s32)events_data.cursor.x, cast(s32)events_data.cursor.y};
		if(middleButtonPressed == false){
			startCameraPos.x = controls.camera.position.x;
			startCameraPos.y = controls.camera.position.y;
			startPointer.x = cursor.x;
			startPointer.y = cursor.y;
			delta = .{0,0};
		} else {
			delta.x = cursor.x - startPointer.x;
			delta.y = cursor.y - startPointer.y;
		}
		middleButtonPressed = true;
	} else {
		middleButtonPressed = false;
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
	camera.position = newCameraPos;
	translate(*transformMatrix, newCameraPos);
	camera.camera_matrices.transformMatrix = transformMatrix;

	
}


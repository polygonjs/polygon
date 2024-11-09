

PanControls :: struct {
	sensitivity:float = 0.025;
	camera:*Camera=null;

	actionStarted: bool = false;
	middleButtonPressed: bool = false;
	startCameraPos: Vector2;
	startPointer: Vector2Int;
}




camera_controls_process_event :: (controls:*TYPE, events_data:*EventsData, element_focused:bool){
	using controls;

	if(actionStarted == false && element_focused==true){
		if (events_data.mouseButtonPressed.middle) {
			cursor :Vector2Int= .{ cast(s32)events_data.cursor.x, cast(s32)events_data.cursor.y};
			actionStarted = true;
			startCameraPos.x = controls.camera.position.x;
			startCameraPos.y = controls.camera.position.y;
			startPointer.x = cursor.x;
			startPointer.y = cursor.y;
			delta = .{0,0};
		}
	}
	if(actionStarted==true){
		cursor :Vector2Int= .{ cast(s32)events_data.cursor.x, cast(s32)events_data.cursor.y};
		delta.x = cursor.x - startPointer.x;
		delta.y = cursor.y - startPointer.y;
		if (events_data.mouseButton.middle==false) {
			actionStarted = false;
		}
	}

	if(events_data.wheel != 0){
		// radius -= events_data.wheel * 0.1;
		// if (radius < 1.0) radius = 1.0; // Prevent radius from being too small
	}

	cameraControlsUpdateCamera(controls);
}

cameraControlsCommit :: (controls:*TYPE){
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

	generatedCameraProjectionUpdate(camera);
}


#scope_file

TYPE :: PanControls;

delta:Vector2Int;
DEPTH:float:5;


cameraControlsUpdateCamera :: (controls:*TYPE){
	using controls;

	if(actionStarted == false)return;

	cameraControlsCommit(controls);
}




PanControls :: struct {
	#as using cameraControls: CameraControls;

	sensitivity:float = 0.025;

	actionStarted: bool = false;
	middleButtonPressed: bool = false;
	startCameraPos: Vector2;
	startPointer: Vector2Int;
}




cameraControlsProcessEvent :: (using controls:*TYPE, eventsData:*EventsData, elementFocused:bool){

	if(actionStarted == false && elementFocused==true){
		if (eventsData.mouseButtonJustPressed.middle) {
			cursor :Vector2Int= .{ cast(s32)eventsData.cursor.x, cast(s32)eventsData.cursor.y};
			actionStarted = true;
			startCameraPos.x = controls.camera.position.x;
			startCameraPos.y = controls.camera.position.y;
			startPointer.x = cursor.x;
			startPointer.y = cursor.y;
			delta = .{0,0};
		}
	}
	if(actionStarted==true){
		cursor :Vector2Int= .{ cast(s32)eventsData.cursor.x, cast(s32)eventsData.cursor.y};
		delta.x = cursor.x - startPointer.x;
		delta.y = cursor.y - startPointer.y;
		if (eventsData.mouseButton.middle==false) {
			actionStarted = false;
		}
	}

	if(eventsData.wheel != 0){
		// radius -= events_data.wheel * 0.1;
		// if (radius < 1.0) radius = 1.0; // Prevent radius from being too small
	}

	cameraControlsUpdateCamera(controls);
}

cameraControlsCommit :: (using controls:*TYPE){
	
	// translate
	transformMatrix :Matrix4;
	identity(*transformMatrix);
	newCameraPos := Vector3.{
		x=startCameraPos.x + xx delta.x * sensitivity * -1,
		y=startCameraPos.y + xx delta.y * sensitivity,
		z=DEPTH
	};
	camera.position = newCameraPos;
	cameraControlsUpdateCameraMatrix(controls);
	// translate(*transformMatrix, newCameraPos);
	// camera.matrix = transformMatrix;

	generatedCameraProjectionUpdate(camera);
}


#scope_file

TYPE :: PanControls;

delta:Vector2Int;
DEPTH:float:5;


cameraControlsUpdateCamera :: (using controls:*TYPE){

	if(actionStarted == false){return;}

	cameraControlsCommit(controls);
}


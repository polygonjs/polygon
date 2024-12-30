

PanControls :: struct {
	#as using cameraControls: CameraControls;

	position:Vector3 = .{x=0.0,y=0.0,z=0.0};
	zoom:float = ORTHOGRAPHIC_CAMERA_DEFAULT_SIZE;
	sensitivity:float = 0.025;

	zoomBound :[2]float = .[DEFAULT_ZOOM_MIN, DEFAULT_ZOOM_MAX];

	panStarted: bool = false;
	zoomStarted: bool = false;
	middleButtonPressed: bool = false;
	startCameraPos: Vector2;
	startPointer: Vector2Int;
}




cameraControlsProcessEvent :: (using controls:*TYPE, eventsData:*EventsData, elementFocused:bool){

	if(panStarted == false && elementFocused==true){
		if (eventsData.mouseButtonJustPressed.middle) {
			cursor :Vector2Int= .{ cast(s32)eventsData.cursor.x, cast(s32)eventsData.cursor.y};
			panStarted = true;
			startCameraPos.x = controls.camera.position.x;
			startCameraPos.y = controls.camera.position.y;
			startPointer.x = cursor.x;
			startPointer.y = cursor.y;
			delta = .{0,0};
		}
	}
	if(panStarted==true){
		cursor :Vector2Int= .{ cast(s32)eventsData.cursor.x, cast(s32)eventsData.cursor.y};
		delta.x = cursor.x - startPointer.x;
		delta.y = cursor.y - startPointer.y;
		position.x=startCameraPos.x + xx delta.x * sensitivity * -1;
		position.y=startCameraPos.y + xx delta.y * sensitivity;
		if (eventsData.mouseButton.middle==false) {
			panStarted = false;
		}
	}

	if(elementFocused && eventsData.wheel != 0){
		previousZoom := zoom;
		zoom = clamp(zoom - eventsData.wheel * 0.1, zoomBound[0], zoomBound[1]);
		if previousZoom != zoom {
			zoomStarted = true;
		}
	}

	cameraControlsUpdateCamera(controls);
}

cameraControlsCommit :: (using controls:*TYPE){
	
	// translate
	transformMatrix :Matrix4;
	identity(*transformMatrix);
	newCameraPos := Vector3.{
		x=position.x,
		y=position.y,
		z=DEPTH
	};
	camera.position = newCameraPos;
	if camera.type == OrthographicCamera {
		(cast(*OrthographicCamera)camera).size = zoom;
	}
	cameraControlsUpdateCameraMatrix(controls);
	// translate(*transformMatrix, newCameraPos);
	// camera.matrix = transformMatrix;

	generatedCameraProjectionUpdate(camera);
}


#scope_file

TYPE :: PanControls;

delta:Vector2Int;
DEPTH:float:5;
DEFAULT_ZOOM_MIN :: 1;
DEFAULT_ZOOM_MAX :: 100.0;

cameraControlsUpdateCamera :: (using controls:*TYPE){

	if( (panStarted || zoomStarted) == false ){
		return;
	}

	cameraControlsCommit(controls);
}


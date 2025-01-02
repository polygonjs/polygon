

PanControls :: struct {
	#as using cameraControls: CameraControls;

	position:Vector3 = .{x=0.0,y=0.0,z=0.0};
	zoom:float = 10;
	zoomSensitivity:float = 2.;

	zoomBound :[2]float = .[DEFAULT_ZOOM_MIN, DEFAULT_ZOOM_MAX];

	panStarted: bool = false;
	zoomStarted: bool = false;
	middleButtonPressed: bool = false;
	startCameraPos: Vector2;
	startPanPos: Vector2;
}




cameraControlsProcessEvent :: (using controls:*TYPE, eventsData:*EventsData, cursorForRaycast:Vector2, elementFocused:bool){

	if(panStarted == false && elementFocused==true){
		if (eventsData.mouseButtonJustPressed.middle) {
			panStarted = true;
			startCameraPos.x = camera.position.x;
			startCameraPos.y = camera.position.y;
			if camera.type == OrthographicCamera {
				orthographicCamera := cast(*OrthographicCamera)camera;
				object3DCopy(orthographicCamera, *dummyOrthographicCamera);
			} else {
				assert(false, "panControls currently only supports orthographic cameras");
			}
			cursorForRaycast3D :Vector3= .{cursorForRaycast.x, cursorForRaycast.y, 0.5};
			startPanPos3D := ndcToWorld(cursorForRaycast3D, camera);
			startPanPos.x = startPanPos3D.x;
			startPanPos.y = startPanPos3D.y;
			delta = .{0,0};
		}
	}
	if(panStarted==true){
		cursorForRaycast3D :Vector3= .{cursorForRaycast.x, cursorForRaycast.y, 0.5};
		startPanPos3D := ndcToWorld(cursorForRaycast3D, *dummyOrthographicCamera);
		delta.x = startPanPos3D.x - startPanPos.x;
		delta.y = startPanPos3D.y - startPanPos.y;
		position.x = startCameraPos.x - delta.x;
		position.y = startCameraPos.y - delta.y;
		if (eventsData.mouseButton.middle==false) {
			panStarted = false;
		}
	}

	if(elementFocused && eventsData.wheel != 0){
		previousZoom := zoom;
		zoom = clamp(zoom - eventsData.wheel * zoomSensitivity, zoomBound[0], zoomBound[1]);
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

delta:Vector2;
dummyOrthographicCamera:OrthographicCamera;
DEPTH:float:5;
DEFAULT_ZOOM_MIN :: 1;
DEFAULT_ZOOM_MAX :: 100.0;

cameraControlsUpdateCamera :: (using controls:*TYPE){

	if( (panStarted || zoomStarted) == false ){
		return;
	}

	cameraControlsCommit(controls);
}


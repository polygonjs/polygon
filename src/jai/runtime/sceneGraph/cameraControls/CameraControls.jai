CAMERA_CONTROL_MAX_SCENES_COUNT :: 2; // set to 2 because NetWorkPanel has 2 scenes, but could be more if needed

CameraControls :: struct {
	scenes:[CAMERA_CONTROL_MAX_SCENES_COUNT]*Scene;
	camera:*CameraAny=null;
}

cameraControlsSetScenes :: (using controls:*CameraControls, newScenes:[]*Scene){
	for 0..(CAMERA_CONTROL_MAX_SCENES_COUNT-1){
		scenes[it] = null;
	}
	for 0..(min(CAMERA_CONTROL_MAX_SCENES_COUNT, newScenes.count)-1){
		scenes[it] = newScenes[it];
	}
}
cameraControlsUpdateCameraMatrix :: (using controls:*CameraControls){
	if camera == null { return; }
	for scene: scenes {
		if scene != null {
			sceneCameraUpdateMatrix(scene, camera);
		}
	}
}
PerspectiveCamera :: struct {
	#as using camera: Camera;
	camera.init = init_perspective_camera;
}

init_perspective_camera :: (object: *Object3D) {
	camera := cast(*PerspectiveCamera)object;
}
OrthographicCamera :: struct {
	#as using camera: Camera;
	camera.init = init_orthographic_camera;
}

init_orthographic_camera :: (object: *Object3D) {
	camera := cast(*OrthographicCamera)object;
}
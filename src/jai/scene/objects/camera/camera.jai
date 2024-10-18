Camera :: struct {
	#as using object3D: Object3D;
	object3D.init = init_camera;
}

init_camera :: (object: *Object3D) {
	camera := cast(*Camera)object;
	init_transformable(camera);
}
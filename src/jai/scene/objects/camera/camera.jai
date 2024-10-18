CameraMatrices :: struct {
	transformMatrix: Matrix4;
	transformMatrixInverse: Matrix4;
	projectionMatrix: Matrix4;
};
CameraUniforms :: struct {
	time:Vector4;
	worldPos: Vector4; // if I give a Vector3, there seems some padding or alignment issue, as this crashes
	transformMatrixInverse: Matrix4x4Buffer;
	projectionMatrix: Matrix4x4Buffer;
};

Camera :: struct {
	#as using object3D: Object3D;
	object3D.init = init_camera;

	near: float32 = 0.1;
	far: float32 = 100.0;
	camera_matrices: CameraMatrices;
	camera_uniforms: CameraUniforms;
}

init_camera :: (object: *Object3D) {
	camera := cast(*Camera)object;
	init_transformable(camera);
}
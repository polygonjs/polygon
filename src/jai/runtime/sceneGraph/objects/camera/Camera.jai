// CameraMatrices :: struct {
// 	// transformMatrix: Matrix4;
// 	// transformMatrixInverse: Matrix4;
// 	projectionMatrix: Matrix4;
// 	projectionMatrixInverse: Matrix4;
// };
CameraUniforms :: struct {
	worldPos: Vector4; // if I give a Vector3, there seems some padding or alignment issue, as this crashes
	transformMatrixInverse: Matrix4x4Buffer;
	projectionMatrix: Matrix4x4Buffer;
	projectionMatrixInverse: Matrix4x4Buffer;
};

Camera :: struct  {
	#as using object3D: Object3D;

	near: float32 = 0.1;
	far: float32 = 100.0;
	aspect: float32 = 1.0;
	projectionMatrix: Matrix4;
	projectionMatrixInverse: Matrix4;
	// cameraMatrices: CameraMatrices;
	cameraUniforms: CameraUniforms;
}
CameraAny :: Camera;

object3DInit :: (camera: *CameraAny) {
	camera.transformOrder = .RTS;

	identity(*camera.matrix);
	translate(*camera.matrix, .{x = 0.0, y = 0.0, z = 5.0});
}

cameraProjectionMatrixInverseUpdate :: (camera: *CameraAny) {
	camera.projectionMatrixInverse = inverse(camera.projectionMatrix);
}

cameraUniformsUpdate :: (camera: *CameraAny) {
	camera.cameraUniforms.worldPos.x = camera.matrix._14;
	camera.cameraUniforms.worldPos.y = camera.matrix._24;
	camera.cameraUniforms.worldPos.z = camera.matrix._34;

	transformMatrixInverse := inverse(transpose(camera.matrix));
	projectionMatrix := transpose(camera.projectionMatrix);
	matrix4x4_to_buffer(*transformMatrixInverse, *camera.cameraUniforms.transformMatrixInverse);
	matrix4x4_to_buffer(*projectionMatrix, *camera.cameraUniforms.projectionMatrix);
	matrix4x4_to_buffer(*inverse(projectionMatrix), *camera.cameraUniforms.projectionMatrixInverse);
}

object3DCopy :: (src: *CameraAny, using target: *CameraAny) {
	object3DCopy(cast(*Object3D)src, cast(*Object3D)target);

	near = src.near;
	far = src.far;
	aspect = src.aspect;
	projectionMatrix = src.projectionMatrix;
	projectionMatrixInverse = src.projectionMatrixInverse;

	cameraUniforms = src.cameraUniforms;
}

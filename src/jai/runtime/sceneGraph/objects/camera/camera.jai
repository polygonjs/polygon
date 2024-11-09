CameraMatrices :: struct {
	transformMatrix: Matrix4;
	transformMatrixInverse: Matrix4;
	projectionMatrix: Matrix4;
};
CameraUniforms :: struct {
	worldPos: Vector4; // if I give a Vector3, there seems some padding or alignment issue, as this crashes
	transformMatrixInverse: Matrix4x4Buffer;
	projectionMatrix: Matrix4x4Buffer;
};

Camera :: struct {
	#as using object3D: Object3D;

	near: float32 = 0.1;
	far: float32 = 100.0;
	aspect: float32;
	camera_matrices: CameraMatrices;
	camera_uniforms: CameraUniforms;
}

object3DInit :: (camera: *Camera) {
	object3DInit(cast(*Object3D)camera);

	tmp:Camera;
	camera.near = tmp.near;
	camera.far = tmp.far;
	camera.aspect = tmp.aspect;

	identity(*camera.camera_matrices.transformMatrix);
	translate(*camera.camera_matrices.transformMatrix, .{x = 0.0, y = 0.0, z = 5.0});
}

cameraUniformsUpdate :: (camera: *Camera) {
	camera.camera_uniforms.worldPos.x = camera.camera_matrices.transformMatrix._14;
	camera.camera_uniforms.worldPos.y = camera.camera_matrices.transformMatrix._24;
	camera.camera_uniforms.worldPos.z = camera.camera_matrices.transformMatrix._34;

	transformMatrixInverse := inverse(transpose(camera.camera_matrices.transformMatrix));
	projectionMatrix := transpose(camera.camera_matrices.projectionMatrix);
	matrix4x4_to_buffer(*transformMatrixInverse, *camera.camera_uniforms.transformMatrixInverse);
	matrix4x4_to_buffer(*projectionMatrix, *camera.camera_uniforms.projectionMatrix);
}

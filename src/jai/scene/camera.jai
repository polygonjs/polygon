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

CameraData :: struct {
	aspect: float32;
	fov_in_degrees: float32 = 50.0;
	near: float32 = 0.1;
	far: float32 = 100.0;
	matrices: CameraMatrices;
	uniforms: CameraUniforms;
}

camera_data_create :: ()-> CameraData {
	camera_data: CameraData;
	camera_data.aspect = 1;
	// camera_data.fov_in_degrees = 70;
	// camera_data.near = scene_data.camera_near;
	// camera_data.far = scene_data.camera_far;

	camera_matrices_init(*camera_data);
	camera_data_uniforms_update(*camera_data, 0.0);

	return camera_data;
}



camera_data_projection_update :: (camera_data:*CameraData) {
	// print("scene_data.camera_aspect:%, %\n", scene_data.camera_aspect, camera_data[0].projectionMatrix);
	camera_data.matrices.projectionMatrix = make_projection_matrix(
		deg_to_rad(camera_data.fov_in_degrees),
		camera_data.aspect,
		camera_data.near,
		camera_data.far
	);
}

camera_data_uniforms_update :: (camera_data: *CameraData, time: Time) {
	camera_data.uniforms.time.x = time;
	camera_data.uniforms.worldPos.x = camera_data.matrices.transformMatrix._14;
	camera_data.uniforms.worldPos.y = camera_data.matrices.transformMatrix._24;
	camera_data.uniforms.worldPos.z = camera_data.matrices.transformMatrix._34;

	transformMatrixInverse := inverse(transpose(camera_data.matrices.transformMatrix));
	projectionMatrix := transpose(camera_data.matrices.projectionMatrix);
	matrix4x4_to_buffer(*transformMatrixInverse, *camera_data.uniforms.transformMatrixInverse);
	matrix4x4_to_buffer(*projectionMatrix, *camera_data.uniforms.projectionMatrix);
}

#scope_file

camera_matrices_init :: (camera_data:*CameraData) {
	// camera_data[0].projectionMatrix = make_projection_matrix(deg_to_rad(fov), aspect, 0.1, 100);
	camera_data_projection_update(camera_data);
	identity(*camera_data.matrices.transformMatrix);
	translate(*camera_data.matrices.transformMatrix, .{x = 0.0, y = 0.0, z = 5.0});
}

// update_camera_data_projection :: (camera_data: *CameraData){
// 	update_camera_data_projection(*(camera_data.camera_matrices[0]), scene_data);
// }
// camera_data_uniforms_init :: (camera_data: *CameraData) {
// 	// uniforms[0].projection = make_frustum_matrix(-1,1,aspect,-aspect,1,100);
// 	// projectionMatrix := make_projection_matrix(deg_to_rad(50), aspect, 0.1, 100);
// 	// transposedProjectionMatrix := transpose(projectionMatrix);

// 	// transformMatrix := Matrix4.{};
// 	// identity(*transformMatrix);
// 	// translate(*transformMatrix, .{x = 1.0, y = 1.0, z = 3.0});
// 	// transformMatrixInverse := inverse(transpose(transformMatrix));

// 	camera_uniforms : [1]CameraUniforms;
// 	// matrix4x4_to_buffer(*transformMatrixInverse, *uniforms[0].transformMatrixInverse);
// 	// matrix4x4_to_buffer(*transposedMatrix, *uniforms[0].projectionMatrix);
// 	update_camera_uniforms(camera_data, *camera_uniforms, 0.);

// 	return camera_uniforms;
// }


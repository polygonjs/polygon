
Vertex :: struct {
	position: Vector3;
	color: Vector3;
	uv: Vector2;
}
VERTEX_FLOATS_COUNT :: 3 + 3 + 2;
VertexIndex :: u32;
VertexLayoutBuffer :: u8;
Matrix4x4Buffer :: [16]float;

ObjectData :: struct {
	transformMatrix: Matrix4;
};
ObjectUniforms :: struct {
	transformMatrix: Matrix4x4Buffer;
};
CameraData :: struct {
	transformMatrix: Matrix4;
	transformMatrixInverse: Matrix4;
	projectionMatrix: Matrix4;
};
CameraUniforms :: struct {
	transformMatrixInverse: Matrix4x4Buffer;
	projectionMatrix: Matrix4x4Buffer;
};

SceneData :: struct {
	// object
	vertices: [..]Vertex;
	indices: [..]VertexIndex;
	object_data: [1]ObjectData;
	object_uniforms: [1]ObjectUniforms;
	// camera
	camera_data: [1]CameraData;
	camera_uniforms: [1]CameraUniforms;
};

matrix4x4_to_buffer :: (matrix: *Matrix4, buffer: *Matrix4x4Buffer) #expand {
	memcpy(buffer.data, matrix, 16 * size_of(float));
}


create_vertices :: ()-> [..]Vertex, [..]VertexIndex {
	vertices : [..]Vertex;
	array_add(*vertices, Vertex.{ position=.{-0.5, 0.5, 0.0}, color=.{1.0, 0.0, 0.0}, uv=.{0.0, 1.0}});
	array_add(*vertices, Vertex.{ position=.{-0.5, -0.5, 0.0}, color=.{0.0, 1.0, 0.0}, uv=.{0.0, 0.0}});
	array_add(*vertices, Vertex.{ position=.{0.5, -0.5, 0.0}, color=.{0.0, 0.0, 1.0}, uv=.{1.0, 0.0}});
	array_add(*vertices, Vertex.{ position=.{0.5, 0.5, 0.0}, color=.{1.0, 0.0, 1.0}, uv=.{1.0, 1.0}});

	indices:[..]VertexIndex;
	array_add(*indices, 0);
	array_add(*indices, 1);
	array_add(*indices, 2);
	array_add(*indices, 0);
	array_add(*indices, 2);
	array_add(*indices, 3);

	return vertices, indices;
}
create_object_data :: ()-> [1]ObjectData {
	object_data :[1]ObjectData;
	identity(*object_data[0].transformMatrix);
	translate(*object_data[0].transformMatrix, .{x = 0.0, y = 0.0, z = 0.0});
	return object_data;
}
create_object_uniforms :: (object_data: *[1]ObjectData)-> [1]ObjectUniforms {
	object_uniforms :[1]ObjectUniforms;
	update_object_uniforms(object_data, *object_uniforms);
	return object_uniforms;
}
create_camera_data :: (aspect: float32)-> [1]CameraData {
	camera_data :[1]CameraData;
	camera_data[0].projectionMatrix = make_projection_matrix(deg_to_rad(50), aspect, 0.1, 100);
	identity(*camera_data[0].transformMatrix);
	translate(*camera_data[0].transformMatrix, .{x = 0.0, y = 0.0, z = 4.0});
	return camera_data;
}
create_camera_uniforms :: (camera_data: *[1]CameraData)-> [1]CameraUniforms {
	// uniforms[0].projection = make_frustum_matrix(-1,1,aspect,-aspect,1,100);
	// projectionMatrix := make_projection_matrix(deg_to_rad(50), aspect, 0.1, 100);
	// transposedProjectionMatrix := transpose(projectionMatrix);

	// transformMatrix := Matrix4.{};
	// identity(*transformMatrix);
	// translate(*transformMatrix, .{x = 1.0, y = 1.0, z = 3.0});
	// transformMatrixInverse := inverse(transpose(transformMatrix));

	camera_uniforms : [1]CameraUniforms;
	// matrix4x4_to_buffer(*transformMatrixInverse, *uniforms[0].transformMatrixInverse);
	// matrix4x4_to_buffer(*transposedMatrix, *uniforms[0].projectionMatrix);
	update_camera_uniforms(camera_data, *camera_uniforms);

	return camera_uniforms;
}
create_scene_data :: (aspect:float32)-> SceneData {
	scene_data : SceneData;
	scene_data.vertices, scene_data.indices = create_vertices();
	scene_data.object_data = create_object_data();
	scene_data.object_uniforms = create_object_uniforms(*scene_data.object_data);
	scene_data.camera_data = create_camera_data(aspect);
	scene_data.camera_uniforms = create_camera_uniforms(*scene_data.camera_data);
	return scene_data;
}
update_scene_data_uniforms :: (scene_data: *SceneData) {
	update_object_uniforms(*scene_data.object_data, *scene_data.object_uniforms);
	update_camera_uniforms(*scene_data.camera_data, *scene_data.camera_uniforms);
}
update_object_uniforms :: (object_data: *[1]ObjectData, object_uniforms: *[1]ObjectUniforms) {
	transposedMatrix := transpose((<<object_data)[0].transformMatrix);
	matrix4x4_to_buffer(*transposedMatrix, *((<<object_uniforms)[0].transformMatrix));
}
update_camera_uniforms :: (camera_data: *[1]CameraData, camera_uniforms: *[1]CameraUniforms) {
	transformMatrixInverse := inverse(transpose((<<camera_data)[0].transformMatrix));
	projectionMatrix := transpose((<<camera_data)[0].projectionMatrix);
	matrix4x4_to_buffer(*transformMatrixInverse, *((<<camera_uniforms)[0].transformMatrixInverse));
	matrix4x4_to_buffer(*projectionMatrix, *((<<camera_uniforms)[0].projectionMatrix));
}
// create_camera_data :: (aspect: float32)-> CameraData {
// 	camera_data : CameraData;
// 	camera_data.transform = .{};
// 	camera_data.projection = make_frustum_matrix(-1,1,aspect,-aspect,1,100);

// 	identity(*camera_data.transform);
// 	translate(*camera_data.transform, .{x = 0.0, y = 0.0, z = 2.0});

// 	camera_data.transformInverse = inverse(camera_data.transform);

// 	return camera_data;
// }

update_scene_data :: (scene_data: *SceneData, time:float) {
	// scene_data.vertices[0].position.y = 0.5 + 0.2*sin(time);
	// scene_data.object_uniforms[0].translate.x = sin(time);

	// translate(*scene_data.object_uniforms[0].matrix, .{x = 0.01*sin(time), y = 0.0, z = 0.0} );
	// translate(*scene_data.object_data[0].transformMatrix, .{x=0.0, y=0.01*sin(time), z=0.0});
	// translate(*scene_data.camera_data[0].transformMatrix, .{x=0.01*sin(3*time), y=0.0, z=0.0});

	// transformMatrix := (<<scene_data).object_data[0].transformMatrix;
	// identity(*transformMatrix);

	// rotation
	quaternion :Quaternion;
	axis:=Vector3.{x=0.0, y=1.0, z=0.0};
	set_from_axis_and_angle(*quaternion, axis, deg_to_rad(10*time));
	rotationMatrix:Matrix4;
	identity(*rotationMatrix);
	rotationMatrix = rotate(rotationMatrix, *quaternion);
	
	// translation
	translateMatrix :Matrix4;
	identity(*translateMatrix);
	translate(*translateMatrix, .{x=0.0, y=0.0, z=5.0});

	// combine
	transformMatrix := rotationMatrix * translateMatrix;
	scene_data.camera_data[0].transformMatrix = transformMatrix;
}


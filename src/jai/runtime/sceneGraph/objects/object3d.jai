TransformableUniforms :: struct {
	transformMatrix: Matrix4x4Buffer;
}

Object3D :: struct {
	allocator: Allocator;
	type: Type;
	id: u64;
	//
	position: Vector3;
	quaternion: Quaternion;
	scale: Vector3 = .{1.0, 1.0, 1.0};
	matrix: Matrix4;

	transformable_uniforms: TransformableUniforms;
}


newObject3D :: (scene: *Scene, $T: Type) -> *T {
	assert(T != Mesh, "Mesh is not allowed to be allocated with newObject3D, use newMesh instead\n");
	object := object3DAllocate(T, scene.allocator);

	object3DInit(object);

	return object;
}
object3DAllocate :: ($T: Type, allocator: Allocator)-> *T {
	object: *T = New(T,, allocator);
	object.allocator = allocator;
	object.type = T;

	object.id = NEXT_OBJECT3D_ID;
	NEXT_OBJECT3D_ID+=1;
	init_transformable(object);
	return object;
}
object3DInit :: (object: *TYPE) {
	assert(cast(*void)object.type != null, "object.type is null\n");
	init_transformable(object);
}
worldObjectDelete :: (object: *TYPE) {
	free(object,, object.allocator);
}

init_transformable :: (object: *Object3D) {
	// object.position = .{x = 0.0, y = 0.0, z = 0.0};
	object.quaternion = .{x = 0.0, y = 0.0, z = 0.0, w = 1.0};
	object.scale = .{x = 1.0, y = 1.0, z = 1.0};
	// object.matrix = .{};
	// identity(*object.matrix);
	// translate(*object.matrix, object.position);
	// object.matrix = rotate(object.matrix, object.quaternion);
	// scale(*object.matrix, object.scale);
	identity(*object.matrix);
	// translate(*object.matrix, .{x = 0.0, y = 0.0, z = 0.0});
	transformable_uniforms_update(object);
}



transformable_update_matrix :: (object: *Object3D) {
	identity(*object.matrix);
	translate(*object.matrix, object.position);
	object.matrix = rotate(object.matrix, object.quaternion);
	scale(*object.matrix, object.scale);
	transformable_uniforms_update(object);
}

transformable_uniforms_update :: (object: *Object3D) {
	transposedMatrix := transpose(object.matrix);
	matrix4x4_to_buffer(*transposedMatrix, *object.transformable_uniforms.transformMatrix);
}

#scope_file

NEXT_OBJECT3D_ID :u64= 0;
TYPE :: Object3D;
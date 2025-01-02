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
	transformOrder: TransformOrder = .TRS;
	matrix: Matrix4;
	matrixInverse: Matrix4;

	transformableUniforms: TransformableUniforms;
}
Object3DAny :: Object3D;

TransformOrder :: enum u8 {
	TRS :: 0;
	TSR;
	RST;
	RTS;
	SRT;
	STR;
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
	worldObjectInit(object);
	return object;
}
worldObjectInit :: (object: *$T) {
	object.type = T;
	object.id = nextWorldObjectId();
	transformableInit(object);
}
worldObjectClone :: (object: *TYPE)->*TYPE {
	clone := New(TYPE,, object.allocator);
	memcpy(clone, object, size_of(TYPE));
	return clone;
}
object3DInit :: (object: *TYPE) {
	assert(cast(*void)object.type != null, "object.type is null\n");
	transformableInit(object);
}
worldObjectDelete :: (object: *TYPE) {
	free(object,, object.allocator);
}

transformableInit :: (object: *TYPE) {
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
	transformableUniformsUpdate(object);
}



transformableUpdateMatrix :: (object: *TYPE) {
	identity(*object.matrix);

	// for a camera in an OrbitControls,
	// we want the translate to happen last.
	// this may be different in other situation,
	// and we may then set this per object
	// object.matrix = rotate(object.matrix, object.quaternion);
	// translate(*object.matrix, object.position);
	// scale(*object.matrix, object.scale);


	if #complete object.transformOrder == {
		case .TRS; {
			translate(*object.matrix, object.position);
			object.matrix = rotate(object.matrix, object.quaternion);
			scale(*object.matrix, object.scale);
		}
		case .TSR; {
			translate(*object.matrix, object.position);
			scale(*object.matrix, object.scale);
			object.matrix = rotate(object.matrix, object.quaternion);
		}
		case .RST; {
			object.matrix = rotate(object.matrix, object.quaternion);
			scale(*object.matrix, object.scale);
			translate(*object.matrix, object.position);
		}
		case .RTS; {
			object.matrix = rotate(object.matrix, object.quaternion);
			translate(*object.matrix, object.position);
			scale(*object.matrix, object.scale);
		}
		case .SRT; {
			scale(*object.matrix, object.scale);
			object.matrix = rotate(object.matrix, object.quaternion);
			translate(*object.matrix, object.position);
		}
		case .STR; {
			scale(*object.matrix, object.scale);
			translate(*object.matrix, object.position);
			object.matrix = rotate(object.matrix, object.quaternion);
		}
	}

	object.matrixInverse = inverse(object.matrix);

	transformableUniformsUpdate(object);

}

transformableUniformsUpdate :: (object: *TYPE) {
	transposedMatrix := transpose(object.matrix);
	matrix4x4_to_buffer(*transposedMatrix, *object.transformableUniforms.transformMatrix);
}

nextWorldObjectId :: ()->WorldObjectId{
	currentId := NEXT_OBJECT3D_ID;
	NEXT_OBJECT3D_ID += 1;
	return currentId;
}

object3DCopy :: (src: *TYPE, using target: *TYPE) {
	// allocator = src.allocator;
	position = src.position;
	quaternion = src.quaternion;
	scale = src.scale;
	transformOrder = src.transformOrder;
	matrix = src.matrix;
	matrixInverse = src.matrixInverse;

	transformableUniforms = src.transformableUniforms;
}

#scope_file

WorldObjectId :: u64;
NEXT_OBJECT3D_ID :WorldObjectId= 0;
TYPE :: Object3D;

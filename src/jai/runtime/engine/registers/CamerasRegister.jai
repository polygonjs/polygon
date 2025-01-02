

generatedCameraProjectionUpdate :: (object:*$T) {
	#insert GENERATED_CODE_CAMERA_PROJECTION_UPDATE;
	assert(false, tprint("generatedCameraProjectionUpdate: object type '%' is not implemented", object.type));
}
generatedCameraSetRaycaster :: (object:*$T, raycaster:*Raycaster, coords: Vector2) {
	#insert GENERATED_CODE_CAMERA_SET_RAYCASTER;
	assert(false, tprint("generatedCameraSetRaycaster: object type '%' is not implemented", object.type));
}

#scope_file

GENERATED_CODE_CAMERA_PROJECTION_UPDATE,
GENERATED_CODE_CAMERA_SET_RAYCASTER :: #run registerCameras();

CAMERA_TYPES :[..]Type;

cameraRegister :: ($T:Type) #compile_time {
	array_add(*CAMERA_TYPES, T);
}

registerCameras :: () -> (projectionUpdate: string, setRaycaster: string) #compile_time {

	cameraRegister(PerspectiveCamera);
	cameraRegister(OrthographicCamera);

	projectionUpdate := _projectionUpdate();
	setRaycaster := _setRaycaster();
	
	return projectionUpdate,
	setRaycaster;
}

_projectionUpdate :: ()->string #compile_time {
	builder: String_Builder;
	print_to_builder(*builder, "if object.type == {\n");
	for type: CAMERA_TYPES {
		print_to_builder(*builder, tprint("\tcase %; cameraProjectionUpdate( cast(*%) object);return;\n", type, type));
	}
	print_to_builder(*builder, "}");

	result := builder_to_string(*builder);
	return result;
}
_setRaycaster :: ()->string #compile_time {
	builder: String_Builder;
	print_to_builder(*builder, "if object.type == {\n");
	for type: CAMERA_TYPES {
		print_to_builder(*builder, tprint("\tcase %; cameraSetRaycaster( cast(*%) object, raycaster, coords);return;\n", type, type));
	}
	print_to_builder(*builder, "}");

	result := builder_to_string(*builder);
	return result;
}

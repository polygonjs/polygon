

generatedCameraProjectionUpdate :: (object:*$T) {
	#insert GENERATED_CODE_CAMERA_PROJECTION_UPDATE;
	assert(false, tprint("generatedCameraProjectionUpdate: object type '%' is not implemented", object.type));
}

#scope_file

GENERATED_CODE_CAMERA_PROJECTION_UPDATE :: #run registerCameras();

CAMERA_TYPES :[..]Type;

cameraRegister :: ($T:Type) {
	array_add(*CAMERA_TYPES, T);
}

registerCameras :: () -> projectionUpdate:string {

	cameraRegister(PerspectiveCamera);
	cameraRegister(OrthographicCamera);

	builder: String_Builder;
	print_to_builder(*builder, "if object.type == {\n");
	for type: CAMERA_TYPES {
		print_to_builder(*builder, tprint("\tcase %; cameraProjectionUpdate( cast(*%) object);return;\n", type, type));
	}
	print_to_builder(*builder, "}");

	result := builder_to_string(*builder);

	return result;
}


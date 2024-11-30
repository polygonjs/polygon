


generatedWorldObjectDelete :: (object: *$T) {
	#insert GENERATED_CODE_WORLD_OBJECT_DELETE;
	assert(false, tprint("generatedWorldObjectDelete: object type '%' is not implemented", object.type));
}
generatedWorldObjectClone :: (object: *$T)->*T {
	#insert GENERATED_CODE_WORLD_OBJECT_CLONE;
	assert(false, tprint("generatedWorldObjectClone: object type '%' is not implemented", object.type));
	return null;
}


registerWorldObjectsAndGenerateCode :: () -> (
	worldObjectsDelete:string,
	worldObjectsClone:string
) {

	worldObjectsDelete := generateWorldObjectDelete();
	worldObjectsClone := generateWorldObjectClone();

	return 	worldObjectsDelete,
			worldObjectsClone;
}


#scope_file

WORLD_OBJECT_TYPES: [..]Type = .[
	Object3D,
	Mesh,
	Scene,
];

GENERATED_CODE_WORLD_OBJECT_DELETE,
GENERATED_CODE_WORLD_OBJECT_CLONE :: #run registerWorldObjectsAndGenerateCode();

generateWorldObjectDelete :: ()->string {
	builder: String_Builder;
	print_to_builder(*builder, "if object.type == {\n");
	for type: WORLD_OBJECT_TYPES {
		print_to_builder(*builder, tprint("\tcase %; worldObjectDelete( cast(*%) object);return;\n", type, type));
	}
	print_to_builder(*builder, "}");

	result := builder_to_string(*builder);
	reset(*builder);
	return result;
}
generateWorldObjectClone :: ()->string {
	builder: String_Builder;
	print_to_builder(*builder, "if object.type == {\n");
	for type: WORLD_OBJECT_TYPES {
		print_to_builder(*builder, tprint("\tcase %; return worldObjectClone( cast(*%) object);\n", type, type));
	}
	print_to_builder(*builder, "}");

	result := builder_to_string(*builder);
	reset(*builder);
	return result;
}


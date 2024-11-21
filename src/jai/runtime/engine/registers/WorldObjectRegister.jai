


generatedWorldObjectDelete :: (object: *$T) {
	#insert GENERATED_CODE_WORLD_OBJECT_DELETE;
	assert(false, tprint("generatedWorldObjectDelete: object type '%' is not implemented", object.type));
}

registerWorldObjectsAndGenerateCode :: () -> (worldObjectsDelete:string) {

	worldObjectsDelete := generateWorldObjectDelete();

	return worldObjectsDelete;
}


#scope_file

WORLD_OBJECT_TYPES: [..]Type = .[
	Object3D,
	Mesh,
	Scene,
];

GENERATED_CODE_WORLD_OBJECT_DELETE :: #run registerWorldObjectsAndGenerateCode();

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


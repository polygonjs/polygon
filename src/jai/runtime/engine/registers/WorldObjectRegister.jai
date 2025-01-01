


generatedWorldObjectDelete :: (object: *Object3D) {
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
) #compile_time {

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

generateWorldObjectDelete :: ()->string #compile_time {
	builder: String_Builder;
	print_to_builder(*builder, "if object.type == {\n");
	for type: WORLD_OBJECT_TYPES {
		print_to_builder(*builder, tprint("\tcase %; worldObjectDelete( cast(*%) object);return;\n", type, type));
	}
	print_to_builder(*builder, "}");

	result := builder_to_string(*builder);
	// reset(*builder);
	return result;
}
generateWorldObjectClone :: ()->string #compile_time {
	builder: String_Builder;
	print_to_builder(*builder, "if object.type == {\n");
	for type: WORLD_OBJECT_TYPES {
		print_to_builder(*builder, tprint("\tcase %; clone := worldObjectClone( cast(*%) object); clone.id = nextWorldObjectId(); return clone;\n", type, type));
	}
	print_to_builder(*builder, "}");

	result := builder_to_string(*builder);
	// reset(*builder);
	return result;
}


// NodeCastFunction :: #type (node: *CoreGraphNode)->Type;

// TypePair :: struct {
// 	src: Type;
// 	dest: Type;
// };


// #run array_i(*NODE_CAST_TYPE_BY_TYPE, 64);


GENERATED_CODE_NODE_COMPUTE_DUMMY,
GENERATED_CODE_NODE_COMPUTE :: #run registerAll();

#scope_file


NOTE_TYPES :[..]Type;
// PARAM_TYPES :[..]Type;

nodeRegister :: ($nodeType:Type) {
	// print(">> nodeRegister: %\n", nodeType);
	array_add(*NOTE_TYPES, nodeType);
	// table_set(*NODE_CAST_TYPE_BY_TYPE, nodeType, T);
}
// paramRegister :: ($paramType:Type) {
// 	// print("> paramRegister: %\n", paramType);
// 	array_add(*PARAM_TYPES, paramType);
// 	// table_set(*NODE_CAST_TYPE_BY_TYPE, nodeType, T);
// }

generateNodeComputes :: ()->string {
	builder: String_Builder;
	// for nodeType: NOTE_TYPES {
	// 	print_to_builder(*builder, tprint("if (inputNode.runtimeType == %) {return nodeCompute(cast(*%) inputNode, depth);}\n", nodeType, nodeType));
	// }
	print_to_builder(*builder, "if inputNode.type == {\n");
	for nodeType: NOTE_TYPES {
		print_to_builder(*builder, tprint("\tcase %; return nodeCompute(cast(*%) inputNode, depth);\n", nodeType, nodeType));
	}
	print_to_builder(*builder, "}");

	result := builder_to_string(*builder);
	// print("generated node computes:\n%", result);
	return result;
}

registerAll :: ()->nodeCompute:string, nodeCompute2:string {
	// paramRegister(FloatParam);
	// paramRegister(UIntegerParam);
	// paramRegister(Vector3Param);
	// paramRegister(Vector3UIntParam);

	nodeRegister(BoxGeoNode);
	nodeRegister(IcosahedronGeoNode);
	nodeRegister(OutputGeoNode);

	nodeComputeDummy := generateNodeComputes();
	nodeCompute := generateNodeComputes();

	return nodeComputeDummy, nodeCompute;
}

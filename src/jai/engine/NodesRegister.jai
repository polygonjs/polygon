// NodeCastFunction :: #type (node: *CoreGraphNode)->Type;

// TypePair :: struct {
// 	src: Type;
// 	dest: Type;
// };


// #run array_i(*NODE_CAST_TYPE_BY_TYPE, 64);


GENERATED_CODE_NODE_COMPUTE,
GENERATED_CODE_SCENE_NODE_DELETE :: #run registerAll();

generatedNodeCompute :: (inputNode: *$T, depth:u8=0)->GeoNodeCookOutput {
	#insert GENERATED_CODE_NODE_COMPUTE;
	assert(false, tprint("generatedNodeCompute: node type % is not implemented", inputNode.type));
	return newObject3D(Mesh);
}

generatedSceneNodeDelete :: (scene: *NodesScene, node: *$T, $removeFromGraph:bool = true) {
	#insert GENERATED_CODE_SCENE_NODE_DELETE;
	assert(false, tprint("generatedSceneNodeDelete: node type % is not implemented", node.type));
	return;
}

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
	print_to_builder(*builder, "if inputNode.type == {\n");
	for nodeType: NOTE_TYPES {
		print_to_builder(*builder, tprint("\tcase %; return nodeCompute(cast(*%) inputNode, depth);\n", nodeType, nodeType));
	}
	print_to_builder(*builder, "}");

	result := builder_to_string(*builder);
	return result;
}
generateSceneNodeDelete :: ()->string {
	builder: String_Builder;
	print_to_builder(*builder, "if node.type == {\n");
	for nodeType: NOTE_TYPES {
		print_to_builder(*builder, tprint("\tcase %; sceneDeleteNode(scene, cast(*%) node, removeFromGraph);return;\n", nodeType, nodeType));
	}
	print_to_builder(*builder, "}");

	result := builder_to_string(*builder);
	return result;
}

registerAll :: ()->nodeCompute:string, nodeCompute2:string {
	// paramRegister(FloatParam);
	// paramRegister(UIntegerParam);
	// paramRegister(Vector3Param);
	// paramRegister(Vector3UIntParam);

	nodeRegister(BoxGeoNode);
	nodeRegister(IcosahedronGeoNode);
	nodeRegister(MergeGeoNode);
	nodeRegister(NullGeoNode);
	nodeRegister(OutputGeoNode);

	nodeCompute := generateNodeComputes();
	sceneNodeDelete := generateSceneNodeDelete();

	return nodeCompute, sceneNodeDelete;
}


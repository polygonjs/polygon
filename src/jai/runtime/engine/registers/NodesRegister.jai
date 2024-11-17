

generatedNodeCompute :: (inputNode: *$T, depth:u8=0)->GeoNodeCookOutput {
	#insert GENERATED_CODE_NODE_COMPUTE;
	assert(false, tprint("generatedNodeCompute: node type '%' is not implemented", inputNode.type));
	return newObject3D(Mesh);
}

generatedSceneNodeDelete :: (scene: *NodesScene, node: *$T, $removeFromGraph:bool = true) {
	#insert GENERATED_CODE_SCENE_NODE_DELETE;
	assert(false, tprint("generatedSceneNodeDelete: node type '%' is not implemented", node.type));
}


#scope_file


GENERATED_CODE_NODE_COMPUTE,
GENERATED_CODE_SCENE_NODE_DELETE :: #run registerNodes();


NOTE_TYPES :[..]Type;

nodeRegister :: ($T:Type) {
	array_add(*NOTE_TYPES, T);
}

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

registerNodes :: () -> nodeCompute:string, sceneNodeDelete:string {

	nodeRegister(BoxGeoNode);
	nodeRegister(IcosahedronGeoNode);
	nodeRegister(MergeGeoNode);
	nodeRegister(NullGeoNode);
	nodeRegister(OutputGeoNode);

	nodeCompute := generateNodeComputes();
	sceneNodeDelete := generateSceneNodeDelete();

	return 	nodeCompute,
			sceneNodeDelete;
}

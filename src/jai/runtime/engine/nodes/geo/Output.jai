// OutputGeoType :: struct {
// 	// type::"box";
// }
OutputGeoParams :: struct {
	input: UIntegerParam = .{value=0};
}
OutputGeoNode :: struct {
	#as using geoNode: GeoNode(OutputGeoNode, OutputGeoParams);
};


registerOutputGeoNode :: (){
	nodeRegisterGeo(TYPE, minInputsCount=0, maxInputsCount=10);
}

nodeInit :: (_node: *TYPE) {
	node := cast(*TYPE)_node;
	// nodeCastRegister(TYPE, nodeCast);
	// setOnDirty(cast(*CoreGraphNodeAny)node, onOutputDirty);
	// print("init_box_geo_node\n");
	// print("node.params.count 2: %, %\n", node.params.count, node.params);
	// init_geo_node(node);
}

cook :GeoNodeCookMethod: (node: *TYPE, inputs:GeoNodeCookInput)->GeoNodeCookOutput {
	selectedIndex := ifx node.p.input.value < inputs.count then node.p.input.value else inputs.count - 1;
	input := inputs[selectedIndex];
	scene := graphNodeScene(node);
	// node := scene.nodeTypes[nodeId];
	// scene := graphNodeScene(node);
	print("cook output:%\n", input);
	if input != null {
		array_resize(*scene.worldScene.children, 1);
		scene.worldScene.children[0] = xx input;
		print("set child\n");
	} else {
		array_resize(*scene.worldScene.children, 0);
		print("set child to null\n");
	}

	return input;
	// return null;
}



#scope_file

TYPE :: OutputGeoNode;


nodeCast :: (node: *CoreGraphNodeAny)->*TYPE {
	return cast(*TYPE)node;
}

onDirty :CoreGraphNodeOnDirtyMethod: (graph:*CoreGraph, graphNode: *CoreGraphNode) {
	node := cast(*BaseNodeAny)graphNode;
	scene := graph.scene;
	// print("cast: %\n", <<(cast(*TYPE) coreGraphNode));
	nodeCompute(scene, node);
}
// nodeComputeOutputGeoNode :NodeComputeMethod: (node: *TYPE, depth:u8=0)->GeoNodeCookOutput {
// 	return nodeCompute(cast(*TYPE)node, depth);
// }


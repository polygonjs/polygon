// OutputGeoType :: struct {
// 	// type::"box";
// }
OutputGeoParams :: struct {
	input: UIntegerParam = .{value=0};
}
OutputGeoNode :: struct {
	// #as using geoNode: GeoNode(OutputGeoNode, OutputGeoParams, maxInputs=10);
};

nodeInit :: (_node: *TYPE) {
	node := cast(*TYPE)_node;
	// nodeCastRegister(TYPE, nodeCast);
	// setOnDirty(cast(*CoreGraphNodeAny)node, onOutputDirty);
	// print("init_box_geo_node\n");
	// print("node.params.count 2: %, %\n", node.params.count, node.params);
	// init_geo_node(node);
}
registerOutputGeoNode :: (){
	nodeRegisterGeo(TYPE, minInputsCount=0, maxInputsCount=1, cook=cook, onDirty=onDirty);
}


#scope_file

TYPE :: OutputGeoNode;


nodeCast :: (node: *CoreGraphNodeAny)->*TYPE {
	return cast(*TYPE)node;
}

onDirty :CoreGraphNodeOnDirtyMethod: (graph:*CoreGraph, graphNode: *CoreGraphNode) {
	node := cast(*BaseNode)graphNode;
	scene := graph.scene;
	// print("cast: %\n", <<(cast(*TYPE) coreGraphNode));
	nodeCompute(scene, node.nodeId);
}
// nodeComputeOutputGeoNode :NodeComputeMethod: (node: *TYPE, depth:u8=0)->GeoNodeCookOutput {
// 	return nodeCompute(cast(*TYPE)node, depth);
// }

cook :GeoNodeCookMethod: (scene: *NodesScene, nodeId: NodeId, inputs:GeoNodeCookInput)->GeoNodeCookOutput {
	selectedIndex := 0;//ifx node.p.input.value < inputs.count then node.p.input.value else inputs.count - 1;
	input := inputs[selectedIndex];
	// node := scene.nodeTypes[nodeId];
	// scene := graphNodeScene(node);

	if input != null {
		array_resize(*scene.worldScene.children, 1);
		scene.worldScene.children[0] = xx input;
	} else {
		array_resize(*scene.worldScene.children, 0);
	}

	return input;
	// return null;
}

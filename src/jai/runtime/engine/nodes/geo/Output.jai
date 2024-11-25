// OutputGeoType :: struct {
// 	// type::"box";
// }
OutputGeoParams :: struct {
	input: UInt8Param = .{value=0};
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

nodeCompute :: (scene:*NodesScene, node: *TYPE, depth:u8=0) -> GeoNodeCookOutput {
	using scene;
	inputIndex := _inputIndex(node);

	srcConnectionIds := nodeConnectionFindPredecessorConnectionIds(*connections, node.nodeId);
	srcConnectionId := srcConnectionIds[inputIndex];
	connection := connections.connections[srcConnectionId];
	inputNodeId := connection.src.nodeId;
	inputNode := nodes[inputNodeId];
	// inputIndex := connection.dest.inputIndex;
	nodeInputCookResults[node.nodeId][inputIndex] = generatedNodeCompute(scene, inputNode, depth+1);
	result := cook(node, nodeInputCookResults[node.nodeId]);//cookMethod(scene, nodeId, nodeInputCookResults[node.nodeId]);
	postCook(scene, node, result, storeResult=false);
	return result;
}

cook :GeoNodeCookMethod: (node: *TYPE, inputResults:GeoNodeCookInput)->GeoNodeCookOutput {
	inputIndex := _inputIndex(node);
	inputResult := inputResults[inputIndex];
	scene := graphNodeScene(node);
	// scene := graphNodeScene(node);
	if inputResult != null {
		sceneObjectsClear(scene.worldScene);
		sceneObjectAdd(scene.worldScene, inputResult);
	} else {
		sceneObjectsClear(scene.worldScene);
	}

	return inputResult;
	// return null;
}



#scope_file

TYPE :: OutputGeoNode;

_inputIndex :: (node: *TYPE)->u8 {
	maxInputsCount := NODE_METADATAS[node.nodeTypeId].inputsCount.max;
	inputIndex := ifx node.p.input.value < maxInputsCount then node.p.input.value else maxInputsCount - 1;
	return inputIndex;
}

// nodeCast :: (node: *CoreGraphNodeAny)->*TYPE {
// 	return cast(*TYPE)node;
// }

onDirty :CoreGraphNodeOnDirtyMethod: (graph:*CoreGraph, graphNode: *CoreGraphNode) {
	node := cast(*BaseNodeAny)graphNode;
	scene := graph.scene;
	// print("cast: %\n", <<(cast(*TYPE) coreGraphNode));
	nodeCompute(scene, node);
}
// nodeComputeOutputGeoNode :NodeComputeMethod: (node: *TYPE, depth:u8=0)->GeoNodeCookOutput {
// 	return nodeCompute(cast(*TYPE)node, depth);
// }


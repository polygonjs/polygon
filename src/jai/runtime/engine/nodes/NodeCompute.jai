
nodeCompute :: (node: *$T, depth:u8=0) -> GeoNodeCookOutput {
	assert(node != null, "nodeCompute: node name is null");
	scene := graphNodeScene(node);
	// print("% 2.nodeCompute %\n", indent(depth), <<node);
	// sceneDebug(node.scene, tprint("%nodeCompute %", indent(depth), node.name));
	if dirty(node) == false {
		result, found := table_find(*graphNodeScene(node).cookResultByNodeId, node.graphNodeId);
		if found {
			return result;
		}
	}

	inputResults:GeoNodeCookInput;
	inputResults.allocator = temp;
	array_resize(*inputResults, node.maxInputsCount);
	// print("%inputResults PRE: %\n", indent(depth), inputResults);

	// for inputNode, i: node.inputs {
	// 	// print("%nodeCompute %input: %=%\n", indent(depth), node.name, i, inputNode);
	// 	if inputNode != null {
	// 		// print("%not in cache, computing\n", indent(depth));
	// 		// print("%inputResult: %\n", indent(depth), inputResult);
	// 		// print("%set % % %\n", indent(depth), i, inputResults, inputResult);
	// 		inputResults[i] = generatedNodeCompute(inputNode, depth+1);
	// 	} else {
	// 		inputResults[i] = null;
	// 	}
	// }
	using scene;
	srcConnectionIds := nodeConnectionFindPredecessorConnectionIds(*connections, node.nodeId);
	for srcConnectionId: srcConnectionIds {
		if srcConnectionId != 0 {
			connection := connections.connections[srcConnectionId];
			inputNode := nodes[connection.src.nodeId];
			inputIndex := connection.dest.inputIndex;
			inputResults[inputIndex] = generatedNodeCompute(inputNode, depth+1);
		}
	}
	
	// print("%inputResults POST: %\n", indent(depth), inputResults);
	result := cook(node, inputResults);
	unSetDirty(node);
	// TODO: dispose previous result
	table_set(*cookResultByNodeId, node.graphNodeId, result);
	return result;
}





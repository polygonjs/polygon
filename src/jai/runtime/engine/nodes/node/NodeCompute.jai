
nodeCompute :: (node: *$T, depth:u8=0) -> GeoNodeCookOutput {
	assert(node != null, "nodeCompute: node name is null");
	scene := graphNodeScene(node);
	using scene;
	// print("% 2.nodeCompute %\n", indent(depth), <<node);
	// sceneDebug(node.scene, tprint("%nodeCompute %", indent(depth), node.name));
	if dirty(node) == false {
		result := cookResults[node.nodeId];
		if result != null {
			return result;
		}
	}

	// inputResults:GeoNodeCookInput;
	// inputResults.allocator = temp;
	// array_resize(*inputResults, node.maxInputsCount);
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
	srcConnectionIds := nodeConnectionFindPredecessorConnectionIds(*connections, node.nodeId);
	for srcConnectionId: srcConnectionIds {
		if srcConnectionId != 0 {
			connection := connections.connections[srcConnectionId];
			inputNode := nodes[connection.src.nodeId];
			inputIndex := connection.dest.inputIndex;
			nodeInputCookResults[node.nodeId][inputIndex] = generatedNodeCompute(inputNode, depth+1);
		}
	}
	
	// print("%inputResults POST: %\n", indent(depth), inputResults);
	result := cook(node, nodeInputCookResults[node.nodeId]);
	unSetDirty(node);
	// TODO: dispose previous result
	print("nodeCompute %\n", node.type);

	previousResult := cookResults[node.nodeId];
	if previousResult != null {
		// object3DDelete(previousResult);
	}
	cookResults[node.nodeId] = result;
	return result;
}





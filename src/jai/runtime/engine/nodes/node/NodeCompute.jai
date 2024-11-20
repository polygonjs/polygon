
nodeCompute :: (scene:*NodesScene, nodeId: NodeId, depth:u8=0) -> GeoNodeCookOutput {
	// assert(node != null, "nodeCompute: node name is null");
	// scene := graphNodeScene(node);
	using scene;
	// print("% 2.nodeCompute %\n", indent(depth), <<node);
	// sceneDebug(node.scene, tprint("%nodeCompute %", indent(depth), node.name));
	node := nodeTypes[nodeId];
	if isDirty(*graph, node.graphNodeId) == false {
		result := cookResults[nodeId];
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
			inputNodeId := connection.src.nodeId;
			// inputNode := nodes[connection.src.nodeId];
			inputIndex := connection.dest.inputIndex;
			nodeInputCookResults[node.nodeId][inputIndex] = nodeCompute(scene, inputNodeId, depth+1);
		}
	}
	
	nodeTypeData := scene.nodeTypes[nodeId];
	nodeTypeId := nodeTypeData.nodeTypeId;
	cookMethod := COOK_METHODS[nodeTypeId];
	// print("%inputResults POST: %\n", indent(depth), inputResults);
	result := cookMethod(scene, nodeId, nodeInputCookResults[node.nodeId]);
	unSetDirty(*graph, node.graphNodeId);
	// TODO: dispose previous result

	previousResult := cookResults[node.nodeId];
	if previousResult != null {
		// object3DDelete(previousResult);
	}
	cookResults[node.nodeId] = result;
	return result;
}





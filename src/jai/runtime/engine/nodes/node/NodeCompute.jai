
nodeCompute :: (scene:*NodesScene, node: *$T, depth:u8=0) -> GeoNodeCookOutput {
	// assert(node != null, "nodeCompute: node name is null");
	// scene := graphNodeScene(node);
	using scene;
	// print("% 2.nodeCompute %\n", indent(depth), <<node);
	// sceneDebug(node.scene, tprint("%nodeCompute %", indent(depth), node.name));
	// node := nodeTypes[node.nodeId];
	if isDirty(*graph, node.graphNodeId) == false {
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
			inputNodeId := connection.src.nodeId;
			inputNode := nodeTypes[connection.src.nodeId];
			inputIndex := connection.dest.inputIndex;
			nodeInputCookResults[node.nodeId][inputIndex] = generatedNodeCompute(scene, inputNode, depth+1);
		}
	}
	
	// cookMethod := nodeCookMethod(scene, nodeId);
	// print("%inputResults POST: %\n", indent(depth), inputResults);
	result := cook(node, nodeInputCookResults[node.nodeId]);//cookMethod(scene, nodeId, nodeInputCookResults[node.nodeId]);
	unSetDirty(*graph, node.graphNodeId);
	// TODO: dispose previous result

	previousResult := cookResults[node.nodeId];
	if previousResult != null {
		// object3DDelete(previousResult);
	}
	cookResults[node.nodeId] = result;
	return result;
}
// nodeCookMethod :: (node: $T)->GeoNodeCookMethod {
// 	return nodeCookMethod(graphNodeScene(node), node.nodeId);
// }
// nodeCookMethod :: (scene:*NodesScene, nodeId: NodeId)->GeoNodeCookMethod {
// 	nodeTypeData := scene.nodeTypes[nodeId];
// 	nodeTypeId := nodeTypeData.nodeTypeId;
// 	cookMethod := COOK_METHODS[nodeTypeId];
// 	return cookMethod;
// }





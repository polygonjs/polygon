
nodeCompute :: (scene:*NodesScene, node: *$T, depth:u8=0) -> GeoNodeCookOutput {
	using scene;
	if isDirty(*graph, node.graphNodeId) == false {
		result := cookResults[node.nodeId];
		if result != null {
			return result;
		}
	}

	srcConnectionIds := nodeConnectionFindPredecessorConnectionIds(*connections, node.nodeId);
	for srcConnectionId: srcConnectionIds {
		if srcConnectionId != 0 {
			connection := connections.connections[srcConnectionId];
			inputNodeId := connection.src.nodeId;
			inputNode := nodes[inputNodeId];
			inputIndex := connection.dest.inputIndex;
			nodeInputCookResults[node.nodeId][inputIndex] = generatedNodeCompute(scene, inputNode, depth+1);
		}
	}
	result := cook(node, nodeInputCookResults[node.nodeId]);//cookMethod(scene, nodeId, nodeInputCookResults[node.nodeId]);
	postCook(scene, node, result, storeResult=true);
	return result;
}
postCook :: (scene:*NodesScene, node: *$T, result: GeoNodeCookOutput, $storeResult:bool) {
	using scene;
	cooksCount[node.nodeId] += 1;
	unSetDirty(*graph, node.graphNodeId);
	// TODO: dispose previous result

	#if storeResult {
		previousResult := cookResults[node.nodeId];
		if previousResult != null {
			generatedWorldObjectDelete(previousResult);
		}
		cookResults[node.nodeId] = result;
	}
}

nodeCooksCount :: (node: *$T)->u32 {
	return graphNodeScene(node).cooksCount[node.nodeId];
}




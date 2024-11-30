
nodeCompute :: (scene:*NodesScene, node: *$T, depth:u8=0) -> GeoNodeCookOutput {
	using scene;
	if isDirty(*graph, node.graphNodeId) == false {
		result := cookResults[node.nodeId];
		if result != null {
			return result;
		}
	}
	// TODO: no need to check input connections if node has max inputs count at 0
	srcConnectionIds := nodeConnectionFindPredecessorConnectionIds(*connections, node.nodeId);
	for srcConnectionId: srcConnectionIds {
		if srcConnectionId != 0 {
			connection := connections.connections[srcConnectionId];
			inputNodeId := connection.src.nodeId;
			inputNode := nodes[inputNodeId];
			inputIndex := connection.dest.inputIndex;
			inputCookResult := generatedNodeCompute(scene, inputNode, depth+1);
			clonedInputCookResult := geoNodeCookOutputClone(inputCookResult);
			nodeInputCookResults[node.nodeId][inputIndex] = clonedInputCookResult;
		}
	}
	result := cook(node, nodeInputCookResults[node.nodeId]);
	postCook(scene, node, result, storeResult=true);
	return result;
}
nodeComputeOnlyFromInputParam :: (scene:*NodesScene, node: *$T, depth:u8=0) -> GeoNodeCookOutput {
	using scene;
	inputIndex := inputIndexFromInputParam(node);

	srcConnectionIds := nodeConnectionFindPredecessorConnectionIds(*connections, node.nodeId);
	if srcConnectionIds.count == 0 {
		return null;
	}
	srcConnectionId := ifx inputIndex < srcConnectionIds.count then
		srcConnectionIds[inputIndex]
	else
		xx (srcConnectionIds.count - 1);
	connection := connections.connections[srcConnectionId];
	inputNodeId := connection.src.nodeId;
	inputNode := nodes[inputNodeId];
	nodeInputCookResults[node.nodeId][inputIndex] = generatedNodeCompute(scene, inputNode, depth+1);
	result := cook(node, nodeInputCookResults[node.nodeId]);
	postCook(scene, node, result, storeResult=false);
	return result;
}
postCook :: (scene:*NodesScene, node: *$T, result: GeoNodeCookOutput, $storeResult:bool) {
	using scene;
	cooksCount[node.nodeId] += 1;
	unSetDirty(*graph, node.graphNodeId);

	// #if storeResult {
	// 	previousResult := cookResults[node.nodeId];
	// 	if previousResult != null {
	// 		array_add_if_unique(*cookResultsToDispose, previousResult);
	// 	}
	// 	cookResults[node.nodeId] = result;
	// }
}
completeGeoCookWithObject :: (nodesScene:*NodesScene, node: *BaseNodeAny, object: *Object3D) -> GeoNodeCookOutput {
	return _storeResult(nodesScene, node, .[object]);
}
completeGeoCookWithObjects :: (nodesScene:*NodesScene, node: *BaseNodeAny, objects: GeoNodeCookOutput, $storeResult:bool=true) -> GeoNodeCookOutput {
	#if storeResult {
		_storeResult(nodesScene, node, <<objects);
	}
	return objects;
}
_storeResult :: (using nodesScene:*NodesScene, node: *BaseNodeAny, objects: []*Object3D) -> GeoNodeCookOutput {
	previousObjects := cookResults[node.nodeId];
	if previousObjects == null {
		cookResults[node.nodeId] = New(Object3DArray,,nodesScene.allocator);
		array_init(cookResults[node.nodeId], nodesScene.allocator);
	} else {
		for o: <<previousObjects array_add_if_unique(*cookResultsToDispose, o);
	}
	array_copy(cookResults[node.nodeId], objects);
	return cookResults[node.nodeId];
}

nodeCooksCount :: (node: *$T)->u32 {
	return graphNodeScene(node).cooksCount[node.nodeId];
}

inputIndexFromInputParam :: (node: *$T)->u8 {
	maxInputsCount := NODE_METADATAS[node.nodeTypeId].inputsCount.max;
	inputIndex := ifx node.p.input.value < maxInputsCount then node.p.input.value else maxInputsCount - 1;
	return inputIndex;
}




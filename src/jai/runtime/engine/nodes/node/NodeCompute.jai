nodeComputeInputs :: (using scene:*NodesScene, node: *$T, target:*[..]NodeId) {
	target.count = 0;
	if isDirty(*graph, node.graphNodeId) == false {
		return;
	}
	if nodeMaxInputsCount(xx node) == 0 {
		return;
	}
	srcConnectionIds := nodeConnectionFindPredecessorConnectionIds(*connections, node.nodeId);
	for srcConnectionId: srcConnectionIds {
		connection := connections.connections[srcConnectionId];
		inputNodeId := connection.src.nodeId;
		inputNode := nodes[inputNodeId];
		if isDirty(*graph, inputNode.graphNodeId) {
			array_add_if_unique(target, inputNodeId);
		}
	}
}
nodePrepareInputCookResults :: (using scene:*NodesScene, node: *$T) {
	_nodePrepareInputCookResultsWithClonedFirstInput(scene, node);
}
_nodePrepareInputCookResultsWithClonedFirstInput :: (using scene:*NodesScene, node: *$T) {
	maxInputsCount := nodeMaxInputsCount(xx node);
	if maxInputsCount == 0 {
		// print("no inputs\n");
		return;
	}
	// results := NewArray(maxInputsCount, GeoNodeCookOutput,, temp);
	for inputIndex:0..(maxInputsCount-1) {
		// print("inputIndex: %, %\n", inputIndex, cast(u64)(nodeInputCookResults[node.nodeId]).data);
		nodeInputCookResults[node.nodeId][inputIndex] = null;
	}
	srcConnectionIds := nodeConnectionFindPredecessorConnectionIds(*connections, node.nodeId);
	for srcConnectionId: srcConnectionIds {
		if connectionIdValid(srcConnectionId) {
			connection := connections.connections[srcConnectionId];
			inputNodeId := connection.src.nodeId;
			inputIndex := connection.dest.inputIndex;
			inputCookResult := cookResults[inputNodeId];
			if inputIndex == 0 {
				// we only clone the first input.
				// results[inputIndex] = geoNodeCookOutputClone(inputCookResult);
				nodeInputCookResults[node.nodeId][inputIndex] = geoNodeCookOutputClone(inputCookResult);
			} else {
				// results[inputIndex] = inputCookResult;
				nodeInputCookResults[node.nodeId][inputIndex] = inputCookResult;
			}
		}
	}

}
_nodePrepareInputCookResultsWithoutClone :: (using scene:*NodesScene, node: *$T) {
	maxInputsCount := nodeMaxInputsCount(xx node);
	if maxInputsCount == 0 {
		return;
	}
	for inputIndex:0..(maxInputsCount-1) {
		// print("inputIndex: %, %\n", inputIndex, cast(u64)(nodeInputCookResults[node.nodeId]).data);
		nodeInputCookResults[node.nodeId][inputIndex] = null;
	}
	srcConnectionIds := nodeConnectionFindPredecessorConnectionIds(*connections, node.nodeId);
	for srcConnectionId: srcConnectionIds {
		if connectionIdValid(srcConnectionId) {
			connection := connections.connections[srcConnectionId];
			inputNodeId := connection.src.nodeId;
			inputIndex := connection.dest.inputIndex;
			inputCookResult := cookResults[inputNodeId];
			nodeInputCookResults[node.nodeId][inputIndex] = inputCookResult;
		}
	}
}
// nodeCompute :: (scene:*NodesScene, node: *$T, depth:u8=0) -> GeoNodeCookOutput {
// 	using scene;
// 	if isDirty(*graph, node.graphNodeId) == false {
// 		result := cookResults[node.nodeId];
// 		if result != null {
// 			return result;
// 		}
// 	}
// 	if NODE_METADATAS[node.nodeTypeId].inputsCount.max > 0 {
// 		srcConnectionIds := nodeConnectionFindPredecessorConnectionIds(*connections, node.nodeId);
// 		for inputNodeId: inputIds {
// 			if srcConnectionId != 0 {
// 				connection := connections.connections[srcConnectionId];
// 				inputNodeId := connection.src.nodeId;
// 				inputNode := nodes[inputNodeId];
// 				inputIndex := connection.dest.inputIndex;
// 				inputCookResult := generatedNodeCompute(scene, inputNode, depth+1);
// 				clonedInputCookResult := geoNodeCookOutputClone(inputCookResult);
// 				nodeInputCookResults[node.nodeId][inputIndex] = clonedInputCookResult;
// 			}
// 		}
// 	}
// 	result := cook(node, nodeInputCookResults[node.nodeId]);
// 	postCook(scene, node, result, storeResult=true);
// 	return result;
// }
nodeComputeInputsOnlyFromInputParam :: (using scene:*NodesScene, node: *$T, target:*[..]NodeId) {
	target.count = 0;
	inputIndex := inputIndexFromInputParam(node);

	srcConnectionIds := nodeConnectionFindPredecessorConnectionIds(*connections, node.nodeId);
	if srcConnectionIds.count == 0 {
		return;
	}
	validInputIndex := min(inputIndex, xx (srcConnectionIds.count - 1));
	srcConnectionId := srcConnectionIds[validInputIndex];
	if connectionIdValid(srcConnectionId) == false {
		return;
	}
	connection := connections.connections[srcConnectionId];
	inputNodeId := connection.src.nodeId;
	inputNode := nodes[inputNodeId];
	if isDirty(*graph, inputNode.graphNodeId) {
		array_add(target, inputNodeId);
	}
}
nodeDisposePreviousCookResults :: (using scene:*NodesScene, node: *$T) {
	previousObjects := cookResults[node.nodeId];
	for o: <<previousObjects array_add_if_unique(*cookResultsToDispose, o);
}
// nodeComputeOnlyFromInputParam :: (scene:*NodesScene, node: *$T, depth:u8=0) -> GeoNodeCookOutput {
// 	using scene;
// 	inputIndex := inputIndexFromInputParam(node);

// 	srcConnectionIds := nodeConnectionFindPredecessorConnectionIds(*connections, node.nodeId);
// 	if srcConnectionIds.count == 0 {
// 		return null;
// 	}
// 	srcConnectionId := ifx inputIndex < srcConnectionIds.count then
// 		srcConnectionIds[inputIndex]
// 	else
// 		xx (srcConnectionIds.count - 1);
// 	connection := connections.connections[srcConnectionId];
// 	inputNodeId := connection.src.nodeId;
// 	inputNode := nodes[inputNodeId];
// 	nodeInputCookResults[node.nodeId][inputIndex] = generatedNodeCompute(scene, inputNode, depth+1);
// 	result := cook(node, nodeInputCookResults[node.nodeId]);
// 	postCook(scene, node, result, storeResult=false);
// 	return result;
// }
// completeCookWithResult :: (scene:*NodesScene, node: *$T, result: GeoNodeCookOutput, $storeResult:bool) {
// 	using scene;
// 	cooksCount[node.nodeId] += 1;
// 	unSetDirty(*graph, node.graphNodeId);

// 	// #if storeResult {
// 	// 	previousResult := cookResults[node.nodeId];
// 	// 	if previousResult != null {
// 	// 		array_add_if_unique(*cookResultsToDispose, previousResult);
// 	// 	}
// 	// 	cookResults[node.nodeId] = result;
// 	// }
// }
completeGeoCookWithObject :: (nodesScene:*NodesScene, node: *BaseNodeAny, object: *Object3DAny) {
	// _storeResult(nodesScene, node, .[object]);
	// nodeOutput :[..]*Object3D;
	// array_init(nodeOutput, temp);
	// array_add(nodeOutput, object);
	completeCookWithResult(nodesScene, node, object);
}
completeGeoCookWithObjects :: (nodesScene:*NodesScene, node: *BaseNodeAny, objects: GeoNodeCookOutput) {
	completeCookWithResult(nodesScene, node, objects);
	// #if storeResult {
		// _storeResult(nodesScene, node, <<objects);
	// }
	// return objects;
}
_storeResult :: (using nodesScene:*NodesScene, node: *BaseNodeAny, objects: []*Object3DAny) {
	previousObjects := cookResults[node.nodeId];
	// if previousObjects == null {
	// 	cookResults[node.nodeId] = New(Object3DArray,,nodesScene.allocator);
	// 	array_init(cookResults[node.nodeId], nodesScene.allocator);
	// } else {
	for o: <<previousObjects array_add_if_unique(*cookResultsToDispose, o);
	// }
	array_copy(cookResults[node.nodeId], objects);
	// return cookResults[node.nodeId];
}

nodeCooksCount :: (node: *$T)->u32 {
	return graphNodeScene(node).cooksCount[node.nodeId];
}

inputIndexFromInputParam :: (node: *$T)->u8 {
	maxInputsCount := nodeMaxInputsCount(xx node);
	inputIndex := ifx node.p.input.value < maxInputsCount then node.p.input.value else maxInputsCount - 1;
	return inputIndex;
}




ComputablesTree :: struct {
	cookingNodeIds:[..]NodeId;
	inputs: [..][..]NodeId;
	outputs: [..][..]NodeId;
	leaves: [..]NodeId;
}

nodesSceneOutputNodesCompute :: (scene: *NodesScene) {
	nodesSceneDisposeCookResults(scene);

	// atLeastOneCompute := false;
	for node, i: scene.nodes {
		if node.type == OutputGeoNode {
			// print(">>>> compute output node: %\n", node.nodeId);
			buildAndComputeComputableTree(scene, cast(*OutputGeoNode)node);
			return;
			// atLeastOneCompute = true;
		}
	}
	// if atLeastOneCompute
	// print(">>>> nodesSceneOutputNodesCompute :%\n", atLeastOneCompute);
}

nodesSceneDisposeCookResults :: (scene: *NodesScene) {
	for object: scene.cookResultsToDispose {
		generatedWorldObjectDelete(object);
	}
	scene.cookResultsToDispose.count = 0;
}

GeoNodeCookOutputOrObject :[2]Type: .[Object3D, Object3DArray];
completeCookWithResult :: (scene:*NodesScene, node: *$T, objects: *$O/GeoNodeCookOutputOrObject) {
	using scene;
	cooksCount[node.nodeId] += 1;
	//
	generatedNodeDisposePreviousCookResults(scene, node);
	if objects != null { // objects can be null for instance when an output node has no input
		#if type_of(<<objects) == Object3D {
			cookResults[node.nodeId].count = 0;
			array_add(cookResults[node.nodeId], objects);
		} else {
			cookResults[node.nodeId].count = 0;
			for o: <<objects {
				array_add(cookResults[node.nodeId], o);
			}
			// array_copy_shallow(*cookResults[node.nodeId], <<objects);
		}
	}
	//
	unSetDirty(*graph, node.graphNodeId);

	array_unordered_remove_by_value(*computablesTree.cookingNodeIds, node.nodeId, stop_after_first=true);

	outputNodeIds := computablesTree.outputs[node.nodeId];
	for outputNodeId: outputNodeIds {
		array_unordered_remove_by_value(*computablesTree.inputs[outputNodeId], node.nodeId, stop_after_first=true);
		if computablesTree.inputs[outputNodeId].count == 0 {
			array_add_if_unique(*computablesTree.leaves, outputNodeId);
		}
	}
	computeComputableNodes(scene);

	// #if storeResult {
	// 	previousResult := cookResults[node.nodeId];
	// 	if previousResult != null {
	// 		array_add_if_unique(*cookResultsToDispose, previousResult);
	// 	}
	// 	cookResults[node.nodeId] = result;
	// }
}



#scope_file

buildAndComputeComputableTree :: (using scene: *NodesScene, outputNode: *OutputGeoNode) {
	if computablesTree.cookingNodeIds.count > 0 {
		return;
	}
	if isDirty(*graph, outputNode.graphNodeId)==false {
		return;
	}
	buildComputableTree(scene, outputNode);
	computeComputableNodes(scene);
}

computeComputableNodes :: (using scene: *NodesScene) {
	
	while(computablesTree.leaves.count > 0) {
		nodeId := pop(*computablesTree.leaves);
		node := nodes[nodeId];
		array_add(*computablesTree.cookingNodeIds, node.nodeId);
		generatedNodePrepareInputCookResults(scene, node);
		generatedNodeCook(node, nodeInputCookResults[nodeId]);
	}
}


buildComputableTree :: (scene: *NodesScene, outputNode: *OutputGeoNode) {
	nodesToTraverse:[..]NodeId;
	traversedNodeIds:[..]NodeId;
	defer array_reset(*nodesToTraverse);
	defer array_reset(*traversedNodeIds);
	array_add(*nodesToTraverse, outputNode.nodeId);
	while nodesToTraverse.count > 0 {
		nodeId := pop(*nodesToTraverse);
		node := scene.nodes[nodeId];
		generatedNodeComputeInputs(scene, node, *scene.computablesTree.inputs[nodeId]);
		if scene.computablesTree.inputs[nodeId].count == 0 {
			array_add_if_unique(*scene.computablesTree.leaves, nodeId);
		} else {
			for inputNodeId: scene.computablesTree.inputs[nodeId] {

				array_add_if_unique(*scene.computablesTree.outputs[inputNodeId], nodeId);

				inputNode := scene.nodes[inputNodeId];
				if(array_find(traversedNodeIds, inputNodeId)==false){
					array_add(*nodesToTraverse, inputNodeId);
					array_add_if_unique(*traversedNodeIds, inputNodeId);
				}
			}
		}
	}
	// print("leaves: %\n", scene.computablesTree.leaves.count);
	// for leafId: scene.computablesTree.leaves {
	// 	print("leaf: %\n", scene.nodes[leafId].type);
	// }
}
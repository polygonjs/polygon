ComputablesTree :: struct {
	cookingNodeIds:[..]NodeId;
	inputs: [..][..]NodeId;
	outputs: [..][..]NodeId;
	leaves: [..]NodeId;
}

nodesSceneComputableTreeInit :: (using scene: *NodesScene) {
	array_init(*computablesTree.cookingNodeIds, scene.allocator, reserve=true);
	array_init(*computablesTree.inputs, scene.allocator, reserve=true);
	array_init(*computablesTree.outputs, scene.allocator, reserve=true);
	array_init(*computablesTree.leaves, scene.allocator, reserve=true);

}

nodesSceneFindFirstOutputNode :: (scene: *NodesScene) -> *OutputGeoNode {
	for node, i: scene.nodes {
		if node.type == OutputGeoNode {
			return cast(*OutputGeoNode)node;
		}
	}
	return null;
}
debugThiShit :: (scene: *NodesScene, message:string) {
	print("\n- %, %/%\n", message, scene.nodes.count, scene.nodes.allocated);
	for node, i: scene.nodes {
		print("%: %, %, %\n", i, node, node.nodeId, node.type);
		print("   node: %, %\n", node.type, node.nodeId);
	}
}
nodesSceneOutputNodesCompute :: (scene: *NodesScene) {
	nodesSceneDisposeCookResults(scene);

	outputNode := nodesSceneFindFirstOutputNode(scene);
	if outputNode != null {
		buildAndComputeComputableTree(scene, outputNode);
	}
	
}
nodesSceneSetFirstOutputNodeInput :: (scene: *NodesScene, input: u8) {
	outputNode := nodesSceneFindFirstOutputNode(scene);
	if outputNode == null {
		return;
	}
	paramSetValue(*outputNode.p.input, input);
}

nodesSceneDisposeCookResults :: (scene: *NodesScene) {
	for object: scene.cookResultsToDispose {
		generatedWorldObjectDelete(object);
	}
	scene.cookResultsToDispose.count = 0;
}

GeoNodeCookOutputOrObject :[2]Type: .[Object3D, Object3DArray];
completeCookWithResult :: (using scene:*NodesScene, node: *$T, objects: *$O/GeoNodeCookOutputOrObject) {
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
	computeComputableNodes(scene, node);

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
	computeComputableNodes(scene, xx outputNode);
}

computeComputableNodes :: (using scene: *NodesScene, callingNode: *BaseNodeAny) {
	if(computablesTree.leaves.count == 0) {
		return;
	}
	// print("<<<<<<<<<<<<<<<<<<<<<<<< START calling node=%\n", callingNode.nodeId);
	// print("computablesTree.leaves.count: %\n", computablesTree.leaves.count);
	nodeId := pop(*computablesTree.leaves);
	node := nodes[nodeId];
	// print("node: %, %\n", nodeId, node.type);
	array_add(*computablesTree.cookingNodeIds, node.nodeId);
	// debugThiShit(scene, tprint("computeComputableNodes A: %\n", node.nodeId, node.type));
	generatedNodePrepareInputCookResults(scene, node);
	// debugThiShit(scene, tprint("computeComputableNodes B: %\n", node.nodeId, node.type));
	// print("END >>>>>>>>>>>>>>>>>>>>>>>>>>\n\n\n");

	#if RUN_TESTS {
		if nodeMinInputsCount(node) == 1 {
			if nodeInputCookResults[nodeId][0] == null {
				assert(false, tprint("input 0 is null for node '%'.", nodeName(scene, node.nodeId)));
			}
		}
	}
	// print("cook: %\n", nodeName(scene, node.nodeId));
	generatedNodeCook(node, nodeInputCookResults[nodeId]);
}


buildComputableTree :: (scene: *NodesScene, outputNode: *OutputGeoNode) {
	nodesToTraverse:[..]NodeId;
	traversedNodeIds:[..]NodeId;
	defer array_reset(*nodesToTraverse);
	defer array_reset(*traversedNodeIds);
	array_add(*nodesToTraverse, outputNode.nodeId);
	// print("start:%\n", nodesToTraverse);
	while nodesToTraverse.count > 0 {
		nodeId := pop(*nodesToTraverse);
		node := scene.nodes[nodeId];
		// print("nodeId:%, node: %\n", nodeId, node);
		// print("node.type: %\n", node.type);
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
	// print("connections: %\n", scene.connections);
	// print("tree: %\n", scene.computablesTree);
	// print("leaves: %\n", scene.computablesTree.leaves.count);
	// for leafId: scene.computablesTree.leaves {
	// 	print("leaf: %\n", scene.nodes[leafId].type);
	// }
}
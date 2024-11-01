
nodeCompute :: (node: *$T, depth:u8=0) -> GeoNodeCookOutput {
	assert(node != null, "nodeCompute: node name is null");
	// print("% 2.nodeCompute %\n", indent(depth), <<node);
	// sceneDebug(node.scene, tprint("%nodeCompute %", indent(depth), node.name));
	if dirty(node) == false {
		result, found := table_find(*graphNodeScene(node).cookResultByNodeId, node.id);
		if found {
			return result;
		}
	}

	inputResults:GeoNodeCookInput=.[];
	// using node;
	array_resize(*inputResults, node.inputs.count);
	// print("%inputResults PRE: %\n", indent(depth), inputResults);

	for inputNode, i: node.inputs {
		// print("%nodeCompute %input: %=%\n", indent(depth), node.name, i, inputNode);
		if inputNode != null {
			// print("%not in cache, computing\n", indent(depth));
			// print("%inputResult: %\n", indent(depth), inputResult);
			// print("%set % % %\n", indent(depth), i, inputResults, inputResult);
			inputResults[i] = nodeComputeInputNode(inputNode, depth+1);
		} else {
			inputResults[i] = null;
		}
	}
	
	// print("%inputResults POST: %\n", indent(depth), inputResults);
	result := cook(node, inputResults);
	unSetDirty(node);
	// TODO: dispose previous result
	table_set(*graphNodeScene(node).cookResultByNodeId, node.id, result);
	return result;
}

nodeComputeInputNode :: (inputNode: *$T, depth:u8=0)->GeoNodeCookOutput {
	#insert GENERATED_CODE_NODE_COMPUTE;
	assert(false, tprint("nodeComputeResult: node type % is not implemented", inputNode.type));
	return newObject3D(Mesh);
}



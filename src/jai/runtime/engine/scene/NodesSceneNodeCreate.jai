createNode :: (scene: *NodesScene, $T:Type)->*T {
	using scene;

	// node.nodeId = nextNodeId;
	nodeTypeId := getNodeTypeId(T);
	// node:*BaseNode;
	// {	
		node := New(T,, scene.allocator);
		node.type = T;
		node.nodeId = nextNodeId;
		node.nodeTypeId = nodeTypeId;
		node.name = tprint("%",T);
	// }
	// onDirty := ON_DIRTY_METHODS[nodeTypeId];
	
	nextNodeId += 1;
	while nextNodeId < nodes.count && validNodes[nextNodeId]==true {
		nextNodeId += 1;
	}

	newSize := nextNodeId;
	if newSize > nodes.count {
		array_set_count_and_maybe_grow(*nodes, newSize);
		array_set_count_and_maybe_grow(*nodeInputCookResults, newSize);
		array_set_count_and_maybe_grow(*cookResults, newSize);
		array_set_count_and_maybe_grow(*cooksCount, newSize);
		bit_array_resize(*validNodes, newSize);
	}

	maxInputsCount := NODE_METADATAS[node.nodeTypeId].inputsCount.max;
	nodeInputCookResults[node.nodeId].allocator = scene.allocator;
	array_set_count_and_maybe_grow(*nodeInputCookResults[node.nodeId], maxInputsCount);

	// nodes[node.nodeId] = xx node;
	nodes[node.nodeId] = cast(*BaseNodeAny)node;
	graphAddNode(*graph, node);
	validNodes[node.nodeId] = true;
	// validNodeIds[node.nodeId] = true;
	nodeConnectionInitForNode(*connections, node.nodeId);
	nodeParamsInit(node);

	#if NODES_SCENE_EMIT_EVENTS {
		nodesSceneEmitEvent(scene, NodesSceneEvent.NODE_ADDED, node);
	}

	return node;
}

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
		// array_resize(*nodes, xx (nextNodeId+1));
		array_resize(*nodes, newSize);
		array_resize(*nodeInputCookResults, newSize);
		array_resize(*cookResults, newSize);
		array_resize(*cooksCount, newSize);
		bit_array_resize(*validNodes, newSize);
	}

	maxInputsCount := NODE_METADATAS[node.nodeTypeId].inputsCount.max;
	nodeInputCookResults[node.nodeId].allocator = scene.allocator;
	array_resize(*nodeInputCookResults[node.nodeId], maxInputsCount);

	// nodes[node.nodeId] = xx node;
	nodes[node.nodeId] = cast(*BaseNodeAny)node;
	graphAddNode(*graph, node);
	validNodes[node.nodeId] = true;
	// validNodeIds[node.nodeId] = true;
	nodeConnectionInitForNode(*connections, node.nodeId);
	nodeParamsInit(node);

	#if NODES_SCENE_EMIT_EVENTS {
		sceneEmitEvent(scene, NodesSceneEvent.NODE_ADDED, node);
	}

	return node;
}

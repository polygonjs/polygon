createNode :: (scene: *NodesScene, $T:Type)->*BaseNode {
	using scene;

	// node.nodeId = nextNodeId;
	nodeTypeId := getNodeTypeId(T);
	// node:*BaseNode;
	// {	
		// push_allocator(scene.allocator);
		old_allocator := context.allocator;
		context.allocator = scene.allocator;
		node := New(BaseNode);
		context.allocator = old_allocator;
		node.nodeId = nextNodeId;
		node.nodeTypeId = nodeTypeId;
		node.name = tprint("%",T);
	// }
	onDirty := ON_DIRTY_METHODS[nodeTypeId];
	
	nextNodeId += 1;
	while nextNodeId < nodeTypes.count && validNodeTypes[nextNodeId]==true {
		nextNodeId += 1;
	}

	newSize := nextNodeId;
	if newSize > nodeTypes.count {
		// array_resize(*nodes, xx (nextNodeId+1));
		array_resize(*nodeTypes, newSize);
		array_resize(*nodeInputCookResults, newSize);
		array_resize(*cookResults, newSize);
		bit_array_resize(*validNodeTypes, newSize);
	}

	maxInputsCount := NODE_INPUTS_COUNT[node.nodeTypeId].max;
	nodeInputCookResults[node.nodeId].allocator = scene.allocator;
	array_resize(*nodeInputCookResults[node.nodeId], maxInputsCount);

	// nodes[node.nodeId] = xx node;
	nodeTypes[node.nodeId] = node;
	graphAddNode(*graph, node, onDirty);
	validNodeTypes[node.nodeId] = true;
	// validNodeIds[node.nodeId] = true;
	nodeConnectionInitForNode(*connections, node.nodeId);

	#if NODES_SCENE_EMIT_EVENTS {
		sceneEmitEvent(scene, NodesSceneEvent.NODE_ADDED, node.nodeId);
	}

	return node;
}

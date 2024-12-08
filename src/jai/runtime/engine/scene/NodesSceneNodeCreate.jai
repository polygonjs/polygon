createNode :: (scene: *NodesScene, $T:Type)->*T {
	using scene;

	nodeTypeId := getNodeTypeId(T);
	node := New(T,, scene.allocator);
	node.type = T;
	node.nodeId = nextNodeId;
	node.nodeTypeId = nodeTypeId;

	

	nextNodeId += 1;
	while nextNodeId < nodes.count && validNodes[nextNodeId]==true {
		nextNodeId += 1;
	}

	newSize := nextNodeId;
	if newSize > nodes.count {
		array_set_count_and_maybe_grow(*nodes, newSize);
		array_set_count_and_maybe_grow(*nodeNames, newSize);
		array_set_count_and_maybe_grow(*nodeInputCookResults, newSize);
		array_set_count_and_maybe_grow(*cookResults, newSize);
		array_set_count_and_maybe_grow(*cooksCount, newSize);
		bit_array_resize(*validNodes, newSize);

		array_set_count_and_maybe_grow(*computablesTree.inputs, newSize);
		array_set_count_and_maybe_grow(*computablesTree.outputs, newSize);

		push_allocator(scene.allocator);
		cookResults[node.nodeId] = New(Object3DArray,,scene.allocator);
		array_init(cookResults[node.nodeId], scene.allocator);
		array_init(*computablesTree.inputs[node.nodeId], scene.allocator);
		array_init(*computablesTree.outputs[node.nodeId], scene.allocator);
	}

	maxInputsCount := NODE_METADATAS[node.nodeTypeId].inputsCount.max;
	nodeInputCookResults[node.nodeId].allocator = scene.allocator;
	array_set_count_and_maybe_grow(*nodeInputCookResults[node.nodeId], maxInputsCount);

	// nodes[node.nodeId] = xx node;
	nodes[node.nodeId] = cast(*BaseNodeAny)node;
	{
		push_allocator(scene.allocator);
		nodeNameBuilder: String_Builder;
		print_to_builder(*nodeNameBuilder, tprint("%01",T,,temp));
		nodeNames[node.nodeId] = builder_to_string(*nodeNameBuilder);
	}

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

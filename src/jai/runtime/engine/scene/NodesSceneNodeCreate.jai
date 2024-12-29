createNode :: (using scene: *NodesScene, $T:Type)->*T {
	#if RUN_TESTS {
		if scene.initialized == false {
			assert(false, "scene not initialized");
		}
		if scene.disposed == true {
			assert(false, "scene disposed");
		}
	}

	found, nodeTypeId := getNodeTypeId(T);
	assert(found, "node type not found");
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
		prevCount := nodes.count;

		array_set_count_and_maybe_grow(*nodes, newSize);
		array_set_count_and_maybe_grow(*nodeNames, newSize);
		array_set_count_and_maybe_grow(*nodeInputCookResults, newSize);
		array_set_count_and_maybe_grow(*cookResults, newSize);
		array_set_count_and_maybe_grow(*cooksCount, newSize);
		bit_array_resize(*validNodes, newSize);

		array_set_count_and_maybe_grow(*computablesTree.inputs, newSize);
		array_set_count_and_maybe_grow(*computablesTree.outputs, newSize);

		index := prevCount;
		{
			push_allocator(scene.allocator);
			cookResults[index] = New(Object3DArray,,scene.allocator);
			array_init(cookResults[index], scene.allocator, reserve=false);
		}
		array_init(*computablesTree.inputs[index], scene.allocator, reserve=true);
		array_init(*computablesTree.outputs[index], scene.allocator, reserve=true);
	}
	{
		// push_allocator(scene.allocator);
		// maxInputsCount := NODE_METADATAS[node.nodeTypeId].inputsCount.max;
		// print("DO NOT CREATE ARRAY ON EACH NEW NODE, maybe check if null?\n");
		// array_init(*nodeInputCookResults[node.nodeId], scene.allocator, reserve=false);
		// nodeInputCookResults[node.nodeId] = New([..]GeoNodeCookOutput,,scene.allocator);
		// nodeInputCookResults[node.nodeId].data = null;
		// nodeInputCookResults[node.nodeId].allocator = scene.allocator;
		// array_set_count_and_maybe_grow(*nodeInputCookResults[node.nodeId], maxInputsCount);
		// print("nodeInputCookResults[node.nodeId]:%, %, %, %\n", nodeInputCookResults[node.nodeId], nodeInputCookResults[node.nodeId].data, node, node+size_of(T));
		// print("node:%, %, %\n", T, cast(u64)node, size_of(T));

		// data := cast(u64)nodeInputCookResults[node.nodeId].data;
		// if( data >= cast(u64)node && data <= (cast(u64)node+cast(u64)size_of(T))) {
		// 	assert(false,tprint("data is in the node: node=%, data=%, node+size_of(T)=%\n", cast(u64)node, data, cast(u64)node+size_of(T)));
		// }
	}

	// nodes[node.nodeId] = xx node;
	nodes[node.nodeId] = cast(*BaseNodeAny)node;
	{
		newNodeName := tprint("%01",T);
		stringToStringFixed(newNodeName, *nodeNames[node.nodeId]);
		// after := nodeName(scene, node.nodeId);
	}

	graphAddNode(*graph, node);
	validNodes[node.nodeId] = true;
	// validNodeIds[node.nodeId] = true;
	nodeConnectionInitForNode(*connections, node.nodeId);
	nodeParamsInit(xx node);

	#if NODES_SCENE_EMIT_EVENTS {
		nodesSceneEmitEvent(scene, NodesSceneEvent.NODE_ADDED, node);
	}

	return node;
}

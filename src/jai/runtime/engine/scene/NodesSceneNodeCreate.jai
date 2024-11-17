sceneNodeAdd :: (scene: *NodesScene, node: *$T) {
	
	using scene;

	node.nodeId = nextNodeId;
	
	if nextNodeId < xx nodes.count {
		while nextNodeId < xx nodes.count && nodes[xx nextNodeId]!=null {
			nextNodeId += 1;
		}
	} else {
		array_resize(*nodes, xx (nextNodeId+1));
		array_resize(*nodeInputCookResults, xx (nextNodeId+1));
		array_resize(*cookResults, xx (nextNodeId+1));
		// bit_array_resize(*validNodeIds, xx (nextNodeId+1));
		nextNodeId += 1;
	}
	array_resize(*nodeInputCookResults[node.nodeId], node.maxInputsCount);

	nodes[node.nodeId] = xx node;
	// validNodeIds[node.nodeId] = true;
	nodeConnectionInitForNode(*connections, node.nodeId);

}

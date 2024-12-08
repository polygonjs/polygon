NodeSceneRequest :: struct {
	nodeId: u32;
	data: [..]u8;
}

sceneAddNodeRequest :: (using scene: *NodesScene, node: *$T, url: string) {
	// data :[..]u8 = NewArray(0, size_of(T));
	request: NodeSceneRequest = .{nodeId = node.nodeId};
	array_add(*nodeRequests, request);
	fetchUrl(node.nodeId, url);
}

readRequestContent :: (using scene: *NodesScene, node: *$T) {
	found, index := nodeSceneRequestIndexForNode(scene, node.nodeId);
	if !found {
		return;
	}
	request := nodeRequests[index];
	if node.type == FileSTLGeoNode {
		parseData(cast(*FileSTLGeoNode)node, xx request.data);
	} else {
		assert(false, "readRequestContent: unknown node type");
	}
	// array_reset(*request.data);
	array_unordered_remove_by_index(*nodeRequests, index);
}

#if WASM==true {
	__requestAllocation :: (nodesScene: *NodesScene, nodeId: NodeId, size: u64) {
		found, index := nodeSceneRequestIndexForNode(nodesScene, nodeId);
		if !found {
			print("requestAllocation: node not found\n");
			return;
		}
		request := *(nodesScene.nodeRequests[index]);
		// print("ta:%\n", size);
		// array :[]u8 = NewArray(xx size, u8);
		array_resize(*request.data, xx size, initialize=true);
		// print(" __requestAllocation B\n");
		onAllocateReady(nodeId, request.data.data, xx size);
		// print("__requestAllocation C\n");
		// return xx request.data.data;
	}
	__onAllocatedMemoryWritten :: (nodesScene: *NodesScene, nodeId: NodeId) {
		node := nodesScene.nodes[nodeId];
		readRequestContent(nodesScene, node);
		// print("onAllocatedMemoryWritten\n");
		// found, index := nodeSceneRequestIndexForNode(scene, node.nodeId);
		// if !found {
		// 	print("requestAllocation: node not found\n");
		// 	return;
		// }
		// request := *(nodesScene.nodeRequests[index]);
		// str:string;
		// str.count = xx ALLOCATED_SIZE;
		// str.data = ALLOCATED_PTR;

		// mesh := parseSTL(APP.nodesScene, str);
		// print("parsing done\n");
	}
}

#scope_file

nodeSceneRequestIndexForNode :: (using scene: *NodesScene, nodeId: NodeId)->bool, s64 {
	for request, i: nodeRequests {
		if request.nodeId == nodeId {
			return true, i;
		}
	}
	return false, -1;
}
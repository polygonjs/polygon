
sceneDeleteNode :: (scene: *NodesScene, node: *$T, $removeFromGraph:bool = true) {
	#if NODES_SCENE_EMIT_EVENTS {
		sceneEmitEvent(scene, NodesSceneEvent.NODE_BEFORE_REMOVE, node);
	}
	using scene;
	// found, index := array_find(nodes, cast(*GeoNodeAny)node);
	// assert(found, "node not found");

	nodeResetParams(node);

	{
		// remove inputs
		// for input, i: node.inputs {
		// 	if input != null {
		// 		removeInput(node, xx i);
		// 	}
		// }
		srcConnectionIds := nodeConnectionFindPredecessorConnectionIds(*connections, node.nodeId);
		for srcConnectionId: srcConnectionIds {
			if srcConnectionId != 0 {
				connection := connections.connections[srcConnectionId];
				removeInput(node, connection.dest.inputIndex);
			}
		}
	}

	{
		// remove inputs from successors
		destConnectionIds := nodeConnectionFindSuccessorConnectionIds(*connections, node.nodeId);
		for destConnectionId: destConnectionIds {
			if destConnectionId != 0 {
				connection := connections.connections[destConnectionId];
				if connection.src.nodeId == node.nodeId {
					removeInput(nodes[connection.dest.nodeId], connection.dest.inputIndex);
				}
			}
		}
	}

	// remove graph node
	#if removeFromGraph {
		for :params param: node { graphNodeDelete(param); }
		graphNodeDelete(node);
	}
	array_reset(*node.params);

	index := node.nodeId;
	nodes[index] = null;
	// validNodeIds[index] = false;
	if index < nextNodeId {
		nextNodeId = index;
	}

	free(node);


}

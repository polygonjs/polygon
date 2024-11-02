CoreGraphId :: u8;
CoreGraphNodeId :: u32;
CoreGraph :: struct {
	graphId: CoreGraphId;
	// we start from 1, so that we know 0 is nothing
	nextId :CoreGraphNodeId= 1; // TODO: recycle ids when a node is removed
	scene: *NodesScene;
	nodes: [..]*CoreGraphNodeAny;
	dirty: Bit_Array;
	onDirty:[..]CoreGraphNodeOnDirtyMethod;
	predecessors: [..][..]CoreGraphNodeId;
	successors: [..][..]CoreGraphNodeId;
	allPredecessors: [..][..]CoreGraphNodeId;
	allPredecessorsDirty: Bit_Array;
	allSuccessors: [..][..]CoreGraphNodeId;
	allSuccessorsDirty: Bit_Array;
}

graphInit :: (graph: *CoreGraph) {
	graph.graphId = NEXT_CORE_GRAPH_ID;
	array_resize(*CORE_GRAPHS, max(graph.graphId + 1, xx CORE_GRAPHS.count));
	CORE_GRAPHS[graph.graphId] = graph;
	NEXT_CORE_GRAPH_ID += 1;
	// init(*graph.nodeById, 512);
	// init_bit_array(*graph.dirty, 1);
}
graph :: (graphNode: *CoreGraphNodeAny) -> *CoreGraph {
	return CORE_GRAPHS[graphNode.graphId];
}
graph :: (graphId: CoreGraphId) -> *CoreGraph {
	return CORE_GRAPHS[graphId];
}



graphAddNode :: (graph: *CoreGraph, graphNode: *$T) {
	using graph;
	graphNode.graphId = graphId;
	graphNode.graphNodeId = nextId;
	assert(cast(*void)graphNode.type != null, "graphAddNode type is null");

	nextId += 1;
	while nextId < nodes.count && nodes[nextId] != null {
		nextId += 1;
	}

	if nodes.count < nextId {
		array_resize(*nodes, nextId);
		// array_resize(*dirty, nextId);
		array_resize(*onDirty, nextId);
		array_resize(*predecessors, nextId);
		array_resize(*successors, nextId);
		array_resize(*allPredecessors, nextId);
		array_resize(*allSuccessors, nextId);

		bit_array_resize(*allPredecessorsDirty, nextId);
		bit_array_resize(*allSuccessorsDirty, nextId);
		bit_array_resize(*dirty, nextId);
	}

	// table_set(*nodeById, graphNode.graphNodeId, graphNode);
	nodes[graphNode.graphNodeId] = xx graphNode;
	dirty[graphNode.graphNodeId] = true;
	onDirty[graphNode.graphNodeId] = null;
	allPredecessorsDirty[graphNode.graphNodeId] = true;
	allSuccessorsDirty[graphNode.graphNodeId] = true;
}
graphRemoveNode :: (graph: *CoreGraph, graphNode: *$T) {
	using graph;

	nodes[graphNode.graphNodeId] = null;
	onDirty[graphNode.graphNodeId] = null;
	array_resize(*predecessors[graphNode.graphNodeId], 0);
	array_resize(*successors[graphNode.graphNodeId], 0);
	array_resize(*allPredecessors[graphNode.graphNodeId], 0);
	array_resize(*allSuccessors[graphNode.graphNodeId], 0);

	if nextId > graphNode.graphNodeId {
		nextId = graphNode.graphNodeId;
	}
}

graphNodeConnect :: (graph: *CoreGraph, srcId: CoreGraphNodeId, destId: CoreGraphNodeId, $checkCycle:bool)-> bool {
	if checkCycle {
		using graph;
		if allPredecessorsDirty[srcId] == true {
			_graphAllPredecessorsUpdate(graph, srcId);
		}
		cycleDetected := array_find(allPredecessors[srcId], destId);
		if cycleDetected {
			return false;
		}
	}

	_graphCreateConnection(graph, srcId, destId);
	return true;
}

setOnDirty :: (graph: *CoreGraph, graphNode: *CoreGraphNodeAny, onDirty:CoreGraphNodeOnDirtyMethod) {
	graph.onDirty[graphNode.graphNodeId] = onDirty;
}
dirty :: (node: *$T) -> bool {
	return graph(node.graphId).dirty[node.graphNodeId];
}
unSetDirty :: (node: *$T) {
	graph(node.graphId).dirty[node.graphNodeId] = false;
}
setDirty :: (graph: *CoreGraph, graphNode: *$T, $propagate:bool = true) {
	using graph;
	dirty[graphNode.graphNodeId] = true;
	#if propagate {
		if allSuccessorsDirty[graphNode.graphNodeId] == true {
			_graphAllSuccessorsUpdate(graph, graphNode.graphNodeId);
		}
		for successorId: allSuccessors[graphNode.graphNodeId] {
			setDirty(graph, nodes[successorId], false);
		}
		for successorId: allSuccessors[graphNode.graphNodeId] {
			onDirty := graph.onDirty[successorId];
			if onDirty != null {
				onDirty(nodes[successorId]);
			}
		}
	}
}

#scope_file

NEXT_CORE_GRAPH_ID:CoreGraphId=0;
CORE_GRAPHS:[..]*CoreGraph;

_graphCreateConnection :: (graph: *CoreGraph, srcId: CoreGraphNodeId, destId: CoreGraphNodeId) {
	using graph;
	array_add(*predecessors[destId], srcId);
	array_add(*successors[srcId], destId);

	// update successors
	if allSuccessorsDirty[destId] == true {
		_graphAllSuccessorsUpdate(graph, destId);
	}
	for successorId: allSuccessors[destId] {
		allPredecessorsDirty[successorId] = true;
	}
	// update predecessors
	if allPredecessorsDirty[srcId] == true {
		_graphAllPredecessorsUpdate(graph, srcId);
	}
	for predecessorId: allPredecessors[srcId] {
		allSuccessorsDirty[predecessorId] = true;
	}
	// update newly connected
	allSuccessorsDirty[srcId] = true;
	allPredecessorsDirty[destId] = true;

}
_graphAllPredecessorsUpdate :: (graph: *CoreGraph, nodeId: CoreGraphNodeId) {
	using graph;

	tmp: [..]CoreGraphNodeId;
	array_resize(*tmp, predecessors[nodeId].count);
	array_resize(*allPredecessors[nodeId], predecessors[nodeId].count);
	for predecessorId, i: predecessors[nodeId] {
		tmp[i] = predecessorId;
		allPredecessors[nodeId][i] = predecessorId;
	}
	while tmp.count > 0 {
		nextId := pop(*tmp);
		nextNode := nodes[nextId];
		for predecessorId: predecessors[nextId] {
			array_add(*tmp, predecessorId);
			array_add(*allPredecessors[nodeId], predecessorId);
		}
	}
	allPredecessorsDirty[nodeId] = false;
}
_graphAllSuccessorsUpdate :: (graph: *CoreGraph, nodeId: CoreGraphNodeId) {
	using graph;

	tmp: [..]CoreGraphNodeId;
	array_resize(*tmp, successors[nodeId].count);
	array_resize(*allSuccessors[nodeId], successors[nodeId].count);
	for successorId, i: successors[nodeId] {
		tmp[i] = successorId;
		allSuccessors[nodeId][i] = successorId;
	}
	while tmp.count > 0 {
		nextId := pop(*tmp);
		nextNode := nodes[nextId];
		for successorId: successors[nextId] {
			array_add(*tmp, successorId);
			array_add(*allSuccessors[nodeId], successorId);
		}
	}

	allSuccessorsDirty[nodeId] = false;
}

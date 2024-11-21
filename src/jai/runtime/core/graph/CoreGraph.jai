CoreGraphId :: u8;

CoreGraph :: struct {
	graphId: CoreGraphId;
	// we start from 1, so that we know 0 is nothing
	nextGraphNodeId :CoreGraphNodeId= 0; // TODO: recycle ids when a node is removed
	scene: *NodesScene;
	nodes: [..]*CoreGraphNodeAny;
	dirty: Bit_Array;
	// onDirtyCallbacks:[..]CoreGraphNodeOnDirtyMethod;
	predecessors: [..][..]CoreGraphNodeId;
	successors: [..][..]CoreGraphNodeId;
	allPredecessors: [..][..]CoreGraphNodeId;
	allPredecessorsDirty: Bit_Array;
	allSuccessors: [..][..]CoreGraphNodeId;
	allSuccessorsDirty: Bit_Array;
}

graphInit :: (graph: *CoreGraph, _scene: *NodesScene) {
	graph.scene = _scene;
	graph.graphId = NEXT_CORE_GRAPH_ID;
	if graph.graphId >= xx CORE_GRAPHS.count {
		array_resize(*CORE_GRAPHS, xx (graph.graphId + 1));
	}
	CORE_GRAPHS[graph.graphId] = graph;
	NEXT_CORE_GRAPH_ID += 1;
	// init(*graph.nodeById, 512);
	// init_bit_array(*graph.dirty, 1);

	{
		using graph;
		// allocator := scene.allocator;
		// nodes.allocator = allocator;
		// dirty.allocator = allocator;
		// onDirty.allocator = allocator;
		// predecessors.allocator = allocator;
		// successors.allocator = allocator;
		// allPredecessors.allocator = allocator;
		// allPredecessorsDirty.allocator = allocator;
		// allSuccessors.allocator = allocator;
		// allSuccessorsDirty.allocator = allocator;
	}
}
graph :: (graphNode: *CoreGraphNodeAny) -> *CoreGraph {
	return CORE_GRAPHS[graphNode.graphId];
}
graph :: (graphId: CoreGraphId) -> *CoreGraph {
	return CORE_GRAPHS[graphId];
}
graphClearConnections :: (graph: *CoreGraph) {
	using graph;
	
	for subArray: predecessors { array_reset(*subArray); }
	for subArray: successors { array_reset(*subArray); }
	for subArray: allPredecessors { array_reset(*subArray); }
	for subArray: allSuccessors { array_reset(*subArray); }
	array_reset(*predecessors);
	array_reset(*successors);
	array_reset(*allPredecessors);
	array_reset(*allSuccessors);
}
graphDelete :: (graph: *CoreGraph) {
	using graph;
	array_reset(*nodes);
	// array_reset(*onDirtyCallbacks);
	
	graphClearConnections(graph);

	deinit(*allPredecessorsDirty);
	deinit(*allSuccessorsDirty);
	deinit(*dirty);
}

graphAddNode :: (graph: *CoreGraph, graphNode: *$T/*, onDirtyCallback:CoreGraphNodeOnDirtyMethod=null*/) {
	assert(graphNode.graphNodeId == 0, "graphAddNode: graphNode.graphId is not 0");
	
	using graph;
	graphNode.graphId = graphId;
	graphNode.graphNodeId = nextGraphNodeId;
	// assert(cast(*void)graphNode.type != null, "graphAddNode type is null");

	nextGraphNodeId += 1;
	while nextGraphNodeId < nodes.count && nodes[nextGraphNodeId] != null {
		nextGraphNodeId += 1;
	}
	newSize := nextGraphNodeId;
	if newSize > nodes.count {
		array_resize(*nodes, newSize);
		// array_resize(*onDirtyCallbacks, newSize);
		array_resize(*predecessors, newSize);
		array_resize(*successors, newSize);
		array_resize(*allPredecessors, newSize);
		array_resize(*allSuccessors, newSize);

		bit_array_resize(*allPredecessorsDirty, newSize);
		bit_array_resize(*allSuccessorsDirty, newSize);
		bit_array_resize(*dirty, newSize);
	}

	// table_set(*nodeById, graphNode.graphNodeId, graphNode);
	nodes[graphNode.graphNodeId] = cast(*CoreGraphNodeAny)graphNode;
	dirty[graphNode.graphNodeId] = true;
	// onDirtyCallbacks[graphNode.graphNodeId] = onDirtyCallback;
	allPredecessorsDirty[graphNode.graphNodeId] = true;
	allSuccessorsDirty[graphNode.graphNodeId] = true;
}
graphRemoveNode :: (graph: *CoreGraph, graphNode: *$T) {
	using graph;

	nodes[graphNode.graphNodeId] = null;
	// onDirtyCallbacks[graphNode.graphNodeId] = null;
	// array_reset_keeping_memory(*predecessors[graphNode.graphNodeId]);
	// array_reset_keeping_memory(*successors[graphNode.graphNodeId]);
	// array_reset_keeping_memory(*allPredecessors[graphNode.graphNodeId]);
	// array_reset_keeping_memory(*allSuccessors[graphNode.graphNodeId]);
	array_resize(*predecessors[graphNode.graphNodeId], 0);
	array_resize(*successors[graphNode.graphNodeId], 0);
	array_resize(*allPredecessors[graphNode.graphNodeId], 0);
	array_resize(*allSuccessors[graphNode.graphNodeId], 0);

	if nextGraphNodeId > graphNode.graphNodeId {
		nextGraphNodeId = graphNode.graphNodeId;
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
graphNodeDisconnect :: (graph: *CoreGraph, srcId: CoreGraphNodeId, destId: CoreGraphNodeId)-> bool {
	using graph;
	if predecessors[destId].count == 0 {
		return false;
	}
	found := array_find(predecessors[destId], srcId);
	if found == false {
		return false;
	}
	_graphDeleteConnection(graph, srcId, destId);
	return true;
}

// setOnDirty :: (graph: *CoreGraph, graphNode: *CoreGraphNodeAny, onDirty:CoreGraphNodeOnDirtyMethod) {
// 	graph.onDirty[graphNode.graphNodeId] = onDirty;
// }
isDirty :: (node: *$T) -> bool {
	return graph(node.graphId).dirty[node.graphNodeId];
}
isDirty :: (graph: *CoreGraph, graphNodeId: CoreGraphNodeId) -> bool {
	return graph.dirty[graphNodeId];
}
unSetDirty :: (node: *$T/CoreGraphNode) {
	graph(node.graphId).dirty[node.graphNodeId] = false;
}
unSetDirty :: (graph: *CoreGraph, graphNodeId: CoreGraphNodeId) {
	graph.dirty[graphNodeId] = false;
}
setDirty :: (graph: *CoreGraph, graphNode: *$T, $propagate:bool = true) {
	using graph;
	dirty[graphNode.graphNodeId] = true;
	#if propagate {
		if allSuccessorsDirty[graphNode.graphNodeId] == true {
			_graphAllSuccessorsUpdate(graph, graphNode.graphNodeId);
		}
		for successorId: allSuccessors[graphNode.graphNodeId] {
			// setDirty(graph, nodes[successorId], propagate=false);
			dirty[successorId] = true;
		}
		// for successorId: allSuccessors[graphNode.graphNodeId] {
		// 	onDirtyCallback := onDirtyCallbacks[successorId];
		// 	if onDirtyCallback != null {
		// 		onDirtyCallback(graph, nodes[successorId]);
		// 	}
		// }

		// {
		// 	onDirtyCallback := onDirtyCallbacks[graphNode.graphNodeId];
		// 	if onDirtyCallback != null {
		// 		assert(graphNode.graphNodeId == nodes[graphNode.graphNodeId].graphNodeId, "setDirty: graphNode and nodes[graphNode.graphNodeId] are not the same");
		// 		onDirtyCallback(graph, graphNode);
		// 	}
		// }
	}
}

#scope_file

NEXT_CORE_GRAPH_ID:CoreGraphId=0;
CORE_GRAPHS:[..]*CoreGraph;

_graphCreateConnection :: (graph: *CoreGraph, srcId: CoreGraphNodeId, destId: CoreGraphNodeId) {
	using graph;

	array_add(*predecessors[destId], srcId);
	array_add(*successors[srcId], destId);

	_updatePredecessorsAndSuccessors(graph, srcId, destId);

}
_graphDeleteConnection :: (graph: *CoreGraph, srcId: CoreGraphNodeId, destId: CoreGraphNodeId) {
	using graph;

	{
		found, index := array_find(predecessors[destId], srcId);
		predecessors[destId][index] = xx 0;
	}
	{
		found, index := array_find(successors[srcId], destId);
		successors[srcId][index] = xx 0;
	}

	_updatePredecessorsAndSuccessors(graph, srcId, destId);
}
_updatePredecessorsAndSuccessors :: (graph: *CoreGraph, srcId: CoreGraphNodeId, destId: CoreGraphNodeId) {
	using graph;

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
	tmp.allocator = temp;
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
	tmp.allocator = temp;
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

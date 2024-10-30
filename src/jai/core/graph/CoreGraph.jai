CoreGraphNodeId :: u32;
CoreGraph :: struct {
	// we start from 1, so that we know 0 is nothing (maybe)
	nextId :CoreGraphNodeId= 1; // TODO: recycle ids when a node is removed
	scene: *NodesScene;
	nodes: [..]*CoreGraphNode;
	predecessors: [..][..]CoreGraphNodeId;
	successors: [..][..]CoreGraphNodeId;
	allPredecessors: [..][..]CoreGraphNodeId;
	allPredecessorsDirty: [..]bool;
	allSuccessors: [..][..]CoreGraphNodeId;
	allSuccessorsDirty: [..]bool;
}

initGraph :: (graph: *CoreGraph) {
	// init(*graph.nodeById, 512);
}

graphAddNode :: (graph: *CoreGraph, graphNode: *$T) {
	graphNode.graph = graph;
	graphNode.scene = graph.scene;
	graphNode.id = graph.nextId;

	using graph;
	nextId += 1;

	if predecessors.count < nextId {
		array_resize(*nodes, nextId);
		array_resize(*predecessors, nextId);
		array_resize(*successors, nextId);
		array_resize(*allPredecessors, nextId);
		array_resize(*allPredecessorsDirty, nextId);
		array_resize(*allSuccessors, nextId);
		array_resize(*allSuccessorsDirty, nextId);
	}

	// table_set(*nodeById, graphNode.id, graphNode);
	nodes[graphNode.id] = graphNode;
	allPredecessorsDirty[graphNode.id] = true;
	allSuccessorsDirty[graphNode.id] = true;
}

graphConnect :: (graph: *CoreGraph, src: *CoreGraphNode, dest: *CoreGraphNode, $checkCycle:bool = true)-> bool {

	// TODO: check for cycles
	_graphCreateConnection(graph, src.id, dest.id);

	return true;
}

graphSetDirty :: (graph: *CoreGraph, graphNode: *CoreGraphNode, $propagate:bool = true) {
	using graph;
	graphNode.dirty = true;

	#if propagate {
		if allSuccessorsDirty[graphNode.id] == true {
			_graphAllSuccessorsUpdate(graph, graphNode.id);
		}
		for successorId: allSuccessors[graphNode.id] {
			graphSetDirty(graph, nodes[successorId], false);
		}
		for successorId: allSuccessors[graphNode.id] {
			nodes[successorId].onDirty(nodes[successorId]);
		}
	}
}

#scope_file

_graphCreateConnection :: (graph: *CoreGraph, srcId: CoreGraphNodeId, destId: CoreGraphNodeId) {
	using graph;
	array_add(*predecessors[destId], srcId);
	array_add(*successors[srcId], destId);

	if allPredecessorsDirty[srcId] == true {
		_graphAllPredecessorsUpdate(graph, srcId);
	}
	for predecessorId: allPredecessors[srcId] {
		allSuccessorsDirty[predecessorId] = true;
	}
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

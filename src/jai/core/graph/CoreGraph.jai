CoreGraphNodeId :: u32;
CoreGraph :: struct {
	// we start from 1, so that we know 0 is nothing (maybe)
	nextId :CoreGraphNodeId= 1; // TODO: recycle ids when a node is removed
	scene: *NodesScene;
	nodes: [..]*CoreGraphNodeAny;
	dirty: [..]bool; // TODO: use Bit_Array
	onDirty:[..]CoreGraphNodeOnDirtyMethod;
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
	// graphNode.scene = graph.scene;
	graphNode.id = graph.nextId;
	assert(cast(*void)graphNode.type != null, "graphAddNode type is null");
	// print("graphAddNode:%\n", graphNode,graphNode.type);

	using graph;
	nextId += 1;

	if predecessors.count < nextId {
		array_resize(*nodes, nextId);
		array_resize(*dirty, nextId);
		array_resize(*onDirty, nextId);
		array_resize(*predecessors, nextId);
		array_resize(*successors, nextId);
		array_resize(*allPredecessors, nextId);
		array_resize(*allPredecessorsDirty, nextId);
		array_resize(*allSuccessors, nextId);
		array_resize(*allSuccessorsDirty, nextId);
	}

	// table_set(*nodeById, graphNode.id, graphNode);
	nodes[graphNode.id] = xx graphNode;
	dirty[graphNode.id] = true;
	onDirty[graphNode.id] = null;
	allPredecessorsDirty[graphNode.id] = true;
	allSuccessorsDirty[graphNode.id] = true;
}

graphConnect :: (graph: *CoreGraph, src: *$T0, dest: *$T1, $checkCycle:bool = true)-> bool {

	// TODO: check for cycles
	_graphCreateConnection(graph, src.id, dest.id);

	return true;
}

setOnDirty :: (graph: *CoreGraph, graphNode: *CoreGraphNodeAny, onDirty:CoreGraphNodeOnDirtyMethod) {
	graph.onDirty[graphNode.id] = onDirty;
}
dirty :: (node: *$T) -> bool {
	return node.graph.dirty[node.id];
}
unSetDirty :: (node: *$T) {
	node.graph.dirty[node.id] = false;
}
setDirty :: (graph: *CoreGraph, graphNode: *$T, $propagate:bool = true) {
	using graph;
	dirty[graphNode.id] = true;
	#if propagate {
		// print("propagate START % %\n", graphNode.id, graphNode.type);
		// sceneDebug(graph.scene, tprint("setDirty from graphNode %", graphNode));
		if allSuccessorsDirty[graphNode.id] == true {
			_graphAllSuccessorsUpdate(graph, graphNode.id);
		}
		for successorId: allSuccessors[graphNode.id] {
			setDirty(graph, nodes[successorId], false);
		}
		for successorId: allSuccessors[graphNode.id] {
			onDirty := graph.onDirty[successorId];
			if onDirty != null {
				onDirty(nodes[successorId]);
			}
		}
		// print("propagate END\n");
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

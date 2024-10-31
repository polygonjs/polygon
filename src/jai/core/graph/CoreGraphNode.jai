CoreGraphNodeOnDirtyMethod :: #type (node: *CoreGraphNode);
CoreGraphNode :: struct {
	type: Type;
	id: CoreGraphNodeId;
	graph: *CoreGraph;
	dirty: bool;
	onDirty:CoreGraphNodeOnDirtyMethod = graphNodeOnDirty;
}


newCoreGraphNode :: (graph: *CoreGraph, $T: Type) -> *T {
	graphNode: *T = alloc(size_of(T));

	graphNode.type = T;
	initGraphNode(graphNode, graph);

	// print("graphAddNode % %\n", graphNode.id, graphNode.type);

	return graphNode;
}

initGraphNode :: (graphNode: *$T, graph: *CoreGraph) {
	graphAddNode(graph, graphNode);
}

setDirty :: (graphNode: *$T) {
	setDirty(graphNode.graph, graphNode);
}

graphNodeOnDirty :: (graphNode: *CoreGraphNode) {
	// print("graphNodeOnDirty:%\n", graphNode.type);
}
graphNodeScene :: (graphNode: *CoreGraphNode) -> *NodesScene {
	return graphNode.graph.scene;
}

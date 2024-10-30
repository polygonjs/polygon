CoreGraphNodeOnDirtyMethod :: #type (node: *CoreGraphNode);
CoreGraphNode :: struct {
	id: CoreGraphNodeId;
	graph: *CoreGraph;
	scene: *NodesScene;
	dirty: bool;
	onDirty:CoreGraphNodeOnDirtyMethod = graphNodeOnDirty;
}


newCoreGraphNode :: (graph: *CoreGraph, $T: Type) -> *T {
	graphNode: *T = alloc(size_of(T));

	initGraphNode(graphNode, graph);

	return graphNode;
}

initGraphNode :: (graphNode: *$T, graph: *CoreGraph) {
	graphAddNode(graph, graphNode);
}

graphNodeSetDirty :: (graphNode: *$T) {
	graphSetDirty(graphNode.graph, graphNode);
}

graphNodeOnDirty :: (graphNode: *CoreGraphNode) {
	print("graphNodeOnDirty\n");
}
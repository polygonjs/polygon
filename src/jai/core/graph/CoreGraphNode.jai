CoreGraphNodeOnDirtyMethod :: #type (node: *CoreGraphNodeAny);
CoreGraphNode :: struct ($T: Type) {
	type: Type:T;
	runtimeType: Type;
	// type: T;
	id: CoreGraphNodeId;
	graph: *CoreGraph;
}
CoreGraphNodeAny :: CoreGraphNode(Any);

newCoreGraphNode :: (graph: *CoreGraph, $T: Type) -> *T {
	graphNode: *T = alloc(size_of(T));

	// tmp: T;
	// assert(tmp.type == graphNode.type, "types are not the same");

	graphNode.runtimeType = T;
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
setOnDirty :: (graphNode: *CoreGraphNodeAny, onDirty:CoreGraphNodeOnDirtyMethod) {
	setOnDirty(graphNode.graph, graphNode, onDirty);
}

graphNodeOnDirty :: (graphNode: *CoreGraphNodeAny) {
	// print("graphNodeOnDirty:%\n", graphNode.type);
}
graphNodeScene :: (graphNode: *$T) -> *NodesScene {
	return graphNode.graph.scene;
}

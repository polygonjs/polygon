CoreGraphNodeId :: u32;
CoreGraphNodeOnDirtyMethod :: #type (graph:*CoreGraph, graphNode: *CoreGraphNode);
// CoreGraphNode :: struct ($T: Type) {
// 	// type: Type:T;
// 	type: Type;
// 	// type: T;
// 	graphNodeId: CoreGraphNodeId;
// 	graphId: CoreGraphId;
// }
// CoreGraphNodeAny :: CoreGraphNode(Any);
CoreGraphNode :: struct {
	graphNodeId: CoreGraphNodeId;
	graphId: CoreGraphId;
	// name: string;
}
CoreGraphNodeAny :: CoreGraphNode;

// newCoreGraphNode :: (graph: *CoreGraph, $T: Type) -> *T {
// 	graphNode: *T;
// 	// newContext: Context =.{temporary_storage = *graph.scene.temporary_storage};
// 	// push_context newContext {
// 		graphNode = alloc(size_of(T));
// 	// }

// 	// tmp: T;
// 	// assert(tmp.type == graphNode.type, "types are not the same");

// 	graphNode.type = T;
// 	graphNodeInit(graphNode, graph);

// 	// print("graphAddNode % %\n", graphNode.id, graphNode.type);

// 	return graphNode;
// }

// graphNodeInit :: (graphNode: *$T, graph: *CoreGraph) {
// 	graphAddNode(graph, graphNode);
// }
graphNodeDelete :: (graphNode: *$T) {
	graphRemoveNode(graph(graphNode.graphId), graphNode);
}
graphNodeConnect :: (src: *$T0, dest: *$T1, $checkCycle:bool = true)-> bool {
	assert(src.graphId == dest.graphId, "src and dest must be in the same graph");
	assert(src.graphNodeId != dest.graphNodeId, "src and dest must have difference graphNodeId");
	return graphNodeConnect(graph(src.graphId), src.graphNodeId, dest.graphNodeId, checkCycle);
}
graphNodeDisconnect :: (src: *$T0, dest: *$T1)-> bool {
	assert(src.graphId == dest.graphId, "src and dest must be in the same graph");
	return graphNodeDisconnect(graph(src.graphId), src.graphNodeId, dest.graphNodeId);
}

setDirty :: (graphNode: *CoreGraphNode) {
	setDirty(graph(graphNode.graphId), graphNode);
}
// setOnDirty :: (graphNode: *CoreGraphNodeAny, onDirty:CoreGraphNodeOnDirtyMethod) {
// 	setOnDirty(graph(graphNode.graphId), graphNode, onDirty);
// }

// graphNodeOnDirty :: (graphNode: *CoreGraphNodeAny) {
// 	// print("graphNodeOnDirty:%\n", graphNode.type);
// }
graphNodeScene :: (graphNode: *CoreGraphNode) -> *NodesScene {
	return graph(graphNode.graphId).scene;
}
graphNodeScene :: (graphNode: CoreGraphNode) -> *NodesScene {
	return graph(graphNode.graphId).scene;
}

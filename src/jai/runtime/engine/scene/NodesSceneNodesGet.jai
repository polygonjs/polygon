sceneFindNodeById :: (scene: *NodesScene, nodeId: NodeId) -> *GeoNodeAny {
	return scene.nodes[nodeId];
	// for node: scene.nodes {
	// 	if node != null && node.nodeId == nodeId {
	// 		return node;
	// 	}
	// }
	// return null;
}
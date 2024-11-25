sceneFindNodeByType :: (scene: *NodesScene, $T:Type) -> *T {
	for node: scene.nodes {
		if node != null && node.type == T {
			return cast(*T)node;
		}
	}
	return null;
}
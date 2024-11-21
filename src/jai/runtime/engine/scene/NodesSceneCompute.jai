nodesSceneOutputNodesCompute :: (scene: *NodesScene) {
	for node, i: scene.nodes {
		if node.type == OutputGeoNode && isDirty(node)==true {
			nodeCompute(scene, cast(*OutputGeoNode)node);
		}
	}
}

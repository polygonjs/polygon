nodesSceneOutputNodesCompute :: (scene: *NodesScene) {
	for node, i: scene.nodeTypes {
		if node.type == OutputGeoNode && isDirty(node)==true {
			nodeCompute(scene, cast(*OutputGeoNode)node);
		}
	}
}

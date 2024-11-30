nodesSceneOutputNodesCompute :: (scene: *NodesScene) {
	// atLeastOneCompute := false;
	for node, i: scene.nodes {
		if node.type == OutputGeoNode && isDirty(node)==true {
			// print(">>>> compute output node: %\n", node.nodeId);
			nodeCompute(scene, cast(*OutputGeoNode)node);
			// atLeastOneCompute = true;
		}
	}
	// if atLeastOneCompute
	// print(">>>> nodesSceneOutputNodesCompute :%\n", atLeastOneCompute);
}

nodesSceneDisposeCookResults :: (scene: *NodesScene) {
	for object: scene.cookResultsToDispose {
		generatedWorldObjectDelete(object);
	}
	scene.cookResultsToDispose.count = 0;
}
sceneDelete :: (using scene: *NodesScene) {

	sceneReset(scene);
	free(scene/*,,allocator=scene.allocator*/);

}

sceneReset :: (using scene: *NodesScene) {

	graphClearConnections(*graph);
	// nodeConnectionListClear(*connections);

	// for node, i: nodes {
	// 	if node != null {
	// 		generatedSceneNodeDelete(scene, node, removeFromGraph=false);
	// 	}
	// }
	{
		// array_reset(*nodeTypes);
		deinit(*validNodes);
		// for list: nodeInputCookResults { array_reset(*list); }
		// array_reset(*nodeInputCookResults);
		// print("todo: use pool")
		// for cookResult, i: cookResults { generatedWorldObjectDelete(cookResult); }
		// array_reset(*cookResults);
		graphDelete(*graph);
		// nodeConnectionListDelete(*connections);
		// array_reset(*observers);
		// observer = null;
	}
	worldObjectReset(*worldScene);
	
	allocatorReset(scene);

	// sceneAllocatorPush(scene);
	// reset_temporary_storage();
}
sceneDelete :: (scene: *NodesScene) {
	using scene;

	graphClearConnections(*graph);
	nodeConnectionListClear(*connections);

	// for node, i: nodes {
	// 	if node != null {
	// 		generatedSceneNodeDelete(scene, node, removeFromGraph=false);
	// 	}
	// }
	{
		// array_reset(*nodeTypes);
		deinit(*validNodeTypes);
		// for list: nodeInputCookResults { array_reset(*list); }
		// array_reset(*nodeInputCookResults);
		// for cookResult, i: cookResults { print("free:%,%\n", cookResult, i); object3DDelete(cookResult); }
		// array_reset(*cookResults);
		graphDelete(*graph);
		nodeConnectionListDelete(*connections);
		// array_reset(*observers);
		// observer = null;
	}
	object3DDelete(worldScene);
	// deinit_unmapping_allocator(a);
	reset(*scene.pool, overwrite_memory=true);
	free(scene/*,,allocator=scene.allocator*/);

	// sceneAllocatorPush(scene);
	// reset_temporary_storage();
}
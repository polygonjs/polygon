
nodesSceneReset :: (using scene: *NodesScene) {
	if(	scene.disposed == true ) {
		assert(false, "scene already disposed");
	}
	graphClearConnections(*graph);
	// nodeConnectionListClear(*connections);

	// for node, i: nodes {
	// 	if node != null {
	// 		generatedSceneNodeDelete(scene, node, removeFromGraph=false);
	// 	}
	// }
	{
		// array_reset(*nodeTypes);
		// deinit(*validNodes);
		// for list: nodeInputCookResults { array_reset(*list); }
		// array_reset(*nodeInputCookResults);
		// print("todo: use pool")
		// for cookResult, i: cookResults { generatedWorldObjectDelete(cookResult); }
		// array_reset(*cookResults);
		graphReset(*graph);
		// nodeConnectionListDelete(*connections);
		// array_reset(*observers);
		// observer = null;
	}
	worldObjectReset(*worldScene);
	
	allocatorReset(scene);

	scene.disposed = true;

	// sceneAllocatorPush(scene);
	// reset_temporary_storage();
}

// nodesSceneDelete :: (using scene: *NodesScene) {

// 	nodesSceneReset(scene);
// 	free(scene/*,,allocator=scene.allocator*/);

// }
testCoreGraph :: () {
	#if FREE_MEMORY_DEBUG {
		test("CoreGraphMemoryCleared", () {
			{
				// empty scene
				nodesScene := newNodesScene();
				sceneDelete(nodesScene);
				// report_memory_leaks();
				assertLeaksCount(0, "no leak when deleting an empty scene");
			}
			{
				// scene with 1 node
				nodesScene := newNodesScene();
				box1 := createNode(nodesScene, BoxGeoNode);
				// sceneDeleteNode(nodesScene, box1);
				sceneDelete(nodesScene);
				// report_memory_leaks();
				// print("leaksCount(): %\n", leaksCount());
				assertLeaksCount(0, "no leak when deleting a scene with 1 node");
			}
			{
				// scene with 2 node, input of one another
				nodesScene := newNodesScene();
				box1 := createNode(nodesScene, BoxGeoNode);
				output1 := createNode(nodesScene, OutputGeoNode);
				assertTrue(setInput(output1, 0, box1), "connection created");
				// sceneDeleteNode(nodesScene, box1);
				sceneDelete(nodesScene);
				// report_memory_leaks();
				// print("leaksCount(): %\n", leaksCount());
				assertLeaksCount(0, "no leak when deleting a scene with 2 nodes");
			}
			{
				// scene with 3 node, and we have updated a param value
				nodesScene := newNodesScene();
				box1 := createNode(nodesScene, BoxGeoNode);
				null1 := createNode(nodesScene, NullGeoNode);
				output1 := createNode(nodesScene, OutputGeoNode);
				assertTrue(setInput(output1, 0, null1));
				assertTrue(setInput(null1, 0, box1));
				paramSetValue(*box1.p.scale, 1.0);
				// sceneDeleteNode(nodesScene, box1);
				sceneDelete(nodesScene);
				assertLeaksCount(0, "no leak when deleting a scene with 3 nodes");
			}
		});
	}
	test("CoreGraphPreventCycleConnections", (){
		nodesScene := newNodesScene();
		defer sceneDelete(nodesScene);
		box1 := createNode(nodesScene, BoxGeoNode);
		box2 := createNode(nodesScene, BoxGeoNode);
		assertTrue(setInput(box1, 0, box2));
		assertFalse(setInput(box2, 0, box1));

		null1 := createNode(nodesScene, NullGeoNode);
		assertTrue(setInput(box2, 0, null1));
		assertFalse(setInput(null1, 0, box1));
	});
	test("CoreGraphNodeIdRecycle", (){
		nodesScene := newNodesScene();
		defer sceneDelete(nodesScene);
		graph := *nodesScene.graph;
		assertEqual(graph.nextGraphNodeId, 1);
		box1 := createNode(nodesScene, BoxGeoNode);
		box1GraphNodeId := box1.graphNodeId;
		assertEqual(box1.graphNodeId, 1);
		assertEqual(box1.p.size.graphNodeId, 2);
		assertEqual(graph.nextGraphNodeId, 5);
		box2 := createNode(nodesScene, BoxGeoNode);
		assertEqual(box2.graphNodeId, 5);
		assertEqual(box2.p.size.graphNodeId, 6);
		assertEqual(graph.nextGraphNodeId, 9);
		{
			// delete
			nodeDelete(box1);
			assertEqual(graph.nextGraphNodeId, 1);
		}
		{
			// recycle
			box1b := createNode(nodesScene, BoxGeoNode);
			assertEqual(box1b.graphNodeId, box1GraphNodeId, "box1GraphNodeId");
			assertEqual(graph.nextGraphNodeId, 9);
		}
		{
			// test with a null node that has no parameters, created last
			box3 := createNode(nodesScene, BoxGeoNode);
			box4 := createNode(nodesScene, BoxGeoNode);
			null1 := createNode(nodesScene, NullGeoNode);
			assertEqual(paramsCount(null1), 0);
			assertEqual(null1.graphNodeId, 17);
			assertEqual(graph.nextGraphNodeId, 18);
			nodeDelete(null1);
			assertEqual(graph.nextGraphNodeId, 17);
			null1b := createNode(nodesScene, NullGeoNode);
			assertEqual(null1b.graphNodeId, 17);
			assertEqual(graph.nextGraphNodeId, 18);
		}
		{
			// test with a null node that has no parameters, not created last
			box5 := createNode(nodesScene, BoxGeoNode);
			null2 := createNode(nodesScene, NullGeoNode);
			box6 := createNode(nodesScene, BoxGeoNode);
			assertEqual(graph.nextGraphNodeId, 27);
			nodeDelete(null2);
			assertEqual(graph.nextGraphNodeId, 22);
			box7 := createNode(nodesScene, BoxGeoNode);
			assertEqual(box7.graphNodeId, 22);
			assertEqual(box7.p.size.graphNodeId, 27);
			assertEqual(graph.nextGraphNodeId, 30);
		}
	});
}

#scope_file



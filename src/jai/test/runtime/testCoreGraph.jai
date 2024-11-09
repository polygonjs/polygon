testCoreGraph :: () {
	testCoreGraphMemoryCleared();
	testCoreGraphPreventCycleConnections();
	testCoreGraphNodeIdRecycle();
}

#scope_file

leaksCount :: ()->s64 {
	report := make_leak_report();
	defer deinit(*report);
	// bytes_total: s64;
	leaks_total: s64;
	for summary: report.sorted_summaries {
		// bytes_total += summary.bytes;
		leaks_total += summary.count;

		// bytes_total += summary.child_bytes;
		leaks_total += summary.child_count;
	}
	return leaks_total;
}

testCoreGraphMemoryCleared :: () {
	{

		// empty scene
		nodesScene := newNodesScene();
		sceneDelete(nodesScene);
		// report_memory_leaks();
		assertEqual(leaksCount(), 0, "no leak when deleting an empty scene");
	}
	{
		// scene with 1 node
		nodesScene := newNodesScene();
		box1 := newNode(nodesScene, BoxGeoNode);
		// sceneDeleteNode(nodesScene, box1);
		sceneDelete(nodesScene);
		// report_memory_leaks();
		// print("leaksCount(): %\n", leaksCount());
		assertEqual(leaksCount(), 0, "no leak when deleting a scene with 1 node");
	}
	{
		// scene with 2 node, input of one another
		nodesScene := newNodesScene();
		box1 := newNode(nodesScene, BoxGeoNode);
		output1 := newNode(nodesScene, OutputGeoNode);
		assertTrue(setInput(output1, 0, box1));
		// sceneDeleteNode(nodesScene, box1);
		sceneDelete(nodesScene);
		// report_memory_leaks();
		// print("leaksCount(): %\n", leaksCount());
		assertEqual(leaksCount(), 0, "no leak when deleting a scene with 2 nodes");
	}
	{
		// scene with 3 node, and we have updated a param value
		nodesScene := newNodesScene();
		box1 := newNode(nodesScene, BoxGeoNode);
		null1 := newNode(nodesScene, NullGeoNode);
		output1 := newNode(nodesScene, OutputGeoNode);
		assertTrue(setInput(output1, 0, null1));
		assertTrue(setInput(null1, 0, box1));
		paramSetValue(*box1.p.scale, 1.0);
		// sceneDeleteNode(nodesScene, box1);
		sceneDelete(nodesScene);
		assertEqual(leaksCount(), 0, "no leak when deleting a scene with 3 nodes");
	}
}

testCoreGraphPreventCycleConnections :: () {
	nodesScene := newNodesScene();
	defer sceneDelete(nodesScene);
	box1 := newNode(nodesScene, BoxGeoNode);
	box2 := newNode(nodesScene, BoxGeoNode);
	assertTrue(setInput(box1, 0, box2));
	assertFalse(setInput(box2, 0, box1));

	null1 := newNode(nodesScene, NullGeoNode);
	assertTrue(setInput(box2, 0, null1));
	assertFalse(setInput(null1, 0, box1));
}

testCoreGraphNodeIdRecycle :: () {
	nodesScene := newNodesScene();
	defer sceneDelete(nodesScene);
	graph := *nodesScene.graph;
	assertEqual(graph.nextId, 1);
	box1 := newNode(nodesScene, BoxGeoNode);
	box1GraphNodeId := box1.graphNodeId;
	assertEqual(box1.graphNodeId, 1);
	assertEqual(box1.p.size.graphNodeId, 2);
	assertEqual(graph.nextId, 5);
	box2 := newNode(nodesScene, BoxGeoNode);
	assertEqual(box2.graphNodeId, 5);
	assertEqual(box2.p.size.graphNodeId, 6);
	assertEqual(graph.nextId, 9);
	{
		// delete
		nodeDelete(box1);
		assertEqual(graph.nextId, 1);
	}
	{
		// recycle
		box1b := newNode(nodesScene, BoxGeoNode);
		assertEqual(box1b.graphNodeId, box1GraphNodeId, "box1GraphNodeId");
		assertEqual(graph.nextId, 9);
	}
	{
		// test with a null node that has no parameters, created last
		box3 := newNode(nodesScene, BoxGeoNode);
		box4 := newNode(nodesScene, BoxGeoNode);
		null1 := newNode(nodesScene, NullGeoNode);
		assertEqual(paramsCount(null1), 0);
		assertEqual(null1.graphNodeId, 17);
		assertEqual(graph.nextId, 18);
		nodeDelete(null1);
		assertEqual(graph.nextId, 17);
		null1b := newNode(nodesScene, NullGeoNode);
		assertEqual(null1b.graphNodeId, 17);
		assertEqual(graph.nextId, 18);
	}
	{
		// test with a null node that has no parameters, not created last
		box5 := newNode(nodesScene, BoxGeoNode);
		null2 := newNode(nodesScene, NullGeoNode);
		box6 := newNode(nodesScene, BoxGeoNode);
		assertEqual(graph.nextId, 27);
		nodeDelete(null2);
		assertEqual(graph.nextId, 22);
		box7 := newNode(nodesScene, BoxGeoNode);
		assertEqual(box7.graphNodeId, 22);
		assertEqual(box7.p.size.graphNodeId, 27);
		assertEqual(graph.nextId, 30);
	}
}


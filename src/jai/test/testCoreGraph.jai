testCoreGraph :: () {
	testCoreGraphMemoryCleared();
	testCoreGraphPreventCycleConnections();
	testCoreGraphNodeIdRecycle();
}

#scope_file

testCoreGraphMemoryCleared :: () {
	{
		nodesScene := newNodesScene();
		sceneDelete(nodesScene);

		#if FREE_MEMORY_DEBUG report_memory_leaks();
	}
}

testCoreGraphPreventCycleConnections :: () {
	nodesScene := newNodesScene();
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
		deleteNode(box1);
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
		deleteNode(null1);
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
		deleteNode(null2);
		assertEqual(graph.nextId, 22);
		box7 := newNode(nodesScene, BoxGeoNode);
		assertEqual(box7.graphNodeId, 22);
		assertEqual(box7.p.size.graphNodeId, 27);
		assertEqual(graph.nextId, 30);
	}
}


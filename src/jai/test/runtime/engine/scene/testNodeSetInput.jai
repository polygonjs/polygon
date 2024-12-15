testNodeSetInput :: () {
	testWithScene("testNodeSetInput", (using options:TestProcedureOptions) {

		assertEqual(nodesScene.nodes.count, 0, "0 nodes in scene");
		box1 := createNode(nodesScene, BoxGeoNode);
		assertEqual(nodesScene.nodes.count, 1, "1 node in scene");
		box2 := createNode(nodesScene, BoxGeoNode);
		assertEqual(nodesScene.nodes.count, 2, "2 nodes in scene");

		assertFalse(setInput(box1, 0, box1, doAssert=false), "box1 cannot connect to itself");
		assertFalse(setInput(box1, 1, box2, doAssert=false), "box1 has no input 1");
		assertTrue(setInput(box1, 0, box2, doAssert=false), "box1 has an input 0");

	});
	
}

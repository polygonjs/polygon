testNodeNames :: () {
	testWithScene("testNodeNames", (using options:TestProcedureOptions) {
		box1 := createNode(nodesScene, BoxGeoNode);
		assertEqual(nodeName(nodesScene, box1.nodeId), "BoxGeoNode1", "test with == (1)");
		assertEqual(compare(nodeName(nodesScene, box1.nodeId), "BoxGeoNode1"), 0, "test with compare (1)");
		nodeNameCopy := tprint("%", nodeName(nodesScene, box1.nodeId));
		assertEqual(compare(nodeNameCopy, "BoxGeoNode1"), 0, "test with compare (2)");
		assertEqual(nodeNameCopy, "BoxGeoNode1", "test with == (2)");

	});
	
}

test_nodes_basic_dependency :: () {
	nodesScene := newNodesScene();
	box1 := newNode(nodesScene, BoxGeoNode);
	box2 := newNode(nodesScene, BoxGeoNode);

	// assertEqual(box1.cook, box2.cook, "cook methods point to same method");
	assertNotNull(graphNodeScene(box1), "box1.scene not null");
	assertNotNull(graph(box1.graphId), "box1.graph not null");
	assertNotNull(*graphNodeScene(box1).graph, "box1.scene.graph not null");
	assertNotNull(graphNodeScene(box1).graph.scene, "box1.scene.graph.scene not null");
	assertNotNull(box1.p.scale.node, "box1.scene.scale.node not null");
	assertNotNull(graphNodeScene(*box1.p.scale), "box1.scene.scale.node.scene not null");
	assertNotNull(graph(box1.p.scale.graphId), "box1.scene.scale.graph not null");
	
	output1 := newNode(nodesScene, OutputGeoNode);
	// assertNotEqual(cast(*void)box1.cook, cast(*void)output1.cook, "cook methods do not point to same method");

	setInput(output1, box1);

	// onBoxDirty :CoreGraphNodeOnDirtyMethod: (node: *CoreGraphNode) {
	// 	result = nodeCompute(box1);
	// }
	// box1.onDirty = onBoxDirty;

	assertEqual(nodesScene.worldScene.children.count, 0);
	paramSetValue(*box1.p.scale, 2.0);
	assertEqual(nodesScene.worldScene.children.count, 1);
	// print("result: %\n", nodesScene.worldScene.children[0].geometry.attributes.position.values.count);
	// paramSetValue(*box1.p.scale, 4.0);
	// print("result: %\n", nodesScene.worldScene.children[0].geometry.attributes.position.values.count);
	// paramSetValue(*box1.p.segments, Vector3UInt.{2,2,2});
	// print("result: %\n", nodesScene.worldScene.children[0].geometry.attributes.position.values.count);
	// paramSetValue(*box1.p.segments, Vector3UInt.{4,2,2});
	// print("result: %\n", nodesScene.worldScene.children[0].geometry.attributes.position.values.count);
}

#scope_file

result:*Object3D;
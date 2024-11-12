testNodesBasicDependency :: () {
	test("NodesBasicDependency", (){
			nodesScene := newNodesScene();
		defer sceneDelete(nodesScene);
		null1 := newNode(nodesScene, NullGeoNode);
		assertEqual(null1.nodeId, 1, "nodeId starts at more than 1");
		box1 := newNode(nodesScene, BoxGeoNode);
		box2 := newNode(nodesScene, BoxGeoNode);
		icosahedron1 := newNode(nodesScene, IcosahedronGeoNode);

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

		setInput(output1, 0, box1);
		setInput(output1, 1, icosahedron1);

		// onBoxDirty :CoreGraphNodeOnDirtyMethod: (node: *CoreGraphNode) {
		// 	result = nodeCompute(box1);
		// }
		// box1.onDirty = onBoxDirty;

		assertEqual(nodesScene.worldScene.children.count, 0);
		
		paramSetValue(*box1.p.scale, 2);
		assertEqual(nodesScene.worldScene.children.count, 1);
		box3:Box3;
		firstGeometry :: (scene:*NodesScene)->*Geometry {
			firstObject := scene.worldScene.children[0];
			return (cast(*Mesh)firstObject).geometry;
		}
		box3SetFromGeometry(*box3, firstGeometry(nodesScene));
		assertEqual(firstGeometry(nodesScene).attributes.position.values.count, 24, "points count");
		assertEqual(box3Size(*box3).x, 2, "size x");

		paramSetValue(*box1.p.scale, 4);
		box3SetFromGeometry(*box3, firstGeometry(nodesScene));
		assertEqual(firstGeometry(nodesScene).attributes.position.values.count, 24, "points count");
		assertEqual(box3Size(*box3).x, 4, "size x");

		paramSetValue(*box1.p.segments, .{2,2,2});
		assertEqual(firstGeometry(nodesScene).attributes.position.values.count, 54, "points count");
		paramSetValue(*box1.p.segments, .{12,4,3});
		assertEqual(firstGeometry(nodesScene).attributes.position.values.count, 274, "points count");

		paramSetValue(*output1.p.input, 1);
		assertEqual(firstGeometry(nodesScene).attributes.position.values.count, 92, "points count");
		paramSetValue(*output1.p.input, 0);
		assertEqual(firstGeometry(nodesScene).attributes.position.values.count, 274, "points count");

		// print("result: %\n", nodesScene.worldScene.children[0].geometry.attributes.position.values.count);
		// paramSetValue(*box1.p.scale, 4.0);
		// print("result: %\n", nodesScene.worldScene.children[0].geometry.attributes.position.values.count);
		// paramSetValue(*box1.p.segments, Vector3UInt.{2,2,2});
		// print("result: %\n", nodesScene.worldScene.children[0].geometry.attributes.position.values.count);
		// paramSetValue(*box1.p.segments, Vector3UInt.{4,2,2});
		// print("result: %\n", nodesScene.worldScene.children[0].geometry.attributes.position.values.count);
	});

}

#scope_file

result:*Object3D;
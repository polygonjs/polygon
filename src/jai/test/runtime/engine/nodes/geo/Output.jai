testOutputGeoNode :: () {
	
	test("geo/output basic", (options:TestProcedureOptions) {
		nodesScene := newNodesScene();
		worldScene := nodesScene.worldScene;
		output1 := createNode(nodesScene, OutputGeoNode);
		nodesSceneOutputNodesCompute(nodesScene); // no crash if output has no input

		assertEqual(worldScene.children.count, 0);

		firstGeometry :: (nodesScene:*NodesScene)->*Geometry {
			firstObject := nodesScene.worldScene.children[0];
			return (cast(*Mesh)firstObject).geometry;
		}

		box1 := createNode(nodesScene, BoxGeoNode);
		setInput(output1, 0, box1);
		nodesSceneOutputNodesCompute(nodesScene);
		assertEqual(worldScene.children.count, 1);
		assertEqual(firstGeometry(nodesScene).attributes.position.values.count, 24, "points count");

		icosahedron1 := createNode(nodesScene, IcosahedronGeoNode);
		setInput(output1, 1, icosahedron1);
		paramSetValue(*output1.p.input, 1);
		nodesSceneOutputNodesCompute(nodesScene);
		assertEqual(worldScene.children.count, 1);
		assertEqual(firstGeometry(nodesScene).attributes.position.values.count, 92, "points count");

	});

}

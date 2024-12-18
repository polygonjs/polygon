testOutputGeoNode :: () {
	
	testWithScene("geo/output basic", (using options:TestProcedureOptions) {
		worldScene := nodesScene.worldScene;
		output1 := createNode(nodesScene, OutputGeoNode);
		nodesSceneOutputNodesCompute(nodesScene); // no crash if output has no input

		assertEqual(worldScene.children.count, 0);

		firstGeometry :: (nodesScene:*NodesScene)->*Geometry {
			if nodesScene.worldScene.children.count == 0 {
				return null;
			}
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

		// set param to a non existing input
		paramSetValue(*output1.p.input, 2);
		nodesSceneOutputNodesCompute(nodesScene);
		assertEqual(worldScene.children.count, 0);
		assertNull(firstGeometry(nodesScene), "no geometry");

	});

	testWithScene("geo/output inputs change", (using options:TestProcedureOptions) {

		add1 := createNode(nodesScene, AddGeoNode);
		box1 := createNode(nodesScene, BoxGeoNode);
		line1 := createNode(nodesScene, LineGeoNode);
		icosahedron1 := createNode(nodesScene, IcosahedronGeoNode);
		fileSTL1 := createNode(nodesScene, FileSTLGeoNode);
		output1 := createNode(nodesScene, OutputGeoNode);

		#if WASM {
			paramSetValue(*fileSTL1.p.path, tprint("%/models/stl/rounded_cube_sphere_boolean.stl", TEST_ASSETS,, nodesScene.allocator));
		} else {
			paramSetValue(*fileSTL1.p.path, tprint("%/models/stl/cube_sphere_boolean.stl", TEST_ASSETS,, nodesScene.allocator));
		}

		setInput(output1, 0, add1);
		setInput(output1, 1, box1);
		setInput(output1, 2, line1);
		setInput(output1, 3, icosahedron1);
		setInput(output1, 4, fileSTL1);

		paramSetValue(*box1.p.scale, 2.0);
		paramSetValue(*output1.p.input, 4);
		paramSetValue(*icosahedron1.p.detail, 40);

		for 0..9 {
			paramSetValue(*output1.p.input, xx it);
			nodesSceneOutputNodesCompute(nodesScene);
		}

	});

}

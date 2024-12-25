testOutputGeoNode :: () {
	
	testWithScene("geo/output basic", (using options:TestProcedureOptions) {
		worldScene := nodesScene.worldScene;
		output1 := createNode(nodesScene, OutputGeoNode);
		nodesSceneOutputNodesCompute(nodesScene); // no crash if output has no input

		assertEqual(worldScene.children.count, 0);

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

		{
			#if WASM {
				assetPath := tprint("%/models/stl/rounded_cube_sphere_boolean.stl", TEST_ASSETS);
			} else {
				assetPath := tprint("%/models/stl/cube_sphere_boolean.stl", TEST_ASSETS);
			}
			paramSetValue(*fileSTL1.p.path, assetPath);
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

	testWithScene("geo/output does not update scene if input unchanged", (using options:TestProcedureOptions) {
		add1 := createNode(nodesScene, AddGeoNode);
		box1 := createNode(nodesScene, BoxGeoNode);
		output1 := createNode(nodesScene, OutputGeoNode);

		setInput(output1, 0, add1);
		setInput(output1, 1, box1);

		paramSetValue(*output1.p.input, 1);

		paramSetValue(*box1.p.scale, 2);
		assertEqual(eventsCount(nodesScene.worldScene, .OBJECTS_ADDED), 0);

		nodesSceneOutputNodesCompute(nodesScene);
		assertEqual(eventsCount(nodesScene.worldScene, .OBJECTS_ADDED), 1);

		paramSetValue(*add1.p.position, .{1,1,1});
		nodesSceneOutputNodesCompute(nodesScene);
		assertEqual(eventsCount(nodesScene.worldScene, .OBJECTS_ADDED), 1, "output node input objects have not changed, no event should be emitted");
	});

	testWithScene("geo/output works as expected when direct input is changed", (using options:TestProcedureOptions) {
		worldScene := nodesScene.worldScene;

		output1 := createNode(nodesScene, OutputGeoNode);
		box1 := createNode(nodesScene, BoxGeoNode);
		noise1 := createNode(nodesScene, NoiseGeoNode);

		setInput(output1, 0, noise1);
		setInput(noise1, 0, box1);

		assertEqual(worldScene.children.count, 0);

		nodesSceneOutputNodesCompute(nodesScene);
		assertEqual(worldScene.children.count, 1);

		paramSetValue(*noise1.p.amp, 2);
		nodesSceneOutputNodesCompute(nodesScene);
		assertEqual(worldScene.children.count, 1);
		assertEqual(firstGeometry(nodesScene).attributes.position.values.count, 24, "points count");
		assertInDelta(firstGeometryBboxSize(nodesScene).x, 1.75, 0.0001, "size x");
		assertInDelta(firstGeometryBboxSize(nodesScene).y, 3, 0.0001, "size y");
		assertInDelta(firstGeometryBboxSize(nodesScene).z, 2, 0.0001, "size z");
	});

	testWithScene("geo/output works as expected with an input node switch that does not clone its input", (using options:TestProcedureOptions) {

		worldScene := nodesScene.worldScene;

		output1 := createNode(nodesScene, OutputGeoNode);
		switch1 := createNode(nodesScene, SwitchGeoNode);
		box1 := createNode(nodesScene, BoxGeoNode);
		icosahedron1 := createNode(nodesScene, IcosahedronGeoNode);

		setInput(output1, 0, switch1);
		setInput(switch1, 0, box1);
		setInput(switch1, 1, icosahedron1);

		nodesSceneOutputNodesCompute(nodesScene);
		assertEqual(firstGeometry(nodesScene).attributes.position.values.count, 24, "points count");

		paramSetValue(*switch1.p.input, 1);
		nodesSceneOutputNodesCompute(nodesScene);
		assertEqual(firstGeometry(nodesScene).attributes.position.values.count, 92, "points count");

		paramSetValue(*switch1.p.input, 0);
		nodesSceneOutputNodesCompute(nodesScene);
		assertEqual(firstGeometry(nodesScene).attributes.position.values.count, 24, "points count");

		paramSetValue(*switch1.p.input, 1);
		nodesSceneOutputNodesCompute(nodesScene);
		assertEqual(firstGeometry(nodesScene).attributes.position.values.count, 92, "points count");
	});

	testWithScene("geo/output works as expected with an input node noise that does not clone its input", (using options:TestProcedureOptions) {

	});

}

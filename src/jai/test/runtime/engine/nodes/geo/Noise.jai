testNoiseGeoNode :: () {

	testWithScene("geo/noise basic", (using options:TestProcedureOptions) {

		box1 := createNode(nodesScene, BoxGeoNode);
		transform1 := createNode(nodesScene, TransformGeoNode);
		noise1 := createNode(nodesScene, NoiseGeoNode);
		output1 := createNode(nodesScene, OutputGeoNode);

		assertEqual(nodesScene.connections.connections.count, 0);

		setInput(transform1, 0, box1);
		assertEqual(nodesScene.connections.connections.count, 1);
		setInput(noise1, 0, transform1);
		assertEqual(nodesScene.connections.connections.count, 2);
		setInput(output1, 0, noise1);
		assertEqual(nodesScene.connections.connections.count, 3);

		// nodesSceneOutputNodesCompute(nodesScene);

		paramSetValue(*noise1.p.amp, 2.0);
		paramSetValue(*noise1.p.freq, .{2,2,2});
		paramSetValue(*noise1.p.offset, .{0,1,0});

		nodesSceneOutputNodesCompute(nodesScene);

		assertEqual(nodesScene.worldScene.children.count, 1);
		nodesSceneDisposeCookResults(nodesScene);

		endTest();
	});

}

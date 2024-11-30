testNoiseGeoNode :: () {

	testWithScene("geo/noise basic", (using options:TestProcedureOptions) {
		worldScene := nodesScene.worldScene;

		box1 := createNode(nodesScene, BoxGeoNode);
		transform1 := createNode(nodesScene, TransformGeoNode);
		noise1 := createNode(nodesScene, NoiseGeoNode);
		output1 := createNode(nodesScene, OutputGeoNode);

		setInput(transform1, 0, box1);
		setInput(noise1, 0, transform1);
		setInput(output1, 0, noise1);

		nodesSceneOutputNodesCompute(nodesScene);

		paramSetValue(*noise1.p.amp, 2.0);
		paramSetValue(*noise1.p.freq, .{2,2,2});
		paramSetValue(*noise1.p.offset, .{0,1,0});

		nodesSceneOutputNodesCompute(nodesScene);

		assertEqual(worldScene.children.count, 1);
		nodesSceneDisposeCookResults(nodesScene);
	});

}

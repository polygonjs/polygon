testTransformGeoNode :: () {

	testWithScene("geo/transform basic", (using options:TestProcedureOptions) {
		worldScene := nodesScene.worldScene;

		box1 := createNode(nodesScene, BoxGeoNode);
		transform1 := createNode(nodesScene, TransformGeoNode);
		transform2 := createNode(nodesScene, TransformGeoNode);
		output1 := createNode(nodesScene, OutputGeoNode);

		setInput(transform1, 0, box1);
		setInput(transform2, 0, transform1);
		setInput(output1, 0, transform2);

		nodesSceneOutputNodesCompute(nodesScene);

		assertEqual(worldScene.children.count, 1);

	});

}

testFileSTLGeoNode :: () {

	testWithScene("geo/fileSTL basic", (using options:TestProcedureOptions) {
		firstGeometry :: (scene:*NodesScene)->*Geometry {
			firstObject := scene.worldScene.children[0];
			return (cast(*Mesh)firstObject).geometry;
		}

		fileSTL1 := createNode(nodesScene, FileSTLGeoNode);
		output1 := createNode(nodesScene, OutputGeoNode);

		setInput(output1, 0, fileSTL1);

		paramSetValue(*fileSTL1.p.path, tprint("%/models/stl/cube_sphere_boolean.stl", TEST_ASSETS,, nodesScene.allocator));
		nodesSceneOutputNodesCompute(nodesScene);
		// while(nodesScene.computablesTree.cookingNodeIds.count > 0) {
		// // 	sleep_milliseconds(10);
		// }
		assertEqual(firstGeometry(nodesScene).attributes.position.values.count, 1998, "points count");

		paramSetValue(*fileSTL1.p.path, tprint("%/models/stl/rounded_cube_sphere_boolean.stl", TEST_ASSETS,, nodesScene.allocator));
		nodesSceneOutputNodesCompute(nodesScene);
		assertEqual(firstGeometry(nodesScene).attributes.position.values.count, 2718, "points count");

		nodesSceneDisposeCookResults(nodesScene);
	});

	testWithScene("geo/fileSTL errors gracefully if path is incorrect", (using options:TestProcedureOptions) {

	});
	testWithScene("geo/fileSTL errors gracefully if url is incorrect", (using options:TestProcedureOptions) {

	});

}

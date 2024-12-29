
testFileSTLGeoNode :: () {

	testWithScene("geo/fileSTL basic", (using options:TestProcedureOptions) {

		fileSTL1 := createNode(nodesScene, FileSTLGeoNode);
		FILE_STL1 = fileSTL1;
		output1 := createNode(nodesScene, OutputGeoNode);
		setInput(output1, 0, fileSTL1);


		callback1 :NodesSceneOnNodesComputedCallback = (nodesScene: *NodesScene){
			assertEqual(nodesScene.computablesTree.cookingNodeIds.count, 0, "no more cooking nodes");
			assertEqual(firstGeometry(nodesScene).attributes.position.values.count, 1998, "points count");

			//
			callback2:NodesSceneOnNodesComputedCallback = (nodesScene: *NodesScene){
				assertEqual(firstGeometry(nodesScene).attributes.position.values.count, 2718, "points count");
				nodesSceneDisposeCookResults(nodesScene);
				endTest();
			};
			nodesScene.onNodesComputed = callback2;
			paramSetValue(*FILE_STL1.p.path, tprint("%/models/stl/rounded_cube_sphere_boolean.stl", TEST_ASSETS));
			nodesSceneOutputNodesCompute(nodesScene);
		};
		nodesScene.onNodesComputed = callback1;
		paramSetValue(*fileSTL1.p.path, tprint("%/models/stl/cube_sphere_boolean.stl", TEST_ASSETS));
		nodesSceneOutputNodesCompute(nodesScene);
	});

	testWithScene("geo/fileSTL errors gracefully if path is incorrect", (using options:TestProcedureOptions) {
		endTest();
	});
	testWithScene("geo/fileSTL errors gracefully if url is incorrect", (using options:TestProcedureOptions) {
		endTest();
	});

}

#scope_file

// I have tried storing the fileSTL1 in the context,
// but this fails in wasm
FILE_STL1 :*FileSTLGeoNode;

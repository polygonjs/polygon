testNetworkPanel :: () {
	test("NetworkPanel", () {
		nodesScene :*NodesScene = newNodesScene();
		assertEqual(nodesScene.nodes.count, 0, "0 nodes in scene");
		box1 := newNode(nodesScene, BoxGeoNode);
		assertEqual(nodesScene.nodes.count, 1, "1 node in scene");
		box2 := newNode(nodesScene, BoxGeoNode);
		assertEqual(nodesScene.nodes.count, 2, "2 nodes in scene");

		editor := newEditor();
		editorSetScene(editor, nodesScene);
		assertNotNull(editor.networkPanel.sceneWorld);
		assertNotNull(editor.networkPanel.sceneRaycast);

		assertEqual(editor.networkPanel.sceneWorld.children.count, 3);
		assertEqual(editor.networkPanel.sceneRaycast.children.count, 3);

		box3 := newNode(nodesScene, BoxGeoNode);
		editorFlushCommands(editor);
		assertEqual(editor.networkPanel.sceneWorld.children.count, 4);
		assertEqual(editor.networkPanel.sceneRaycast.children.count, 4);

		box4 := newNode(nodesScene, BoxGeoNode);
		editorFlushCommands(editor);
		assertEqual(editor.networkPanel.sceneWorld.children.count, 5);
		assertEqual(editor.networkPanel.sceneRaycast.children.count, 5);

		sceneDeleteNode(nodesScene, box3);
		editorFlushCommands(editor);
		assertEqual(editor.networkPanel.sceneWorld.children[3], null);
		assertEqual(editor.networkPanel.sceneRaycast.children[3], null);
		assertEqual(editor.networkPanel.sceneWorld.children.count, 5);
		assertEqual(editor.networkPanel.sceneRaycast.children.count, 5);

		editorRemoveScene(editor);
		sceneDelete(nodesScene);
		editorDelete(editor);
		report_memory_leaks();
		assertEqual(leaksCount(), 0, "no leak when deleting a scene with 4 nodes");
	});
}






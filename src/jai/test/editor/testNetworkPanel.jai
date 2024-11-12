testNetworkPanel :: () {
	test("NetworkPanel", () {
		nodesScene :*NodesScene = newNodesScene();
		box1 := newNode(nodesScene, BoxGeoNode);
		box2 := newNode(nodesScene, BoxGeoNode);

		editor: Editor;
		editorInit(*editor, nodesScene);
		assertNotNull(editor.networkPanel.sceneWorld);
		assertNotNull(editor.networkPanel.sceneRaycast);

		assertEqual(editor.networkPanel.sceneWorld.children.count, 3);
		assertEqual(editor.networkPanel.sceneRaycast.children.count, 3);

		box3 := newNode(nodesScene, BoxGeoNode);
		editorFlushCommands(*editor);
		assertEqual(editor.networkPanel.sceneWorld.children.count, 4);
		assertEqual(editor.networkPanel.sceneRaycast.children.count, 4);

		box4 := newNode(nodesScene, BoxGeoNode);
		editorFlushCommands(*editor);
		assertEqual(editor.networkPanel.sceneWorld.children.count, 5);
		assertEqual(editor.networkPanel.sceneRaycast.children.count, 5);

		sceneDeleteNode(nodesScene, box3);
		editorFlushCommands(*editor);
		assertEqual(editor.networkPanel.sceneWorld.children[3], null);
		assertEqual(editor.networkPanel.sceneRaycast.children[3], null);
		assertEqual(editor.networkPanel.sceneWorld.children.count, 5);
		assertEqual(editor.networkPanel.sceneRaycast.children.count, 5);
	});
}






testNetworkPanel :: () {
	testNetworkPanelNodesSceneToWorldScene();
}

#scope_file

testNetworkPanelNodesSceneToWorldScene :: () {
	nodesScene :*NodesScene = newNodesScene();
	box1 := newNode(nodesScene, BoxGeoNode);
	box2 := newNode(nodesScene, BoxGeoNode);

	editor: Editor;
	editorInit(*editor, nodesScene);
	assertNotNull(editor.networkPanel.worldScene);

	assertEqual(editor.networkPanel.worldScene.children.count, 2);

	box3 := newNode(nodesScene, BoxGeoNode);
	assertEqual(editor.networkPanel.worldScene.children.count, 3);

	box4 := newNode(nodesScene, BoxGeoNode);
	assertEqual(editor.networkPanel.worldScene.children.count, 4);

	sceneDeleteNode(nodesScene, box3);
	assertEqual(editor.networkPanel.worldScene.children[2], null);
	assertEqual(editor.networkPanel.worldScene.children.count, 4);
}



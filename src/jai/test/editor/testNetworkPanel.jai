testNetworkPanel :: () {
	test("NetworkPanel update scene graph", (options:TestProcedureOptions) {
		nodesScene := newNodesScene();
		assertEqual(nodesScene.nodes.count, 0, "0 nodes in scene");
		box1 := createNode(nodesScene, BoxGeoNode);
		assertEqual(nodesScene.nodes.count, 1, "1 node in scene");
		box2 := createNode(nodesScene, BoxGeoNode);
		assertEqual(nodesScene.nodes.count, 2, "2 nodes in scene");

		editor := newEditor();
		editorSetScene(editor, nodesScene);
		assertNotNull(editor.networkPanel.sceneWorld);
		#if NETWORK_PANEL_USE_RAYCAST_RENDERER assertNotNull(editor.networkPanel.sceneRaycast);

		assertEqual(editor.networkPanel.sceneWorld.children.count, 3);
		#if NETWORK_PANEL_USE_RAYCAST_RENDERER assertEqual(editor.networkPanel.sceneRaycast.children.count, 3);

		box3 := createNode(nodesScene, BoxGeoNode);
		editorFlushCommands(editor);
		assertEqual(editor.networkPanel.sceneWorld.children.count, 4);
		#if NETWORK_PANEL_USE_RAYCAST_RENDERER assertEqual(editor.networkPanel.sceneRaycast.children.count, 4);

		box4 := createNode(nodesScene, BoxGeoNode);
		editorFlushCommands(editor);
		assertEqual(editor.networkPanel.sceneWorld.children.count, 5);
		#if NETWORK_PANEL_USE_RAYCAST_RENDERER assertEqual(editor.networkPanel.sceneRaycast.children.count, 5);

		nodeDelete(box3);
		editorFlushCommands(editor);
		assertEqual(editor.networkPanel.sceneWorld.children.count, 4);
		#if NETWORK_PANEL_USE_RAYCAST_RENDERER assertEqual(editor.networkPanel.sceneRaycast.children.count, 4);
		assertEqual(editor.networkPanel.sceneWorld.children.count, 4);
		#if NETWORK_PANEL_USE_RAYCAST_RENDERER assertEqual(editor.networkPanel.sceneRaycast.children.count, 4);

		editorRemoveScene(editor);
		sceneDelete(nodesScene);
		editorDelete(editor);
		assertLeaksCount(0, "no leak when deleting a scene with 4 nodes");
	});
	testHeadless("NetworkPanel update renderer", (options:TestProcedureOptions) {
		nodesScene := newNodesScene();
		box1 := createNode(nodesScene, BoxGeoNode);
		box2 := createNode(nodesScene, BoxGeoNode);

		editor := newEditor();
		editorSetScene(editor, nodesScene);


		editor.onAfterTick = (using editor: *Editor) {
			if nodesScene.framesCount == {
				case 1; {
					assertEqual(networkPanel.sceneWorld.children.count, 3);
					assertEqual(networkPanel.rendererColor.pipelines_by_mat_type.count, 2);
					meshesCount := 0;
					for pc: networkPanel.rendererColor.pipelines_by_mat_type { meshesCount += pc.meshes.count; }
					assertEqual(meshesCount, 3);
				}
				// add a node
				case 2; {
					box3 := createNode(nodesScene, BoxGeoNode);
				}
				case 3; {
					assertEqual(networkPanel.sceneWorld.children.count, 4);
					assertEqual(networkPanel.rendererColor.pipelines_by_mat_type.count, 2);
					meshesCount := 0;
					for pc: networkPanel.rendererColor.pipelines_by_mat_type { meshesCount += pc.meshes.count; }
					assertEqual(meshesCount, 4);
				}
				// remove a node
				case 4; {
					lastNode := nodesScene.nodes[nodesScene.nodes.count-1];
					nodeDelete(lastNode);
				}
				case 5; {
					assertEqual(networkPanel.sceneWorld.children.count, 3);
					assertEqual(networkPanel.rendererColor.pipelines_by_mat_type.count, 2);
					meshesCount := 0;
					for pc: networkPanel.rendererColor.pipelines_by_mat_type { meshesCount += pc.meshes.count; }
					assertEqual(meshesCount, 3);
				}
				case 6; { editorRequestExit(editor); }
			}
		};

		editorStart(editor, options.window_size);
		sceneDelete(nodesScene);
		assertLeaksCount(0, "no leak when deleting a scene with 4 nodes");
	});
}

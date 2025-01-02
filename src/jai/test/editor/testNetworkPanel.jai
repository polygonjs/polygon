testNetworkPanel :: () {
	test("NetworkPanel update scene graph", (options:TestProcedureOptions) {
		
		nodesScene :NodesScene;
		nodesSceneInit(*nodesScene);
		// APP.nodesScene = nodesScene;
		assertEqual(nodesScene.nodes.count, 0, "0 nodes in scene");
		box1 := createNode(*nodesScene, BoxGeoNode);
		assertEqual(nodesScene.nodes.count, 1, "1 node in scene");
		box2 := createNode(*nodesScene, BoxGeoNode);
		assertEqual(nodesScene.nodes.count, 2, "2 nodes in scene");

		editor :Editor;//= *APP.editor;
		// APP.editor = editor;
		editorInit(*editor, ensureWGPUContextValid=false);
		editorSetScene(*editor, *nodesScene);

		assertEqual(editor.networkPanel.sceneWorld.children.count, 5, "5 children in sceneWorld");
		#if NETWORK_PANEL_USE_RAYCAST_RENDERER assertEqual(editor.networkPanel.sceneRaycast.children.count, 5, "5 children in sceneRaycast");

		box3 := createNode(*nodesScene, BoxGeoNode);
		editorFlushCommands(*editor);
		assertEqual(editor.networkPanel.sceneWorld.children.count, 7, "7 children in sceneWorld");
		#if NETWORK_PANEL_USE_RAYCAST_RENDERER assertEqual(editor.networkPanel.sceneRaycast.children.count, 7, "7 children in sceneRaycast");

		box4 := createNode(*nodesScene, BoxGeoNode);
		editorFlushCommands(*editor);
		assertEqual(editor.networkPanel.sceneWorld.children.count, 9, "9 children in sceneWorld");
		#if NETWORK_PANEL_USE_RAYCAST_RENDERER assertEqual(editor.networkPanel.sceneRaycast.children.count, 9, "9 children in sceneRaycast");

		setInput(box2, 0, box1);
		editorFlushCommands(*editor);
		assertEqual(editor.networkPanel.sceneWorld.children.count, 10);

		removeInput(box2, 0);
		editorFlushCommands(*editor);
		assertEqual(editor.networkPanel.sceneWorld.children.count, 9);
		#if NETWORK_PANEL_USE_RAYCAST_RENDERER assertEqual(editor.networkPanel.sceneRaycast.children.count, 9);

		nodeDelete(box3);
		editorFlushCommands(*editor);
		assertEqual(editor.networkPanel.sceneWorld.children.count, 7);
		#if NETWORK_PANEL_USE_RAYCAST_RENDERER assertEqual(editor.networkPanel.sceneRaycast.children.count, 7);
		assertEqual(editor.networkPanel.sceneWorld.children.count, 7);
		#if NETWORK_PANEL_USE_RAYCAST_RENDERER assertEqual(editor.networkPanel.sceneRaycast.children.count, 7);

		editorRemoveScene(*editor);
		nodesSceneReset(*nodesScene);
		editorReset(*editor);
		assertLeaksCount(0, "no leak when deleting a scene with 4 nodes");

		endTest();
	});
	testHeadless("NetworkPanel update renderer", (using options:TestProcedureOptions) {
		#if HAS_NETWORK_PANEL == false {return;}
		// nodesScene := newNodesScene();
		box1 := createNode(nodesScene, BoxGeoNode);
		box2 := createNode(nodesScene, BoxGeoNode);

		editor.onAfterTick = (using editor: *Editor) {
			if nodesScene.framesCount == {
				case 1; {
					assertEqual(networkPanel.sceneWorld.children.count, 5, "5 children in sceneWorld");
					assertEqual(networkPanel.rendererColor.pipelines_by_mat_type.count, 3, "3 pipelines in rendererColor");
					assertEqual(_meshesCount(*networkPanel), 5, "5 meshes in rendererColor");
				}
				// add a node
				case 2; {
					output1 := createNode(nodesScene, OutputGeoNode);
				}
				case 3; {
					assertEqual(networkPanel.sceneWorld.children.count, 7, "7 children in sceneWorld");
					assertEqual(networkPanel.rendererColor.pipelines_by_mat_type.count, 3, "3 pipelines in rendererColor");
					assertEqual(_meshesCount(*networkPanel), 7, "7 meshes in rendererColor");
				}
				// connect a node
				// case 4; {
				// 	output1 := sceneFindNodeByType(nodesScene, OutputGeoNode);
				// 	box1 := sceneFindNodeByType(nodesScene, BoxGeoNode);
				// 	setInput(output1, 0, box1);
				// }
				// case 5; {
				// 	assertEqual(networkPanel.sceneWorld.children.count, 5);
				// 	assertEqual(networkPanel.rendererColor.pipelines_by_mat_type.count, 3);
				// 	assertEqual(_meshesCount(networkPanel), 5);
				// }
				// remove a node
				case 6; {
					lastNode := nodesScene.nodes[nodesScene.nodes.count-1];
					nodeDelete(lastNode);
				}
				case 7; {
					assertEqual(networkPanel.sceneWorld.children.count, 5, "5 children in sceneWorld");
					assertEqual(networkPanel.rendererColor.pipelines_by_mat_type.count, 3, "3 pipelines in rendererColor");
					assertEqual(_meshesCount(*networkPanel), 5, "5 meshes in rendererColor");
				}
				case 8; { editorRequestExit(editor); }
			}
		};

		editor.onAfterDelete = (_: *NodesScene){ endTest(); };
		editorStart(editor);
		// sceneDelete(nodesScene);
		// assertLeaksCount(0, "no leak when deleting a scene with 4 nodes");
	});
}


#scope_file

_meshesCount :: (networkPanel: *NetworkPanel)->u64{
	meshesCount :u64= 0;
	for pc: networkPanel.rendererColor.pipelines_by_mat_type { meshesCount += xx pc.drawDatas.count; }
	return meshesCount;
}
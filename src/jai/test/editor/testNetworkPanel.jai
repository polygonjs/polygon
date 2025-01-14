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

		assertEqual(editor.networkPanel.sceneWorld.children.count, 3, "3 children in sceneWorld");
		#if NETWORK_PANEL_USE_RAYCAST_RENDERER assertEqual(editor.networkPanel.sceneRaycast.children.count, 3, "3 children in sceneRaycast");

		box3 := createNode(*nodesScene, BoxGeoNode);
		editorFlushCommands(*editor);
		assertEqual(editor.networkPanel.sceneWorld.children.count, 4, "4 children in sceneWorld");
		#if NETWORK_PANEL_USE_RAYCAST_RENDERER assertEqual(editor.networkPanel.sceneRaycast.children.count, 4, "4 children in sceneRaycast");

		box4 := createNode(*nodesScene, BoxGeoNode);
		editorFlushCommands(*editor);
		assertEqual(editor.networkPanel.sceneWorld.children.count, 5, "5 children in sceneWorld");
		#if NETWORK_PANEL_USE_RAYCAST_RENDERER assertEqual(editor.networkPanel.sceneRaycast.children.count, 5, "5 children in sceneRaycast");

		setInput(box2, 0, box1);
		editorFlushCommands(*editor);
		assertEqual(editor.networkPanel.sceneWorld.children.count, 6);

		removeInput(box2, 0);
		editorFlushCommands(*editor);
		assertEqual(editor.networkPanel.sceneWorld.children.count, 5);
		#if NETWORK_PANEL_USE_RAYCAST_RENDERER assertEqual(editor.networkPanel.sceneRaycast.children.count, 5);

		nodeDelete(box3);
		editorFlushCommands(*editor);
		assertEqual(editor.networkPanel.sceneWorld.children.count, 4);
		#if NETWORK_PANEL_USE_RAYCAST_RENDERER assertEqual(editor.networkPanel.sceneRaycast.children.count, 4);
		assertEqual(editor.networkPanel.sceneWorld.children.count, 4);
		#if NETWORK_PANEL_USE_RAYCAST_RENDERER assertEqual(editor.networkPanel.sceneRaycast.children.count, 4);

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
					assertEqual(networkPanel.sceneWorld.children.count, 3, "3 children in sceneWorld");
					assertEqual(networkPanel.rendererColor.pipelines_by_mat_type.count, 2, "2 pipelines in rendererColor");
					assertEqual(_meshesCount(*networkPanel), 3, "3 meshes in rendererColor");
				}
				// add a node
				case 2; {
					output1 := createNode(nodesScene, OutputGeoNode);
				}
				case 3; {
					assertEqual(networkPanel.sceneWorld.children.count, 4, "4 children in sceneWorld");
					assertEqual(networkPanel.rendererColor.pipelines_by_mat_type.count, 2, "2 pipelines in rendererColor");
					assertEqual(_meshesCount(*networkPanel), 4, "4 meshes in rendererColor");
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
					assertEqual(networkPanel.sceneWorld.children.count, 3, "3 children in sceneWorld");
					assertEqual(networkPanel.rendererColor.pipelines_by_mat_type.count, 2, "2 pipelines in rendererColor");
					assertEqual(_meshesCount(*networkPanel), 3, "3 meshes in rendererColor");
				}
				case 8; { editorRequestExit(editor); }
			}
		};

		editor.onAfterDelete = (_: *NodesScene){ endTest(); };
		editorStart(editor);
		// sceneDelete(nodesScene);
		// assertLeaksCount(0, "no leak when deleting a scene with 4 nodes");
	});
	testHeadless("NetworkPanel NodeSelectCommand", (using options:TestProcedureOptions) {
		#if HAS_NETWORK_PANEL == false {return;}

		assertEqual(editor.history.commands.count, 0);
		assertEqual(editor.history.index, -1);
		assertEqual(editor.sceneUiData.selectedNodeIds.count, 0);

		_box1 := createNode(nodesScene, BoxGeoNode);
		_box2 := createNode(nodesScene, BoxGeoNode);

		editor.onAfterTick = (using editor: *Editor) {
			box1 := nodesScene.nodes[0];
			box2 := nodesScene.nodes[1];
			if nodesScene.framesCount == {
				case 1; {
					assertEqual(cast(*Material)(cast(*Mesh)(editor.networkPanel.sceneWorld.children[1])).material, xx *editor.networkPanel.mat.nodeBasic);

					newNodeSelectCommand(editor.networkPanel.editor, .[box1.nodeId], .REPLACE, push=true);
					assertEqual(editor.history.commands.count, 1);
					assertEqual(editor.history.index, 0);
					assertEqual(editor.sceneUiData.selectedNodeIds.count, 1);
					assertEqual(editor.sceneUiData.selectedNodeIds[0], box1.nodeId);

					newNodeSelectCommand(editor.networkPanel.editor, .[box2.nodeId], .REPLACE, push=true);
					assertEqual(editor.history.commands.count, 2);
					assertEqual(editor.history.index, 1);
					assertEqual(editor.sceneUiData.selectedNodeIds.count, 1);
					assertEqual(editor.sceneUiData.selectedNodeIds[0], box2.nodeId);
				}
				case 2; {
					assertEqual(cast(*Material)(cast(*Mesh)(editor.networkPanel.sceneWorld.children[2])).material, xx *editor.networkPanel.mat.nodeSelected);
				}
				case 3; {
					assertEqual(editor.commands.nodeSelectionRemoved.count, 0);
					assertEqual(editor.commands.nodeSelectionAdded.count, 0);

					editorUndo(editor);
					assertEqual(editor.history.commands.count, 2);
					assertEqual(editor.history.index, 0);
					assertEqual(editor.sceneUiData.selectedNodeIds.count, 1);
					assertEqual(editor.sceneUiData.selectedNodeIds[0], box1.nodeId);

					assertEqual(editor.commands.nodeSelectionRemoved.count, 1);
					assertEqual(editor.commands.nodeSelectionAdded.count, 1);

					print("last undo\n");
					editorUndo(editor);
					assertEqual(editor.history.commands.count, 2);
					assertEqual(editor.history.index, -1);
					assertEqual(editor.sceneUiData.selectedNodeIds.count, 0);

					assertEqual(editor.commands.nodeSelectionRemoved.count, 2);
					assertEqual(editor.commands.nodeSelectionAdded.count, 0);
				}
				case 4; {
					assertEqual(cast(*Material)(cast(*Mesh)(editor.networkPanel.sceneWorld.children[1])).material, xx *editor.networkPanel.mat.nodeBasic);
					assertEqual(cast(*Material)(cast(*Mesh)(editor.networkPanel.sceneWorld.children[2])).material, xx *editor.networkPanel.mat.nodeBasic);
				}
				case 5; {
					editorRedo(editor);
					assertEqual(editor.history.commands.count, 2);
					assertEqual(editor.history.index, 0);
					assertEqual(editor.sceneUiData.selectedNodeIds.count, 1);
					assertEqual(editor.sceneUiData.selectedNodeIds[0], box1.nodeId);

					editorRedo(editor);
					assertEqual(editor.history.commands.count, 2);
					assertEqual(editor.history.index, 1);
					assertEqual(editor.sceneUiData.selectedNodeIds.count, 1);
					assertEqual(editor.sceneUiData.selectedNodeIds[0], box2.nodeId);
				}
				case 6; {
					assertEqual(cast(*Material)(cast(*Mesh)(editor.networkPanel.sceneWorld.children[1])).material, xx *editor.networkPanel.mat.nodeBasic);
					assertEqual(cast(*Material)(cast(*Mesh)(editor.networkPanel.sceneWorld.children[2])).material, xx *editor.networkPanel.mat.nodeSelected);
				}

				case 7; { editorRequestExit(editor); }
			}
		};
		editor.onAfterDelete = (_: *NodesScene){ endTest(); };
		editorStart(editor);

	});

	testHeadless("NetworkPanel NodeMoveCommand", (using options:TestProcedureOptions) {
		#if HAS_NETWORK_PANEL == false {return;}

		assertEqual(editor.history.commands.count, 0);
		assertEqual(editor.history.index, -1);
		assertEqual(editor.sceneUiData.nodePositions.count, 0);

		_box1 := createNode(nodesScene, BoxGeoNode);
		_box2 := createNode(nodesScene, BoxGeoNode);

		editor.onAfterTick = (using editor: *Editor) {
			box1 := nodesScene.nodes[0];
			box2 := nodesScene.nodes[1];

			if nodesScene.framesCount == {
				case 1; {
					assertEqual(editor.sceneUiData.nodePositions.count, 2);
					assertEqual(networkPanel.sceneWorld.children[1].position, Vector3.{0,0,0}, "child 1 1 0,0");
					item:NodeMoveCommandItem= .{
						nodeId = box1.nodeId,
						startPos=editor.sceneUiData.nodePositions[box1.nodeId],
						endPos=.{1.2,3.7}
					};
					newNodeMoveCommand(editor.networkPanel.editor, .[item], push=true);
				}
				case 2; {
					assertEqual(editor.sceneUiData.nodePositions[0], Vector2.{1,4});
					assertEqual(networkPanel.sceneWorld.children[1].position, Vector3.{1,4,0}, "child 1 has move");
					editorUndo(editor);
				}
				case 3; {
					assertEqual(editor.sceneUiData.nodePositions[0], Vector2.{0,0});
					assertEqual(networkPanel.sceneWorld.children[1].position, Vector3.{0,0,0}, "child 1 back to 0,0");
					editorRedo(editor);
				}
				case 4; {
					assertEqual(editor.sceneUiData.nodePositions[0], Vector2.{1,4});
					assertEqual(networkPanel.sceneWorld.children[1].position, Vector3.{1,4,0}, "child 1 has move");
				}
				case 5; { editorRequestExit(editor); }
			}
		}
		editor.onAfterDelete = (_: *NodesScene){ endTest(); };
		editorStart(editor);

	});
}


#scope_file

_meshesCount :: (networkPanel: *NetworkPanel)->u64{
	meshesCount :u64= 0;
	for pc: networkPanel.rendererColor.pipelines_by_mat_type { meshesCount += xx pc.drawDatas.count; }
	return meshesCount;
}
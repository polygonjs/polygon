testViewerPanel :: () {
	
	testHeadlessNoSceneOrEditor("ViewerPanel update renderer", (options:TestProcedureOptions) {
		// nodesScene := *app.nodesScene;

		_nodesScene :NodesScene;
		options.app.nodesScene = _nodesScene;
		nodesScene :*NodesScene= *options.app.nodesScene;
		nodesSceneInit(nodesScene);
		box1 := createNode(nodesScene, BoxGeoNode);
		line1 := createNode(nodesScene, LineGeoNode);
		output1 := createNode(nodesScene, OutputGeoNode);
		setInput(output1, 0, box1);
		setInput(output1, 1, line1);
		paramSetValue(*output1.p.input, xx 0);

		_editor :Editor;
		options.app.editor = _editor;
		editor :*Editor= *options.app.editor;
		editor.wgpuContext = options.testApp.headlessWGPUContext;
		editorInit(editor, ensureWGPUContextValid=false);
		editorSetScene(editor, nodesScene);

		editor.onAfterTick = (using editor: *Editor) {
			if nodesScene.framesCount == {
				case 1; {
					#if HAS_VIEWER_PANEL {
						assertEqual(viewerPanel.renderer.pipelines_by_mat_type.count, 1, "1 pipeline in renderer");
						meshesCount := 0;
						for pc: viewerPanel.renderer.pipelines_by_mat_type { meshesCount += pc.drawDatas.count; }
						assertEqual(meshesCount, 1, "1 mesh");
					}
				}
				case 2; { output1 := sceneFindNodeByType (editor.nodesScene, OutputGeoNode); paramSetValue(*output1.p.input, xx 1); }
				case 3; { }
				case 4; { editorRequestExit(editor); }
			}
		};

		editor.onAfterDelete = (nodesScene: *NodesScene){
			nodesSceneReset(nodesScene);
			assertLeaksCount(0, "no leak when deleting a scene with 4 nodes");

			endTest();
		};

		editorStart(editor);
	});
}

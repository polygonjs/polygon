testViewerPanel :: () {
	
	testHeadlessNoSceneOrEditor("ViewerPanel update renderer", (options:TestProcedureOptions) {
		nodesScene := newNodesScene();
		box1 := createNode(nodesScene, BoxGeoNode);
		line1 := createNode(nodesScene, LineGeoNode);
		output1 := createNode(nodesScene, OutputGeoNode);
		setInput(output1, 0, box1);
		setInput(output1, 1, line1);
		paramSetValue(*output1.p.input, xx 0);

		editor := newEditor();
		editorSetScene(editor, nodesScene);


		editor.onAfterTick = (using editor: *Editor) {
			if nodesScene.framesCount == {
				case 1; {
					assertEqual(viewerPanel.renderer.pipelines_by_mat_type.count, 1);
					meshesCount := 0;
					for pc: viewerPanel.renderer.pipelines_by_mat_type { meshesCount += pc.meshes.count; }
					assertEqual(meshesCount, 1);
				}
				case 2; { output1 := sceneFindNodeByType (editor.nodesScene, OutputGeoNode); paramSetValue(*output1.p.input, xx 1); }
				case 3; { }
				case 4; { editorRequestExit(editor); }
			}
		};

		editorStart(editor, options.window_size);
		sceneDelete(nodesScene);
		assertLeaksCount(0, "no leak when deleting a scene with 4 nodes");
	});
}

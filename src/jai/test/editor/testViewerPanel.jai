testViewerPanel :: () {
	
	testHeadless("ViewerPanel update renderer", (options:TestProcedureOptions) {
		nodesScene := newNodesScene();
		box1 := createNode(nodesScene, BoxGeoNode);
		icosahedron1 := createNode(nodesScene, IcosahedronGeoNode);
		output1 := createNode(nodesScene, OutputGeoNode);
		setInput(output1, 0, box1);
		setInput(output1, 1, icosahedron1);
		paramSetValue(*output1.p.input, cast(u8) 0);

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
				case 2; { editorRequestExit(editor); }
			}
		};

		editorStart(editor, options.window_size);
		sceneDelete(nodesScene);
		assertLeaksCount(0, "no leak when deleting a scene with 4 nodes");
	});
}

testEditor :: () {
	testWithWindow("Editor empty", (options:TestProcedureOptions) {
		nodesScene := newNodesScene();
		editor := newEditor();
		editorSetScene(editor, nodesScene);

		editor.onAfterTick = (editor: *Editor) {
			if editor.nodesScene.framesCount > 2 {
				editorRequestExit(editor);
			}
		};

		editorStart(editor, options.window_size);
		sceneDelete(nodesScene);
		reset_temporary_storage();
		assertLeaksCount(0, "no leaks when closing an empty editor");
	});

	testWithWindow("Editor with minimal scene", (options:TestProcedureOptions) {
		nodesScene := newNodesScene();
		editor := newEditor();
		editorSetScene(editor, nodesScene);

		sceneInit :: (nodesScene: *NodesScene, editor: *Editor) {
			box1 := createNode(nodesScene, BoxGeoNode);
			assert(graphNodeScene(box1)!=null, "scene can be found from node");
			output1 := createNode(nodesScene, OutputGeoNode);
			setInput(output1, 0, box1);

			nodeSetPosition(editor, box1, .{2,3});
			nodeSetPosition(editor, output1, .{0,-2});

			icosahedron1 := createNode(nodesScene, IcosahedronGeoNode);
			nodeSetPosition(editor, icosahedron1, .{-2,1});
			// paramSetValue(*box1.p.scale, 1.0);

			editorFlushCommands(editor);
		}

		sceneInit(nodesScene, editor);
		editor.onAfterTick = (editor: *Editor) {
			if editor.nodesScene.framesCount > 2 {
				editorRequestExit(editor);
			}
		};

		editorStart(editor, options.window_size);
		sceneDelete(nodesScene);
		reset_temporary_storage();
		assertLeaksCount(0, "no leaks when closing an empty editor");
	});
}

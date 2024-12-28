testEditor :: () {
	testHeadless("Editor empty", (using options:TestProcedureOptions) {
		editor.onAfterTick = (using editor: *Editor) {
			if nodesScene.framesCount > 2 {
				editorRequestExit(editor);
			}
		};

		editor.onAfterDelete = (_: *NodesScene){ endTest(); };
		editorStart(editor);
	});

	testHeadless("Editor with minimal scene", (using options:TestProcedureOptions) {
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
		editor.onAfterTick = (using editor: *Editor) {
			if nodesScene.framesCount > 2 {
				editorRequestExit(editor);
			}
		};

		editor.onAfterDelete = (_: *NodesScene){ endTest(); };
		editorStart(editor);
	});
}

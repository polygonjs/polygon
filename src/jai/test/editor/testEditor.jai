testEditor :: () {
	test("Editor empty", () {
		nodesScene := newNodesScene();
		editor := newEditor();
		editorSetScene(editor, nodesScene);

		editor.onAfterTick = (editor: *Editor) {
			print("Editor empty onAfterTick:%, %\n", editor.nodesScene.time, editor.nodesScene.framesCount);
			if editor.nodesScene.framesCount > 2 {
				editorRequestExit(editor);
				sceneDelete(editor.nodesScene);
			}
		};

		#if WASM==false {
			window_size := windowInit();
			editorNativeStart(editor, window_size);
		}

		reset_temporary_storage();
		assertLeaksCount(0, "no leaks when closing an empty editor");
	});

	// test("Editor with minimal scene", () {
	// 	nodesScene := newNodesScene();
	// 	editor := newEditor();
	// 	editorSetScene(editor, nodesScene);

	// 	//
	// 	box1 := createNode(nodesScene, BoxGeoNode);
	// 	assert(graphNodeScene(box1)!=null, "scene can be found from node");
	// 	output1 := createNode(nodesScene, OutputGeoNode);
	// 	setInput(output1, 0, box1);

	// 	nodeSetPosition(editor, box1, .{2,3});
	// 	nodeSetPosition(editor, output1, .{0,-2});

	// 	icosahedron1 := createNode(nodesScene, IcosahedronGeoNode);
	// 	nodeSetPosition(editor, icosahedron1, .{-2,1});


	// 	// paramSetValue(*box1.p.scale, 1.0);

	// 	//
	// 	editorFlushCommands(editor);
	// 	//

	// 	editor.onAfterTick = (editor: *Editor) {
	// 		print("Editor with minimal scene onAfterTick:%, %\n", editor.nodesScene.time, editor.nodesScene.framesCount);
	// 		if editor.nodesScene.framesCount > 2 {
	// 			editorRequestExit(editor);
	// 			sceneDelete(editor.nodesScene);
	// 		}
	// 	};

	// 	#if WASM==false {
	// 		window_size := windowInit();
	// 		editorNativeStart(editor, window_size);
	// 	}

	// 	reset_temporary_storage();
	// 	assertLeaksCount(0, "no leaks when closing an empty editor");
	// });
}

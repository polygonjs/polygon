
appSceneInit5 :: (nodesScene: *NodesScene, editor: *Editor) {

	plane1 := createNode(nodesScene, PlaneGeoNode);
	text1 := createNode(nodesScene, TextGeoNode);
	output1 := createNode(nodesScene, OutputGeoNode);

	paramSetValue(*text1.p.text, "Polygon");

	setInput(output1, 0, plane1);
	setInput(output1, 1, text1);


	paramSetValue(*output1.p.input, 1);

	nodeSetPosition(editor, output1, .{0,-4});

	nodeSetPosition(editor, plane1, .{-2,4});
	nodeSetPosition(editor, text1, .{2,2});


	setTexture(*nodesScene.defaultMaterial.basicTexture, *FONT_TEXTURE);

	editorFlushCommands(editor);
}

#scope_file

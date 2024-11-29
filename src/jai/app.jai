
appInit :: (nodesScene: *NodesScene, editor: *Editor) {

	add1 := createNode(nodesScene, AddGeoNode);
	box1 := createNode(nodesScene, BoxGeoNode);
	line1 := createNode(nodesScene, LineGeoNode);
	icosahedron1 := createNode(nodesScene, IcosahedronGeoNode);
	assert(graphNodeScene(box1)!=null, "scene can be found from node");
	output1 := createNode(nodesScene, OutputGeoNode);



	setInput(output1, 0, add1);
	setInput(output1, 1, box1);
	setInput(output1, 2, line1);
	setInput(output1, 3, icosahedron1);


	paramSetValue(*box1.p.scale, 2.0);
	paramSetValue(*output1.p.input, 3);

	nodeSetPosition(editor, output1, .{0,-2});

	nodeSetPosition(editor, add1, .{-4,2});
	nodeSetPosition(editor, box1, .{-2,2});
	nodeSetPosition(editor, icosahedron1, .{0,2});
	nodeSetPosition(editor, line1, .{2,2});
	//
	editorFlushCommands(editor);
}


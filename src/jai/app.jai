
appInit :: (nodesScene: *NodesScene, editor: *Editor) {

	box1 := createNode(nodesScene, BoxGeoNode);
	assert(graphNodeScene(box1)!=null, "scene can be found from node");
	output1 := createNode(nodesScene, OutputGeoNode);
	setInput(output1, 0, box1);

	nodeSetPosition(editor, box1, .{2,3});
	nodeSetPosition(editor, output1, .{0,-2});

	icosahedron1 := createNode(nodesScene, IcosahedronGeoNode);
	nodeSetPosition(editor, icosahedron1, .{-2,1});
	setInput(output1, 1, icosahedron1);


	paramSetValue(*box1.p.scale, 2.0);
	paramSetValue(*output1.p.input, 1);

	//
	editorFlushCommands(editor);
}



appInit :: (nodesScene: *NodesScene, editor: *Editor) {

	box1 := newNode(nodesScene, BoxGeoNode);
	assert(graphNodeScene(box1)!=null, "scene can be found from node");
	output1 := newNode(nodesScene, OutputGeoNode);
	setInput(output1, 0, box1);

	nodeSetPosition(editor, box1, .{2,3});
	nodeSetPosition(editor, output1, .{0,-2});

	icosahedron1 := newNode(nodesScene, IcosahedronGeoNode);
	nodeSetPosition(editor, icosahedron1, .{-2,1});


	paramSetValue(*box1.p.scale, 1.0);

	//
	editorFlushCommands(editor);
}


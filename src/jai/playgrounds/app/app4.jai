

appSceneInit4 :: (nodesScene: *NodesScene, editor: *Editor) {

	output1 := createNode(nodesScene, OutputGeoNode);
	switch1 := createNode(nodesScene, SwitchGeoNode);
	box1 := createNode(nodesScene, BoxGeoNode);
	icosahedron1 := createNode(nodesScene, IcosahedronGeoNode);

	setInput(output1, 0, switch1);
	setInput(switch1, 0, box1);
	setInput(switch1, 1, icosahedron1);

	nodeSetPosition(editor, output1, .{0,-4});
	nodeSetPosition(editor, switch1, .{0,-2});
	nodeSetPosition(editor, box1, .{-2,0});
	nodeSetPosition(editor, icosahedron1, .{2,0});

	editorFlushCommands(editor);
}
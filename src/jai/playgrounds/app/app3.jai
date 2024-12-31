

appSceneInit3 :: (nodesScene: *NodesScene, editor: *Editor) {

	output1 := createNode(nodesScene, OutputGeoNode);
	box1 := createNode(nodesScene, BoxGeoNode);
	noise1 := createNode(nodesScene, NoiseGeoNode);

	setInput(output1, 0, noise1);
	setInput(noise1, 0, box1);

	nodeSetPosition(editor, output1, .{0,-4});
	nodeSetPosition(editor, noise1, .{0,-2});
	nodeSetPosition(editor, box1, .{0,0});

	editorFlushCommands(editor);
}

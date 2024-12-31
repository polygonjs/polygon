
appSceneInit2 :: (nodesScene: *NodesScene, editor: *Editor) {

	output1 := createNode(nodesScene, OutputGeoNode);

	nodeSetPosition(editor, output1, .{0,-4});

	editorFlushCommands(editor);
}

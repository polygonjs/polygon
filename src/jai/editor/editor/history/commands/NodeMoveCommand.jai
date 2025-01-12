
NodeMoveCommand :: struct {
	items: [..]NodeMoveCommandItem;
}
NodeMoveCommandItem :: struct {
	nodeId: NodeId;
	startPos: Vector2;
	endPos: Vector2;
}

newNodeMoveCommand :: (editor: *Editor, items: []NodeMoveCommandItem, $push:bool)->*NodeMoveCommand {
	if items.count == 0 {return null;}
	
	push_allocator(editor.allocator);
	cmd := New(NodeMoveCommand);
	cmd.items.allocator = editor.allocator;
	cmd.items.count = items.count;
	maybe_grow(*cmd.items);
	for item, i: items {
		cmd.items[i] = item;
	}

	#if push pushCommand(editor, cmd);

	return cmd;
}



commandDo :: (editor: *Editor, cmd: NodeMoveCommand) {
	for item: cmd.items {
		editor.sceneUiData.nodePositions[item.nodeId] = item.endPos;

		node := editor.nodesScene.nodes[item.nodeId];
		onNodeSetPosition(editor, editor.nodesScene, node, item.endPos);
	}
}

commandUndo :: (editor: *Editor, cmd: NodeMoveCommand) {
	for item: cmd.items {
		editor.sceneUiData.nodePositions[item.nodeId] = item.startPos;

		node := editor.nodesScene.nodes[item.nodeId];
		onNodeSetPosition(editor, editor.nodesScene, node, item.startPos);
	}
}
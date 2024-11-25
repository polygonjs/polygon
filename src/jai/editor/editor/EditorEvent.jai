
onNodeAdded :: (editor: *Editor, scene: *NodesScene, node: *$T) {
	array_add(*editor.commands.nodeAdd, .{node=xx node});
}
onNodeBeforeRemove :: (editor: *Editor, scene: *NodesScene, node: *$T) {
	array_add(*editor.commands.nodeBeforeRemove, .{node=xx node});
}
onNodeSetPosition :: (editor: *Editor, scene: *NodesScene, node: *$T, position:Vector2) {
	array_add(*editor.commands.nodeSetPosition, .{node=xx node, position=position});
}
onNodeInputAdded :: (editor: *Editor, scene: *NodesScene, node: *$T, inputIndex: u8) {
	// print("onNodeInputAdded % %\n", node, inputIndex);
}
onNodeInputRemoved :: (editor: *Editor, scene: *NodesScene, node: *$T, inputIndex: u8) {
	// print("onNodeInputRemoved % %\n", node, inputIndex);
}

editorFlushCommands :: (editor: *Editor) {
	using editor.commands;
	doEditorNodeAddCommands(editor, nodeAdd);
	doEditorNodeBeforeRemoveCommands(editor, nodeBeforeRemove);
	doEditorNodeSetPositionCommands(editor, nodeSetPosition);
	doEditorNodeInputAddCommands(editor, nodeInputAdd);
	doEditorNodeInputRemoveCommands(editor, nodeInputRemove);

	nodeAdd.count = 0;
	nodeBeforeRemove.count = 0;
	nodeSetPosition.count = 0;
	nodeInputAdd.count = 0;
	nodeInputRemove.count = 0;
}
editorCommandsDelete :: (using commands: *EditorCommands) {
	array_reset(*nodeAdd);
	array_reset(*nodeBeforeRemove);
	array_reset(*nodeSetPosition);
	array_reset(*nodeInputAdd);
	array_reset(*nodeInputRemove);
}

EditorCommands :: struct {
	nodeAdd :[..]EditorNodeAddCommand;
	nodeBeforeRemove :[..]EditorNodeBeforeRemoveCommand;
	nodeSetPosition :[..]EditorNodeSetPositionCommand;
	nodeInputAdd :[..]EditorNodeInputAddCommand;
	nodeInputRemove :[..]EditorNodeInputRemoveCommand;
}

#scope_file

EditorEvent :: enum u8 {
	NODE_ADDED :: 0;
	NODE_BEFORE_REMOVE;
	NODE_SET_POSITION;
	NODE_INPUT_ADDED;
	NODE_INPUT_REMOVED;
}

EditorNodeAddCommand :: struct {
	node: *BaseNodeAny;
}
EditorNodeBeforeRemoveCommand :: struct {
	node: *BaseNodeAny;
}
EditorNodeSetPositionCommand :: struct {
	node: *BaseNodeAny;
	position: Vector2;
}
EditorNodeInputAddCommand :: struct {
	node: *BaseNodeAny;
	inputIndex: u8;
}
EditorNodeInputRemoveCommand :: struct {
	node: *BaseNodeAny;
	inputIndex: u8;
}




doEditorNodeAddCommands :: (editor: *Editor, commands: [..]EditorNodeAddCommand) {
	using editor.sceneUiData;

	for cmd: commands {
		node := cmd.node;
		if nodePositions.count <= node.nodeId {
			array_resize(*nodePositions, node.nodeId + 1);
		}
		nodePositions[node.nodeId] = .{0, 0};

		#if HAS_NETWORK_PANEL networkPanelAddNode(editor.networkPanel, node);
	}
}
doEditorNodeBeforeRemoveCommands :: (editor: *Editor, commands: [..]EditorNodeBeforeRemoveCommand) {
	using editor.sceneUiData;
	for cmd: commands {
		node := cmd.node;
		nodePositions[node.nodeId] = .{-1000000,-1000000};

		#if HAS_NETWORK_PANEL networkPanelRemoveNode(editor.networkPanel, node);
	}
}
doEditorNodeSetPositionCommands :: (editor: *Editor, commands: [..]EditorNodeSetPositionCommand) {
	using editor.sceneUiData;
	for cmd: commands {
		node := cmd.node;
		nodePositions[node.nodeId] = cmd.position;

		#if HAS_NETWORK_PANEL networkPanelNodeSetPosition(editor.networkPanel, node, cmd.position);
	}
}
doEditorNodeInputAddCommands :: (editor: *Editor, commands: [..]EditorNodeInputAddCommand) {

}
doEditorNodeInputRemoveCommands :: (editor: *Editor, commands: [..]EditorNodeInputRemoveCommand) {

}
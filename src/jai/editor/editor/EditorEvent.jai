
onNodeAdded :: (editor: *Editor, scene: *NodesScene, node: *$T) {
	array_add(*EDITOR_NODE_ADD_COMMANDS, .{node=xx node});
}
onNodeBeforeRemove :: (editor: *Editor, scene: *NodesScene, node: *$T) {
	array_add(*EDITOR_NODE_REMOVE_COMMANDS, .{node=xx node});
}
onNodeSetPosition :: (editor: *Editor, scene: *NodesScene, node: *$T, position:Vector2) {
	array_add(*EDITOR_NODE_SET_POSITION_COMMANDS, .{node=xx node, position=position});
}
onNodeInputAdded :: (editor: *Editor, scene: *NodesScene, node: *$T, inputIndex: u8) {
	// print("onNodeInputAdded % %\n", node, inputIndex);
}
onNodeInputRemoved :: (editor: *Editor, scene: *NodesScene, node: *$T, inputIndex: u8) {
	// print("onNodeInputRemoved % %\n", node, inputIndex);
}

editorFlushCommands :: (editor: *Editor) {
	doEditorNodeAddCommands(editor, *EDITOR_NODE_ADD_COMMANDS);
	doEditorNodeRemoveCommands(editor, *EDITOR_NODE_REMOVE_COMMANDS);
	doEditorNodeSetPositionCommands(editor, *EDITOR_NODE_SET_POSITION_COMMANDS);
	doEditorNodeInputAddCommands(editor, *EDITOR_NODE_INPUT_ADD_COMMANDS);
	doEditorNodeInputRemoveCommands(editor, *EDITOR_NODE_INPUT_REMOVE_COMMANDS);

	EDITOR_NODE_ADD_COMMANDS.count = 0;
	EDITOR_NODE_REMOVE_COMMANDS.count = 0;
	EDITOR_NODE_SET_POSITION_COMMANDS.count = 0;
	EDITOR_NODE_INPUT_ADD_COMMANDS.count = 0;
	EDITOR_NODE_INPUT_REMOVE_COMMANDS.count = 0;
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
EditorNodeRemoveCommand :: struct {
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

EDITOR_NODE_ADD_COMMANDS :[..]EditorNodeAddCommand;
EDITOR_NODE_REMOVE_COMMANDS :[..]EditorNodeRemoveCommand;
EDITOR_NODE_SET_POSITION_COMMANDS :[..]EditorNodeSetPositionCommand;
EDITOR_NODE_INPUT_ADD_COMMANDS :[..]EditorNodeInputAddCommand;
EDITOR_NODE_INPUT_REMOVE_COMMANDS :[..]EditorNodeInputRemoveCommand;

doEditorNodeAddCommands :: (editor: *Editor, commands: *[..]EditorNodeAddCommand) {
	using editor.sceneUiData;

	for cmd: EDITOR_NODE_ADD_COMMANDS {
		node := cmd.node;
		if nodePositions.count <= node.nodeId {
			array_resize(*nodePositions, node.nodeId + 1);
		}
		nodePositions[node.nodeId] = .{0, 0};

		networkPanelAddNode(editor.networkPanel, node);
	}
}
doEditorNodeRemoveCommands :: (editor: *Editor, commands: *[..]EditorNodeRemoveCommand) {
	using editor.sceneUiData;
	for cmd: EDITOR_NODE_REMOVE_COMMANDS {
		node := cmd.node;
		nodePositions[node.nodeId] = .{-1000000,-1000000};

		networkPanelRemoveNode(editor.networkPanel, node);
	}
}
doEditorNodeSetPositionCommands :: (editor: *Editor, commands: *[..]EditorNodeSetPositionCommand) {
	using editor.sceneUiData;
	for cmd: EDITOR_NODE_SET_POSITION_COMMANDS {
		node := cmd.node;
		nodePositions[node.nodeId] = cmd.position;

		networkPanelNodeSetPosition(editor.networkPanel, node, cmd.position);
	}
}
doEditorNodeInputAddCommands :: (editor: *Editor, commands: *[..]EditorNodeInputAddCommand) {

}
doEditorNodeInputRemoveCommands :: (editor: *Editor, commands: *[..]EditorNodeInputRemoveCommand) {

}
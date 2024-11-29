
onNodeAdded :: (editor: *Editor, scene: *NodesScene, node: *$T) {
	array_add(*editor.commands.nodeAdded, .{node=xx node});
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
onNodeSelectionAdded :: (editor: *Editor, scene: *NodesScene, node: *$T) {
	array_add(*editor.commands.nodeSelectionAdded, .{node=xx node});
}
onNodeSelectionRemoved :: (editor: *Editor, scene: *NodesScene, node: *$T) {
	array_add(*editor.commands.nodeSelectionRemoved, .{node=xx node});
}

editorFlushCommands :: (editor: *Editor) {
	using editor.commands;
	doEditorNodeAddCommands(editor, nodeAdded);
	doEditorNodeBeforeRemoveCommands(editor, nodeBeforeRemove);
	doEditorNodeSetPositionCommands(editor, nodeSetPosition);
	doEditorNodeInputAddCommands(editor, nodeInputAdd);
	doEditorNodeInputRemoveCommands(editor, nodeInputRemove);
	doEditorNodeSelectionAddedCommands(editor, nodeSelectionAdded);
	doEditorNodeSelectionRemovedCommands(editor, nodeSelectionRemoved);

	nodeAdded.count = 0;
	nodeBeforeRemove.count = 0;
	nodeSetPosition.count = 0;
	nodeInputAdd.count = 0;
	nodeInputRemove.count = 0;
	nodeSelectionAdded.count = 0;
	nodeSelectionRemoved.count = 0;
}
editorCommandsSetAllocator :: (editor: *Editor) {
	using editor.commands;
	nodeAdded.allocator = editor.allocator;
	nodeBeforeRemove.allocator = editor.allocator;
	nodeSetPosition.allocator = editor.allocator;
	nodeInputAdd.allocator = editor.allocator;
	nodeInputRemove.allocator = editor.allocator;
	nodeSelectionAdded.allocator = editor.allocator;
	nodeSelectionRemoved.allocator = editor.allocator;
}


EditorCommands :: struct {
	nodeAdded :[..]EditorNodeAddCommand;
	nodeBeforeRemove :[..]EditorNodeBeforeRemoveCommand;
	nodeSetPosition :[..]EditorNodeSetPositionCommand;
	nodeInputAdd :[..]EditorNodeInputAddCommand;
	nodeInputRemove :[..]EditorNodeInputRemoveCommand;
	nodeSelectionAdded :[..]EditorNodeSelectionAddedCommand;
	nodeSelectionRemoved :[..]EditorNodeSelectionRemovedCommand;
}

#scope_file

EditorEvent :: enum u8 {
	NODE_ADDED :: 0;
	NODE_BEFORE_REMOVE;
	NODE_SET_POSITION;
	NODE_INPUT_ADDED;
	NODE_INPUT_REMOVED;
}

NodeCommand :: struct {
	node: *BaseNodeAny;
}
NodeInputCommand :: struct {
	node: *BaseNodeAny;
	inputIndex: u8;
}
EditorNodeAddCommand :: NodeCommand;
EditorNodeBeforeRemoveCommand :: NodeCommand;
EditorNodeSetPositionCommand :: struct {
	node: *BaseNodeAny;
	position: Vector2;
}
EditorNodeInputAddCommand :: NodeInputCommand;
EditorNodeInputRemoveCommand :: NodeInputCommand;
EditorNodeSelectionAddedCommand :: NodeCommand;
EditorNodeSelectionRemovedCommand :: NodeCommand;




doEditorNodeAddCommands :: (editor: *Editor, commands: [..]EditorNodeAddCommand) {
	using editor.sceneUiData;

	for cmd: commands {
		node := cmd.node;
		array_insert_at(*nodePositions, .{0, 0}, node.nodeId);

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
doEditorNodeSelectionAddedCommands :: (editor: *Editor, commands: [..]EditorNodeSelectionAddedCommand) {
	for cmd: commands {
		networkPanelOnNodeSelectionAdded(editor.networkPanel, cmd.node);
	}
}
doEditorNodeSelectionRemovedCommands :: (editor: *Editor, commands: [..]EditorNodeSelectionRemovedCommand) {
	for cmd: commands {
		networkPanelOnNodeSelectionRemoved(editor.networkPanel, cmd.node);
	}
}

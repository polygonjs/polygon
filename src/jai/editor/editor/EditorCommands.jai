onNodeBeforeRemove :: (editor: *Editor, scene: *NodesScene, node: *$T) {
	array_add(*editor.commands.nodeBeforeRemove, .{node=xx node});
}
onNodeAdded :: (editor: *Editor, scene: *NodesScene, node: *$T) {
	array_add(*editor.commands.nodeAdded, .{node=xx node});
}
onNodeSetPosition :: (editor: *Editor, scene: *NodesScene, node: *$T, position:Vector2) {
	array_add(*editor.commands.nodeSetPosition, .{node=xx node, position=position});
}
onNodeConnectionRemoved :: (editor: *Editor, scene: *NodesScene, connection: NodeConnection) {
	array_add(*editor.commands.nodeConnectionRemoved, .{connection=connection});
}
onNodeConnectionAdded :: (editor: *Editor, scene: *NodesScene, connection: NodeConnection) {
	array_add(*editor.commands.nodeConnectionAdded, .{connection=connection});
}
onNodeSelectionAdded :: (editor: *Editor, scene: *NodesScene, node: *$T) {
	array_add(*editor.commands.nodeSelectionAdded, .{node=xx node});
}
onNodeSelectionRemoved :: (editor: *Editor, scene: *NodesScene, node: *$T) {
	array_add(*editor.commands.nodeSelectionRemoved, .{node=xx node});
}

editorFlushCommands :: (editor: *Editor) {
	using editor.commands;
	// node
	doEditorNodeBeforeRemoveCommands(editor, nodeBeforeRemove);
	doEditorNodeAddCommands(editor, nodeAdded);
	// node position
	doEditorNodeSetPositionCommands(editor, nodeSetPosition);
	// node connections
	doEditorNodeConnectionRemovedCommands(editor, nodeConnectionRemoved);
	doEditorNodeConnectionAddedCommands(editor, nodeConnectionAdded);
	// selection
	doEditorNodeSelectionRemovedCommands(editor, nodeSelectionRemoved);
	doEditorNodeSelectionAddedCommands(editor, nodeSelectionAdded);

	nodeBeforeRemove.count = 0;
	nodeAdded.count = 0;
	nodeSetPosition.count = 0;
	nodeConnectionRemoved.count = 0;
	nodeConnectionAdded.count = 0;
	nodeSelectionAdded.count = 0;
	nodeSelectionRemoved.count = 0;
}
editorCommandsSetAllocator :: (editor: *Editor) {
	using editor.commands;
	nodeAdded.allocator = editor.allocator;
	nodeBeforeRemove.allocator = editor.allocator;
	nodeSetPosition.allocator = editor.allocator;
	nodeConnectionAdded.allocator = editor.allocator;
	nodeConnectionRemoved.allocator = editor.allocator;
	nodeSelectionAdded.allocator = editor.allocator;
	nodeSelectionRemoved.allocator = editor.allocator;
}


EditorCommands :: struct {
	nodeAdded :[..]EditorNodeAddCommand;
	nodeBeforeRemove :[..]EditorNodeBeforeRemoveCommand;
	nodeSetPosition :[..]EditorNodeSetPositionCommand;
	nodeConnectionAdded :[..]EditorNodeConnectionAddedCommand;
	nodeConnectionRemoved :[..]EditorNodeConnectionRemovedCommand;
	nodeSelectionAdded :[..]EditorNodeSelectionAddedCommand;
	nodeSelectionRemoved :[..]EditorNodeSelectionRemovedCommand;
}

#scope_file

EditorEvent :: enum u8 {
	NODE_ADDED :: 0;
	NODE_BEFORE_REMOVE;
	NODE_SET_POSITION;
	NODE_CONNECTION_ADDED;
	NODE_CONNECTION_REMOVED;
}

NodeCommand :: struct {
	node: *BaseNodeAny;
}
NodeConnectionCommand :: struct {
	connection: NodeConnection;
}
EditorNodeAddCommand :: NodeCommand;
EditorNodeBeforeRemoveCommand :: NodeCommand;
EditorNodeSetPositionCommand :: struct {
	node: *BaseNodeAny;
	position: Vector2;
}
EditorNodeConnectionAddedCommand :: NodeConnectionCommand;
EditorNodeConnectionRemovedCommand :: NodeConnectionCommand;
EditorNodeSelectionAddedCommand :: NodeCommand;
EditorNodeSelectionRemovedCommand :: NodeCommand;



// node add/remove
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
// node positions
doEditorNodeSetPositionCommands :: (editor: *Editor, commands: [..]EditorNodeSetPositionCommand) {
	using editor.sceneUiData;
	for cmd: commands {
		node := cmd.node;
		nodePositions[node.nodeId] = cmd.position;

		#if HAS_NETWORK_PANEL networkPanelNodeSetPosition(editor.networkPanel, node, cmd.position);
	}
}
// node connections
doEditorNodeConnectionRemovedCommands :: (editor: *Editor, commands: [..]EditorNodeConnectionRemovedCommand) {
	for cmd: commands {
		#if HAS_NETWORK_PANEL networkPanelRemoveNodeConnection(editor.networkPanel, cmd.connection);
	}
}
doEditorNodeConnectionAddedCommands :: (editor: *Editor, commands: [..]EditorNodeConnectionAddedCommand) {
	for cmd: commands {
		#if HAS_NETWORK_PANEL networkPanelAddNodeConnection(editor.networkPanel, cmd.connection);
	}
}
// node selection
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

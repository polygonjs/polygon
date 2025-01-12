NodeSelectionMode :: enum u8 {
	REPLACE :: 0;
	ADD;
	REMOVE;
}

NodeSelectCommand :: struct {
	removedNodeIds: [..]NodeId;
	addedNodeIds: [..]NodeId;
}

newNodeSelectCommand :: (editor: *Editor, nodeIds:[]NodeId, mode:NodeSelectionMode=.REPLACE, $push:bool=true)->*TYPE {
	if nodeIds.count == 0 {return null;}

	push_allocator(editor.allocator);
	cmd: *TYPE=null;
	if #complete mode == {
		case .REPLACE; {
			cmd = _replaceWithNodes(editor, nodeIds);
		}
		case .ADD; {
			cmd = _addNode(editor, nodeIds);
		}
		case .REMOVE; {
			cmd = _removeNode(editor, nodeIds);
		}
	}

	if(cmd==null) {
		#if push == false {
			assert(false, "if push is false, we are probably creating a multi-command. If we don't have a new NodeSelectCommand (probably because the input is incorrect), we may want to avoid that in the first place");
		}
		return null;
	}
	#if push pushCommand(editor, cmd);
	return cmd;
}

commandDo :: (editor: *Editor, cmd: TYPE) {
	_process(editor, cmd, do=true);
}

commandUndo :: (editor: *Editor, cmd: TYPE) {
	_process(editor, cmd, do=false);
}

#scope_file

TYPE :: NodeSelectCommand;

_process :: (editor:*Editor, cmd:TYPE, $do:bool) {
	#if do == true {
		removedNodeIds := cmd.removedNodeIds;
		addedNodeIds := cmd.addedNodeIds;
	} else {
		removedNodeIds := cmd.addedNodeIds;
		addedNodeIds := cmd.removedNodeIds;
	}

	for nodeId: removedNodeIds {
		array_unordered_remove_by_value(*editor.sceneUiData.selectedNodeIds, nodeId, stop_after_first=true);
	}
	for nodeId: addedNodeIds {
		array_add(*editor.sceneUiData.selectedNodeIds, nodeId);
	}
	// emit events
	for nodeId: removedNodeIds {
		node := editor.nodesScene.nodes[nodeId];
		onNodeSelectionRemoved(editor, editor.nodesScene, node);
	}
	for nodeId: addedNodeIds {
		node := editor.nodesScene.nodes[nodeId];
		onNodeSelectionAdded(editor, editor.nodesScene, node);
	}
}

_nodeSelectCommandCreate :: (editor:*Editor)->*TYPE {
	push_allocator(editor.allocator);
	cmd := New(TYPE);
	cmd.removedNodeIds.allocator = editor.allocator;
	cmd.addedNodeIds.allocator = editor.allocator;
	return cmd;
}

_replaceWithNodes :: (editor: *Editor, nodeIds: []NodeId)->*TYPE {
	nodeId := nodeIds[0];
	found, index := array_find(editor.sceneUiData.selectedNodeIds, nodeId);
	if found == true { return null; }

	cmd := _nodeSelectCommandCreate(editor);

	for selectNodeId: editor.sceneUiData.selectedNodeIds {
		array_add(*cmd.removedNodeIds, selectNodeId);
	}
	array_add(*cmd.addedNodeIds, nodeId);
	return cmd;

}
_addNode :: (editor: *Editor, nodeIds: []NodeId)->*TYPE {
	nodeId := nodeIds[0];
	found, index := array_find(editor.sceneUiData.selectedNodeIds, nodeId);
	if found == true { return null; }

	cmd := _nodeSelectCommandCreate(editor);
	array_add(*cmd.addedNodeIds, nodeId);
	return cmd;
}
_removeNode :: (editor: *Editor, nodeIds: []NodeId)->*TYPE {
	nodeId := nodeIds[0];
	found, index := array_find(editor.sceneUiData.selectedNodeIds, nodeId);
	if found == false { return null; }

	cmd := _nodeSelectCommandCreate(editor);
	array_add(*cmd.removedNodeIds, nodeId);
	return cmd;
}
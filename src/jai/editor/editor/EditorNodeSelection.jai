NodeSelectionMode :: enum u8 {
	REPLACE :: 0;
	ADD;
	REMOVE;
}

selectNode :: (editor: *Editor, node: *BaseNodeAny, mode:NodeSelectionMode=.REPLACE) {
	using editor.sceneUiData;
	if mode == {
		case .REPLACE; {
			for nodeId: selectedNodeIds { onNodeSelectionRemoved(editor, editor.nodesScene, editor.nodesScene.nodes[nodeId]); }
			selectedNodeIds.count = 0;
			array_add(*selectedNodeIds, node.nodeId);
			onNodeSelectionAdded(editor, editor.nodesScene, node);
		}
		case .ADD; {
			array_add(*selectedNodeIds, node.nodeId);
			onNodeSelectionAdded(editor, editor.nodesScene, node);
		}
		case .REMOVE; {
			deselectNode(editor, node);
		}
	}
}
deselectNode :: (editor: *Editor, node: *BaseNodeAny) {
	array_unordered_remove_by_value(*editor.sceneUiData.selectedNodeIds, node.nodeId);
	onNodeSelectionRemoved(editor, editor.nodesScene, node);
}
isNodeSelected :: (editor: *Editor, nodeId: NodeId)->bool {
	return array_find(editor.sceneUiData.selectedNodeIds, nodeId);
}
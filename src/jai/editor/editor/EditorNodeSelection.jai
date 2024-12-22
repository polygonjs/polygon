NodeSelectionMode :: enum u8 {
	REPLACE :: 0;
	ADD;
	REMOVE;
}

selectNode :: (editor: *Editor, node: *BaseNodeAny, mode:NodeSelectionMode=.REPLACE) {
	if #complete mode == {
		case .REPLACE; {
			_replaceNode(editor, node);
		}
		case .ADD; {
			_selectNode(editor, node);
		}
		case .REMOVE; {
			deselectNode(editor, node);
		}
	}
}
_replaceNode :: (editor: *Editor, node: *BaseNodeAny) {
	found, index := array_find(editor.sceneUiData.selectedNodeIds, node.nodeId);
	if found == true { return; }

	using editor.sceneUiData;
	for nodeId: selectedNodeIds { onNodeSelectionRemoved(editor, editor.nodesScene, editor.nodesScene.nodes[nodeId]); }
	selectedNodeIds.count = 0;
	_selectNode(editor, node);
}
_selectNode :: (editor: *Editor, node: *BaseNodeAny) {
	found, index := array_find(editor.sceneUiData.selectedNodeIds, node.nodeId);
	if found == true { return; }
	array_add(*editor.sceneUiData.selectedNodeIds, node.nodeId);
	onNodeSelectionAdded(editor, editor.nodesScene, node);
}
deselectNode :: (editor: *Editor, node: *BaseNodeAny) {
	found, index := array_find(editor.sceneUiData.selectedNodeIds, node.nodeId);
	if found == false { return; }
	array_unordered_remove_by_value(*editor.sceneUiData.selectedNodeIds, node.nodeId, stop_after_first=true);
	onNodeSelectionRemoved(editor, editor.nodesScene, node);
}
isNodeSelected :: (editor: *Editor, nodeId: NodeId)->bool {
	return array_find(editor.sceneUiData.selectedNodeIds, nodeId);
}
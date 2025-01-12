

isNodeSelected :: (editor: *Editor, nodeId: NodeId)->bool {
	return array_find(editor.sceneUiData.selectedNodeIds, nodeId);
}
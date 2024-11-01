

EDITOR: Editor;

editorAddNode :: (editor: *Editor, node: *BaseNodeAny) {
	editor.nodePositions[node.nodeId] = .{0,0};
}

#scope_file

Editor :: struct {
	nodePositions:[..]Vector2;
}
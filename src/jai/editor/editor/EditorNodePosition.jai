nodeSetPosition :: (editor: *Editor, node: *BaseNode, position: Vector2) {
	onNodeSetPosition(editor, editor.nodesScene, node, position);
}
nodeSetPosition :: (editor: *Editor, node: BaseNode, position: Vector2) {
	nodeSetPosition(editor, *node, position);
}
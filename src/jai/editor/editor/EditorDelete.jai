editorReset :: (using editor: *Editor) {
	_scene := nodesScene;
	#if HAS_VIEWER_PANEL viewerPanelReset(*viewerPanel);
	#if HAS_NETWORK_PANEL networkPanelReset(*networkPanel);
	paramsPanelReset(*paramsPanel);
	if(nodesScene != null) {
		editorRemoveScene(editor);
	}

	allocatorReset(editor);

	editor.onAfterDelete(_scene);

	editor.exitRequested = false;
	editor.disposed = true;
}
// editorDelete :: (using editor: *Editor) {
// 	editorReset(editor);
// 	free(editor);
// }
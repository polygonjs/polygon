paramsPanelReset :: (using panel: *TYPE) {
	#if USE_IMGUI rendererUIDestroy(*panel.editor.imguiPolygonContext);
	rendererReset(*renderer);
}
paramsPanelDelete :: (using panel: *TYPE) {
	paramsPanelReset(panel);
	// allocatorReset(panel);
	free(panel);
}

#scope_file

TYPE :: ParamsPanel;
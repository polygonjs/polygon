processEvent :: (editor: *Editor, eventsData:*EventsData) {
	#if USE_IMGUI {
		if(ImGui.GetIO().WantCaptureMouse == false) processEventPanels(editor, eventsData);
	} else {
		processEventPanels(editor, eventsData);
	}
}

#scope_file

processEventPanels :: (editor: *Editor, eventsData:*EventsData) {
	#if HAS_VIEWER_PANEL processEvent(editor.viewerPanel, eventsData);
	#if HAS_NETWORK_PANEL processEvent(editor.networkPanel, eventsData);
}
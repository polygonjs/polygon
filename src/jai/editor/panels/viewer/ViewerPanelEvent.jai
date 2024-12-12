processEvent :: (panel: *TYPE, eventsData:*EventsData) {
	using panel;
	focused := element_focused(renderer, eventsData);
	camera_controls_process_event(*cameraControls, eventsData, focused);
}

#scope_file

TYPE :: ViewerPanel;
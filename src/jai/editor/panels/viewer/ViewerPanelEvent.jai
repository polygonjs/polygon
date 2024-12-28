processEvent :: (using panel: *TYPE, eventsData:*EventsData) {
	focused := elementFocused(*renderer, eventsData);
	cameraControlsProcessEvent(*cameraControls, eventsData, focused);
}

#scope_file

TYPE :: ViewerPanel;
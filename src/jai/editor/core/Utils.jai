elementFocused :: (using renderer:*ViewportContainer, events_data:*EventsData)->bool {
	if(fullScreen)return true;
	return 	events_data.cursor.x >= xx viewport.start.x &&
			events_data.cursor.x <= xx (viewport.start.x + viewport.size.x) &&
			events_data.cursor.y >= xx viewport.start.y &&
			events_data.cursor.y <= xx (viewport.start.y + viewport.size.y);
}

element_focused :: (renderer:*Renderer, events_data:*EventsData)->bool {
	using renderer;
	if(full_screen)return true;
	return 	events_data.cursor.x >= xx viewport.start.x &&
			events_data.cursor.x <= xx (viewport.start.x + viewport.size.x) &&
			events_data.cursor.y >= xx viewport.start.y &&
			events_data.cursor.y <= xx (viewport.start.y + viewport.size.y);
}

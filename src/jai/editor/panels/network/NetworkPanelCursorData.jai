NetworkPanelCursorData :: struct {
	startPos: Vector2;
	currentPos: Vector2;
	distanceMoved: float;
}

cursorForRaycast :: (eventsData: *EventsData, viewportContainer: *ViewportContainer) -> Vector2 {
	if(viewportContainer.fullScreen){
		assert(false, "cursorForRaycast viewport full screen not implemented");
	}
	using viewportContainer.viewport;
	return .{
		x = cast(float)(eventsData.cursor.x-start.x) / cast(float)size.x,
		y = cast(float)(eventsData.cursor.y-start.y) / cast(float)size.y,
	};
}

networkPanelCursorDataInit :: (using cursorData: *NetworkPanelCursorData, pos: Vector2){
	startPos = pos;
	currentPos = pos;
	distanceMoved = 0;
}

networkPanelCursorUpdate :: (using cursorData: *NetworkPanelCursorData, pos: Vector2){
	currentPos = pos;
	delta :Vector2 = currentPos - startPos;
	distanceMoved += length(delta);
}

networkCursorDataGetWorldPos :: (eventsData: *EventsData, screenCursorData: *NetworkPanelCursorData, camera: *Camera) -> Vector2 {
	raycaster: Raycaster;
	raycasterSetFromCamera(*raycaster, camera, screenCursorData.currentPos);
	return .{raycaster.ray.origin.x, raycaster.ray.origin.y};
}

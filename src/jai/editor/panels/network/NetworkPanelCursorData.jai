NetworkPanelCursorData :: struct {
	startPos: Vector2;
	currentPos: Vector2;
	distanceMoved: float;
}

cursorForRaycast :: (eventsData: *EventsData, using viewportContainer: *ViewportContainer) -> Vector2 {
	if(fullScreen){
		assert(false, "cursorForRaycast viewport full screen not implemented");
	}
	using viewport;
	return .{
		x = 2*(cast(float)(eventsData.cursor.x-start.x) / cast(float)size.x)-1,
		y = -2*(cast(float)(eventsData.cursor.y-start.y) / cast(float)size.y)+1,
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

networkCursorDataGetCurrentWorldPos :: (using panel: *TYPE, eventsData: *EventsData) -> Vector2 {
	// raycaster: Raycaster;
	// raycasterSetFromCamera(*raycaster, camera, screenCursorData.currentPos);
	return networkCursorDataGetWorldPos(eventsData, *camera, eventHandler.screenData.currentPos);
}
// networkCursorDataGetWorldPos :: (eventsData: *EventsData, camera: *Camera, screenCursorData: *NetworkPanelCursorData) -> Vector2 {
// 	raycaster: Raycaster;
// 	raycasterSetFromCamera(*raycaster, camera, screenCursorData.currentPos);
// 	return .{raycaster.ray.origin.x, raycaster.ray.origin.y};
// }
networkCursorDataGetWorldPos :: (eventsData: *EventsData, camera: *$T, cursor: Vector2) -> Vector2 {
	raycaster: Raycaster;
	raycasterSetFromCamera(*raycaster, camera, cursor);
	return .{raycaster.ray.origin.x, raycaster.ray.origin.y};
}

#scope_file

TYPE :: NetworkPanel;
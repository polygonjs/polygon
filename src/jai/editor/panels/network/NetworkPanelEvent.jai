processEvent :: (using panel: *TYPE, eventsData:*EventsData) {
	if(eventsData.dirty == false){
		return;
	}
	focused := elementFocused(rendererColor, eventsData);
	cameraControlsProcessEvent(*cameraControls, eventsData, focused);
	if (focused){
		#if NETWORK_PANEL_USE_RAYCAST_RENDERER {
			updateOutputNode(panel, eventsData);

			if (eventsData.mouseButtonJustPressed.left == true) {
				eventHandler.waitingForButtonDownReadPixel = true;
				eventHandler.waitingForButtonUpReadPixel = false;
				networkPanelCursorDataInit(*eventHandler.screenData, cursorForRaycast(eventsData, rendererColor));
				worldPos := networkCursorDataGetWorldPos(eventsData, *eventHandler.screenData, camera);
				networkPanelCursorDataInit(*eventHandler.worldData, worldPos);
			}
			if (eventsData.mouseButtonJustReleased.left == true) {
				if(eventHandler.screenData.distanceMoved < 0.1){
					eventHandler.waitingForButtonUpReadPixel = eventHandler.nodeIdOnButtonDownFound == true;
				}
				eventHandler.nodeIdOnButtonDownFound = false;
			}
			if (eventsData.mouseButton.left == true) {
				networkPanelCursorUpdate(*eventHandler.screenData, cursorForRaycast(eventsData, rendererColor));
				worldPos := networkCursorDataGetWorldPos(eventsData, *eventHandler.screenData, camera);
				networkPanelCursorUpdate(*eventHandler.worldData, worldPos);
			}
			if (eventHandler.waitingForButtonDownReadPixel == true) {
				eventHandler.nodeIdOnButtonDownFound = false;
				rendererReadPixel(rendererRaycast, sceneRaycast, camera, eventsData.cursor);
				success, result := readPixelIfMapped(rendererRaycast, eventsData);
				if success == true {
					eventHandler.waitingForButtonDownReadPixel = false;
					found, nodeId := meshIdMaterialUnpackId(result);
					if found == true && nodeId < editor.nodesScene.nodes.count {
						node := editor.nodesScene.nodes[nodeId];
						if node != null {
							eventHandler.nodeIdOnButtonDownFound = true;
							eventHandler.nodeIdOnButtonDown = nodeId;
						}
					}
				}
			} else if (eventHandler.waitingForButtonUpReadPixel == true) {
				rendererReadPixel(rendererRaycast, sceneRaycast, camera, eventsData.cursor);
				success, result := readPixelIfMapped(rendererRaycast, eventsData);
				if success == true {
					eventHandler.waitingForButtonUpReadPixel = false;
					found, nodeId := meshIdMaterialUnpackId(result);
					if found == true && nodeId < editor.nodesScene.nodes.count && nodeId == eventHandler.nodeIdOnButtonDown {
						node := editor.nodesScene.nodes[nodeId];
						selectNode(panel.editor, node, .REPLACE);
					}
				}
			}
			
		} else {
			if READ_PIXEL_WARNING_PRINTED == false {
				print("readPixel deactivated\n");
				READ_PIXEL_WARNING_PRINTED = true;
			}
		}
	}
}

#scope_file

TYPE :: NetworkPanel;
READ_PIXEL_WARNING_PRINTED:=false;

updateOutputNode :: (using panel: *TYPE, eventsData:*EventsData) {
	// print("%,%\n", eventsData.text[0], cast(u8)eventsData.text[0]);
	firstChar := eventsData.text[0];
	if firstChar == #char "1" nodesSceneSetFirstOutputNodeInput(editor.nodesScene, 0);
	if firstChar == #char "2" nodesSceneSetFirstOutputNodeInput(editor.nodesScene, 1);
	if firstChar == #char "3" nodesSceneSetFirstOutputNodeInput(editor.nodesScene, 2);
	if firstChar == #char "4" nodesSceneSetFirstOutputNodeInput(editor.nodesScene, 3);
	if firstChar == #char "5" nodesSceneSetFirstOutputNodeInput(editor.nodesScene, 4);
	if firstChar == #char "6" nodesSceneSetFirstOutputNodeInput(editor.nodesScene, 5);
	if firstChar == #char "7" nodesSceneSetFirstOutputNodeInput(editor.nodesScene, 6);
	if firstChar == #char "8" nodesSceneSetFirstOutputNodeInput(editor.nodesScene, 7);
	if firstChar == #char "9" nodesSceneSetFirstOutputNodeInput(editor.nodesScene, 8);
	if firstChar == #char "0" nodesSceneSetFirstOutputNodeInput(editor.nodesScene, 9);

}

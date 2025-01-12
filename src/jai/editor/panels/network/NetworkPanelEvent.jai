processEvent :: (using panel: *TYPE, eventsData:*EventsData) {
	focused := elementFocused(*rendererColor, eventsData);
	panControlsCursor := cursorForRaycast(eventsData, *rendererColor);
	cameraControlsProcessEvent(*cameraControls, eventsData, panControlsCursor, focused);
	if focused == false {
		return;
	}

	// on native, we can get away with just checking eventsData.dirty,
	// but on wasm we also need to check if we are waiting for the buffer to be mapped
	#if NETWORK_PANEL_USE_RAYCAST_RENDERER == false {
		// processingRequired :=
		// 	eventsData.dirty == true
	} else {
		processingRequired :=
			eventsData.dirty == true ||
			eventHandler.waitingForButtonDownReadPixel == true ||
			eventHandler.waitingForButtonUpReadPixel == true;
		if(processingRequired == false){
			return;
		}
	}

	updateOutputNodeCurrentInput(panel, eventsData);

	if (eventsData.cursor != eventsData.prevCursor) {
		networkPanelFindFirstHoveredNode(panel, eventsData);
	}
	#if NETWORK_PANEL_USE_RAYCAST_RENDERER == false {

		if (eventsData.mouseButtonJustPressed.left == true) {
			found, nodeId := findObjectUnderCursor(panel, eventsData);
			eventHandler.nodeIdOnButtonDownFound = found;
			if found {
				eventHandler.nodeIdOnButtonDown = xx nodeId;
			}

			networkPanelCursorDataInit(*eventHandler.screenData, cursorForRaycast(eventsData, *rendererColor));
			worldPos := networkCursorDataGetCurrentWorldPos(panel, eventsData);
			networkPanelCursorDataInit(*eventHandler.worldData, worldPos);
		}
		moveThresholdCrossed := eventHandler.screenData.distanceMoved >= MOVE_DIST_THRESHOLD;
		if (eventsData.mouseButtonJustReleased.left == true) {
			completeNodesMove(panel);
			if moveThresholdCrossed == false {
				newNodeSelectCommand(panel.editor, .[eventHandler.nodeIdOnButtonDown], .REPLACE, push=true);
			}
			eventHandler.nodeIdOnButtonDownFound = false;
		}
		if (eventsData.mouseButton.left == true) {
			networkPanelCursorUpdate(*eventHandler.screenData, cursorForRaycast(eventsData, *rendererColor));
			worldPos := networkCursorDataGetCurrentWorldPos(panel, eventsData);
			networkPanelCursorUpdate(*eventHandler.worldData, worldPos);
			if( eventHandler.nodeIdOnButtonDownFound == true && moveThresholdCrossed == true){
				moveCapturedNodes(panel, eventHandler.nodeIdOnButtonDown, eventHandler.worldData.startPos, eventHandler.worldData.currentPos);
			}
		}

	} else {

		if (eventsData.mouseButtonJustPressed.left == true) {
			eventHandler.waitingForButtonDownReadPixel = true;
			eventHandler.waitingForButtonUpReadPixel = false;
			networkPanelCursorDataInit(*eventHandler.screenData, cursorForRaycast(eventsData, *rendererColor));
			worldPos := networkCursorDataGetCurrentWorldPos(panel, eventsData);
			networkPanelCursorDataInit(*eventHandler.worldData, worldPos);
		}
		moveThresholdCrossed := eventHandler.screenData.distanceMoved >= MOVE_DIST_THRESHOLD;
		if (eventsData.mouseButtonJustReleased.left == true) {
			if(moveThresholdCrossed == false){
				eventHandler.waitingForButtonUpReadPixel = eventHandler.nodeIdOnButtonDownFound == true;
			}
			eventHandler.nodeIdOnButtonDownFound = false;
		}
		if (eventsData.mouseButton.left == true) {
			networkPanelCursorUpdate(*eventHandler.screenData, cursorForRaycast(eventsData, *rendererColor));
			worldPos := networkCursorDataGetCurrentWorldPos(panel, eventsData);
			networkPanelCursorUpdate(*eventHandler.worldData, worldPos);
			if( eventHandler.nodeIdOnButtonDownFound == true && moveThresholdCrossed == true){
				moveCapturedNodes(panel, eventHandler.nodeIdOnButtonDown, eventHandler.worldData.startPos, eventHandler.worldData.currentPos);
			}
		}
		if (eventHandler.waitingForButtonDownReadPixel == true) {
			eventHandler.nodeIdOnButtonDownFound = false;
			renderPixel(*rendererRaycast, *sceneRaycast, xx *camera, eventsData.cursor);
			success, result := readPixelIfMapped(*rendererRaycast, eventsData);
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
			renderPixel(*rendererRaycast, *sceneRaycast, xx *camera, eventsData.cursor);
			success, result := readPixelIfMapped(*rendererRaycast, eventsData);
			if success == true {
				eventHandler.waitingForButtonUpReadPixel = false;
				found, nodeId := meshIdMaterialUnpackId(result);
				if found == true && nodeId < editor.nodesScene.nodes.count && nodeId == eventHandler.nodeIdOnButtonDown {
					node := editor.nodesScene.nodes[nodeId];
					selectNode(panel.editor, node, .REPLACE);
				}
			}
		}
		
	}
}


findObjectUnderCursor :: (using panel: *TYPE, eventsData:*EventsData)-> (found:bool, nodeId:s64) {
	// networkPanelCursorDataInit(*eventHandler.screenData, );
	cursor := cursorForRaycast(eventsData, *rendererColor);
	rayPos := networkCursorDataGetWorldPos(eventsData, *camera, cursor);
	pad := NETWORK_PANEL_NODE_HALF_SIZE;
	for node, i: editor.nodesScene.nodes {
		objectIndex := nodeBodyObjectIndexByNodeId[node.nodeId];
		object := sceneWorld.children[objectIndex];
		using object.position;
		if 	rayPos.x < x+pad &&
			rayPos.x > x-pad &&
			rayPos.y < y+pad &&
			rayPos.y > y-pad
		{
			return true, node.nodeId;
		}
	}
	return false, 0;
}

#scope_file

TYPE :: NetworkPanel;

MOVE_DIST_THRESHOLD :: 0.05;

updateOutputNodeCurrentInput :: (using panel: *TYPE, eventsData:*EventsData) {
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

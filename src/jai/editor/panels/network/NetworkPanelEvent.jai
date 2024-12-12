processEvent :: (panel: *TYPE, eventsData:*EventsData) {
	using panel;
	focused := element_focused(rendererColor, eventsData);
	camera_controls_process_event(*cameraControls, eventsData, focused);
	if (focused){
		#if NETWORK_PANEL_USE_RAYCAST_RENDERER {
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

			if eventsData.mouseButtonPressed.left { /* using "== true" will fail in WASM, not yet sure why, possibly because the setBoolean in Common.ts is incorrectly implemented */
				rendererReadPixel(rendererRaycast, sceneRaycast, camera, eventsData.cursor);
			}
			success, result := readPixelIfMapped(rendererRaycast, eventsData);
			if success == true {
				found, nodeId := meshIdMaterialUnpackId(result);
				if found == true && nodeId < editor.nodesScene.nodes.count {
					node := editor.nodesScene.nodes[nodeId];
					if node != null {
						selectNode(panel.editor, node, .REPLACE);
						// if(node.type != OutputGeoNode) {
						// 	output1 := sceneFindNodeByType(editor.nodesScene, OutputGeoNode);
						// 	paramSetValue(*output1.p.input, xx nodeId);
						// 	// if(node.type == BoxGeoNode) {
						// 	// 	paramSetValue(*output1.p.input, 0);
						// 	// } else {
						// 	// 	paramSetValue(*output1.p.input, 1);
						// 	// }
						// }
						// nodeDelete(node);
					}
				}
			}
			// if eventsData.mouseButtonPressed.middle == true {
			// 	createNode(panel.editor.nodesScene, BoxGeoNode);
			// }
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

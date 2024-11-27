processEvent :: (panel: *TYPE, eventsData:*EventsData) {
	using panel;
	focused := element_focused(rendererColor, eventsData);
	camera_controls_process_event(*cameraControls, eventsData, focused);
	if (focused){
		#if WASM==false && NETWORK_PANEL_USE_RAYCAST_RENDERER {
			if eventsData.mouseButtonPressed.left == true {
				result := read_pixel(rendererRaycast, sceneRaycast, camera, eventsData.cursor);
				found, nodeId := meshIdMaterialUnpackId(result);
				if found == true && nodeId < editor.nodesScene.nodes.count {
					node := editor.nodesScene.nodes[nodeId];
					if node != null {
						print("hovered nodeId: %, %\n", nodeId, node.type);
						if(node.type != OutputGeoNode) {
							output1 := sceneFindNodeByType(editor.nodesScene, OutputGeoNode);
							paramSetValue(*output1.p.input, xx nodeId);
							// if(node.type == BoxGeoNode) {
							// 	paramSetValue(*output1.p.input, 0);
							// } else {
							// 	paramSetValue(*output1.p.input, 1);
							// }
						}
						// nodeDelete(node);
					}
				}
			}
			// if eventsData.mouseButtonPressed.middle == true {
			// 	createNode(panel.editor.nodesScene, BoxGeoNode);
			// }
		} else {
			if READ_PIXEL_WARNING_PRINTED == false {
				print("read_pixel not supported in WASM yet\n");
				READ_PIXEL_WARNING_PRINTED = true;
			}
		}
	}
}

#scope_file

TYPE :: NetworkPanel;
READ_PIXEL_WARNING_PRINTED:=false;

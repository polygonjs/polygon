networkPanelReset :: (using panel: *TYPE) {
	sceneRemoveObserver(*sceneWorld, *rendererColor);
	#if NETWORK_PANEL_USE_RAYCAST_RENDERER sceneRemoveObserver(*sceneRaycast, *rendererRaycast);

	// delete bg material
	// {
	// 	bgObject := sceneWorld.children[0];
	// 	mesh := cast(*Mesh)bgObject;
	// 	materialDelete(cast(*MATERIAL_BG)mesh.material);
	// 	geometryDelete(mesh.geometry);
	// 	worldObjectDelete(mesh);
	// 	sceneWorld.children[0] = null;
	// }
	// {
	// 	bgObject := sceneRaycast.children[0];
	// 	mesh := cast(*Mesh)bgObject;
	// 	materialDelete(cast(*MATERIAL_BG)mesh.material);
	// 	geometryDelete(mesh.geometry);
	// 	worldObjectDelete(mesh);
	// 	sceneRaycast.children[0] = null;
	// }

	// for object, i : sceneWorld.children {
	// 	if object != null {
	// 		generatedWorldObjectDelete(object);
	// 		sceneWorld.children[i] = null;
	// 		raycastObject := sceneRaycast.children[i];
	// 		if raycastObject.type == Mesh {
	// 			(cast(*Mesh)raycastObject).geometry = null;
	// 		}
	// 	}
	// }
	rendererReset(*rendererColor);
	#if NETWORK_PANEL_USE_RAYCAST_RENDERER rendererReset(*rendererRaycast);
	worldObjectReset(*sceneWorld);
	#if NETWORK_PANEL_USE_RAYCAST_RENDERER worldObjectReset(*sceneRaycast);
	// for object,i : sceneRaycast.children {
	// 	if object != null {
	// 		mesh := cast(*Mesh)object;
	// 		materialDelete(cast(*MATERIAL_RAYCAST)mesh.material);
	// 		// geometryDelete(mesh.geometry);
	// 		generatedWorldObjectDelete(object);
	// 		sceneRaycast.children[i] = null;
	// 	}
	// }
	
	// array_reset(*nodeObjectIndexByNodeId);
	// generatedWorldObjectDelete(sceneWorld);
	// generatedWorldObjectDelete(sceneRaycast);
	// materialDelete(basicMat);
	allocatorReset(panel);
}
networkPanelDelete :: (using panel: *TYPE) {
	networkPanelReset(panel);
	free(panel);
}

#scope_file

TYPE :: NetworkPanel;
networkPanelFindFirstHoveredNode :: (using panel: *TYPE, eventsData:*EventsData) {
	found, nodeId := _findHoveredObject(panel, eventsData);
	if found == false {
		if panel.eventHandler.hoveredNodeId < 0 { return; }
		nodeId :NodeId= xx panel.eventHandler.hoveredNodeId;
		panel.eventHandler.hoveredNodeId = -1;
		objectIndex := nodeObjectIndexByNodeId[nodeId];
		mesh := sceneWorld.children[objectIndex];
		if mesh.type == Mesh {
			material := ifx isNodeSelected(editor, nodeId) then *panel.mat.nodeSelected else *panel.mat.nodeBasic;
			meshSetMaterial(*sceneWorld, xx mesh, xx material);
		}
		return;
	}
	if panel.eventHandler.hoveredNodeId == nodeId { return; }

	node := editor.nodesScene.nodes[nodeId];
	objectIndex := nodeObjectIndexByNodeId[node.nodeId];
	mesh := sceneWorld.children[objectIndex];
	if mesh.type == Mesh {
		meshSetMaterial(*sceneWorld, xx mesh, xx *panel.mat.nodeHovered);
	}
	panel.eventHandler.hoveredNodeId = nodeId;
}

#scope_file

TYPE :: NetworkPanel;

_findHoveredObject :: (using panel: *TYPE, eventsData:*EventsData)-> (found:bool, nodeId:s64) {
	// networkPanelCursorDataInit(*eventHandler.screenData, );
	cursor := cursorForRaycast(eventsData, *rendererColor);
	rayPos := networkCursorDataGetWorldPos(eventsData, *camera, cursor);
	pad := NETWORK_PANEL_NODE_HALF_SIZE;
	for node, i: editor.nodesScene.nodes {
		objectIndex := nodeObjectIndexByNodeId[node.nodeId];
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
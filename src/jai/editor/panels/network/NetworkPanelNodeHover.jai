networkPanelFindFirstHoveredNode :: (using panel: *TYPE, eventsData:*EventsData) {
	found, nodeId := findObjectUnderCursor(panel, eventsData);
	if found == false {
		_restoreMaterialToPreviouslyHighlighted(panel);
		panel.eventHandler.hoveredNodeId = -1;
		return;
	}
	if panel.eventHandler.hoveredNodeId == nodeId { return; }

	_restoreMaterialToPreviouslyHighlighted(panel);
	_setMaterial(panel, xx nodeId, xx *panel.mat.nodeHovered);
	panel.eventHandler.hoveredNodeId = nodeId;
}

#scope_file

TYPE :: NetworkPanel;

_restoreMaterialToPreviouslyHighlighted :: (using panel: *TYPE) {
	if panel.eventHandler.hoveredNodeId < 0 { return; }
	nodeId :NodeId= xx panel.eventHandler.hoveredNodeId;
	material := ifx isNodeSelected(editor, nodeId) then *panel.mat.nodeSelected else *panel.mat.nodeBasic;
	_setMaterial(panel, xx nodeId, xx material);
}

_setMaterial :: (using panel: *TYPE, nodeId:NodeId, material: *Material){
	node := editor.nodesScene.nodes[nodeId];
	objectIndex := nodeBodyObjectIndexByNodeId[node.nodeId];
	mesh := sceneWorld.children[objectIndex];
	if mesh.type == Mesh {
		meshSetMaterial(*sceneWorld, xx mesh, material);
	}
}


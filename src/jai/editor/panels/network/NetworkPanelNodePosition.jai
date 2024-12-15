networkPanelNodeSetPosition :: (panel: *TYPE, node: *$T, position: Vector2) {
	_moveNode :: (using panel:*TYPE, node:*T, $forRaycast:bool) {
		#if forRaycast {
			scene := sceneRaycast;
		} else {
			scene := sceneWorld;
		}
		meshIndex := nodeObjectIndexByNodeId[node.nodeId];
		if meshIndex >= 0 {
			mesh := scene.children[meshIndex];
			pos := panel.editor.sceneUiData.nodePositions[node.nodeId];
			mesh.position = .{x = pos.x, y = pos.y, z = 0.0};
			transformableUpdateMatrix(mesh);
		}
	}
	_moveNode(panel, node, forRaycast=false);
	#if NETWORK_PANEL_USE_RAYCAST_RENDERER _moveNode(panel, node, forRaycast=true);
}

#scope_file

TYPE :: NetworkPanel;
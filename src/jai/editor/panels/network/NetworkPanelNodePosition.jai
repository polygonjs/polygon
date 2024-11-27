networkPanelNodeSetPosition :: (panel: *TYPE, node: *$T, position: Vector2) {
	_moveNode :: (panel:*TYPE, node:*T, $forRaycast:bool) {
		using panel;
		#if forRaycast {
			scene := sceneRaycast;
		} else {
			scene := sceneWorld;
		}
		meshIndex := objectIndex[node.nodeId];
		if meshIndex >= 0 {
			mesh := scene.children[meshIndex];
			pos := panel.editor.sceneUiData.nodePositions[node.nodeId];
			mesh.position = .{x = pos.x, y = pos.y, z = 0.0};
			transformable_update_matrix(mesh);
		}
	}
	_moveNode(panel, node, forRaycast=false);
	#if NETWORK_PANEL_USE_RAYCAST_RENDERER _moveNode(panel, node, forRaycast=true);
}

#scope_file

TYPE :: NetworkPanel;
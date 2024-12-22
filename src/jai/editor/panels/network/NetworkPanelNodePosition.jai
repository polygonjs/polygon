moveCapturedNodes :: (using panel: *NetworkPanel, nodeId: NodeId, startPos: Vector2, currentPos: Vector2) {
	editor.sceneUiData.nodePositions[nodeId] = currentPos;

	node := editor.nodesScene.nodes[nodeId];
	onNodeSetPosition(editor, editor.nodesScene, node, currentPos);
}

networkPanelNodeSetPosition :: (using panel: *TYPE, node: *$T, position: Vector2) {
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
			sceneObjectUpdateMatrix(scene, mesh);
		}
	}
	_moveNode(panel, node, forRaycast=false);
	#if NETWORK_PANEL_USE_RAYCAST_RENDERER _moveNode(panel, node, forRaycast=true);

	// once we can move multiple nodes together,
	// make sure we don't update the matrices of connections more than we need.

	connections := editor.nodesScene.connections;
	outConnections := connections.connectionIdBySrcNodeId[node.nodeId];
	inConnections := connections.connectionIdByDestNodeId[node.nodeId];
	for connectionId, outConnection: outConnections {
		connection := connections.connections[connectionId];
		networkPanelConnectionSetMatrix(panel, connection, forRaycast=false);
		networkPanelConnectionSetMatrix(panel, connection, forRaycast=true);
	}
	for connectionId, inConnection: inConnections {
		connection := connections.connections[connectionId];
		networkPanelConnectionSetMatrix(panel, connection, forRaycast=false);
		networkPanelConnectionSetMatrix(panel, connection, forRaycast=true);
	}
}

#scope_file

TYPE :: NetworkPanel;
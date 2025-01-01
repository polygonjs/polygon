moveCapturedNodes :: (using panel: *NetworkPanel, nodeId: NodeId, startPos: Vector2, currentPos: Vector2) {
	editor.sceneUiData.nodePositions[nodeId] = currentPos;

	node := editor.nodesScene.nodes[nodeId];
	onNodeSetPosition(editor, editor.nodesScene, node, currentPos);
}

networkPanelNodeSetPosition :: (using panel: *TYPE, node: *$T, position: Vector2) {
	_moveNode :: (using panel:*TYPE, node:*T, $forRaycast:bool) {
		#if forRaycast {
			scene := *sceneRaycast;
		} else {
			scene := *sceneWorld;
		}
		bodyMeshIndex := nodeBodyObjectIndexByNodeId[node.nodeId];
		textMeshIndex := nodeTextObjectIndexByNodeId[node.nodeId];
		if bodyMeshIndex >= 0 && textMeshIndex >= 0 {
			pos := panel.editor.sceneUiData.nodePositions[node.nodeId];
			bodyPos :Vector3= .{x = pos.x, y = pos.y, z = 0.0};
			{
				bodyMesh := scene.children[bodyMeshIndex];
				bodyMesh.position = bodyPos;
				sceneObjectUpdateMatrix(scene, bodyMesh);
			}
			{
				textMesh := scene.children[textMeshIndex];
				textMesh.position = bodyPos + NETWORK_PANEL_TEXT_OFFSET;
				sceneObjectUpdateMatrix(scene, textMesh);
			}
		}
	}
	_moveNode(panel, node, forRaycast=false);
	#if NETWORK_PANEL_USE_RAYCAST_RENDERER _moveNode(panel, node, forRaycast=true);

	// once we can move multiple nodes together,
	// make sure we don't update the matrices of connections more than we need.

	connections := editor.nodesScene.connections;
	outConnectionIds := nodeConnectionFindSuccessorConnectionIds(*editor.nodesScene.connections, node.nodeId);
	inConnectionIds := nodeConnectionFindPredecessorConnectionIds(*editor.nodesScene.connections, node.nodeId);
	for connectionId: outConnectionIds {
		connection := connections.connections[connectionId];
		networkPanelConnectionSetMatrix(panel, connection, forRaycast=false);
		networkPanelConnectionSetMatrix(panel, connection, forRaycast=true);
	}
	for connectionId: inConnectionIds {
		connection := connections.connections[connectionId];
		networkPanelConnectionSetMatrix(panel, connection, forRaycast=false);
		networkPanelConnectionSetMatrix(panel, connection, forRaycast=true);
	}
}

#scope_file

TYPE :: NetworkPanel;
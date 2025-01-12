NetworkPanelNodeMoveData :: struct {
	moveInProgress:bool = false;
	items:[..]NodeMoveCommandItem;
}

nodeMoveDataInit :: (using panel: *NetworkPanel) {
	push_allocator(panel.allocator);
	array_init(*nodeMoveData.items, panel.allocator);
}

moveCapturedNodes :: (using panel: *NetworkPanel, nodeId: NodeId, startPos: Vector2, currentPos: Vector2) {
	if nodeMoveData.moveInProgress==false {
		nodeMoveData.moveInProgress = true;
		array_add(*nodeMoveData.items, .{
			nodeId = nodeId,
			startPos = startPos
		});
	}
	editor.sceneUiData.nodePositions[nodeId] = currentPos;

	node := editor.nodesScene.nodes[nodeId];
	onNodeSetPosition(editor, editor.nodesScene, node, currentPos);
}
completeNodesMove :: (using panel: *NetworkPanel) {
	if nodeMoveData.moveInProgress == false {
		return;
	}
	nodeMoveData.moveInProgress = false;

	for i: 0..(nodeMoveData.items.count-1) {
		nodeId := nodeMoveData.items[i].nodeId;
		nodeMoveData.items[i].endPos = editor.sceneUiData.nodePositions[nodeId];
	}
	newNodeMoveCommand(editor, nodeMoveData.items, push=true);
	array_reset_keeping_memory(*nodeMoveData.items);
}


networkPanelNodeSetPosition :: (using panel: *TYPE, node: *$T, position: Vector2) {
	_moveNode :: (using panel:*TYPE, node:*T, $forRaycast:bool) {
		#if forRaycast {
			scene := *sceneRaycast;
		} else {
			scene := *sceneWorld;
		}
		bodyMeshIndex := nodeBodyObjectIndexByNodeId[node.nodeId];
		// textMeshIndex := nodeTextObjectIndexByNodeId[node.nodeId];
		if bodyMeshIndex >= 0 {
			pos := panel.editor.sceneUiData.nodePositions[node.nodeId];
			bodyPos :Vector3= .{x = pos.x, y = pos.y, z = 0.0};
			{
				bodyMesh := scene.children[bodyMeshIndex];
				bodyMesh.position = bodyPos;
				sceneObjectUpdateMatrix(scene, bodyMesh);
			}
			// {
			// 	textMesh := scene.children[textMeshIndex];
			// 	textMesh.position = bodyPos + NETWORK_PANEL_TEXT_OFFSET;
			// 	sceneObjectUpdateMatrix(scene, textMesh);
			// }
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
		#if NETWORK_PANEL_USE_RAYCAST_RENDERER networkPanelConnectionSetMatrix(panel, connection, forRaycast=true);
	}
	for connectionId: inConnectionIds {
		connection := connections.connections[connectionId];
		networkPanelConnectionSetMatrix(panel, connection, forRaycast=false);
		#if NETWORK_PANEL_USE_RAYCAST_RENDERER networkPanelConnectionSetMatrix(panel, connection, forRaycast=true);
	}
}

#scope_file

TYPE :: NetworkPanel;
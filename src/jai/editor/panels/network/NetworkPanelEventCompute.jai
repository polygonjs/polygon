networkPanelOnComputeStarted :: (using panel: *TYPE) {
	found, connectionId := _findOutputNodeConnection(panel);
	if found == false {
		if panel.eventHandler.highlightedConnectionId < 0 { return; }
		_restoreMaterialToPreviouslyHighlighted(panel);
		panel.eventHandler.highlightedConnectionId = -1;
		return;
	}
	if connectionId == eventHandler.highlightedConnectionId { return; }
	
	_restoreMaterialToPreviouslyHighlighted(panel);
	_setMaterial(panel, xx connectionId, xx *panel.mat.connectionCurrent);
	eventHandler.highlightedConnectionId = connectionId;
}
networkPanelOnComputeCompleted :: (using panel: *TYPE) {
	// print("compute completed\n");
}

#scope_file

TYPE :: NetworkPanel;

_restoreMaterialToPreviouslyHighlighted :: (using panel: *TYPE) {
	if panel.eventHandler.highlightedConnectionId < 0 { return; }
	_setMaterial(panel, xx panel.eventHandler.highlightedConnectionId, xx *panel.mat.connectionBasic);
}

_setMaterial :: (using panel: *TYPE, connectionId:NodeConnectionId, material: *Material){
	if connectionId >= connectionObjectIndexByConnectionId.count { return; }
	objectIndex := connectionObjectIndexByConnectionId[connectionId];
	object := sceneWorld.children[objectIndex];
	if object.type == Mesh {
		meshSetMaterial(*sceneWorld, xx object, xx material);
	}
}

_findOutputNodeConnection :: (using panel: *TYPE) -> (found:bool, connectionId: NodeConnectionId) {
	outputNode := nodesSceneFindFirstOutputNode(editor.nodesScene);
	if outputNode == null { return false, 0; }
 	// print("compute started\n");
	connectionIds := nodeConnectionFindPredecessorConnectionIds(*editor.nodesScene.connections, outputNode.nodeId);//editor.nodesScene.connections.connectionIdBySrcNodeId[outputNode.nodeId];
	currentInputIndex := outputNode.p.input.value;
	for connectionId, i: connectionIds {
		connection := editor.nodesScene.connections.connections[connectionId];
		if connection.dest.inputIndex == currentInputIndex {
			return true, connection.id;
		}
	}
	return false, 0;
}
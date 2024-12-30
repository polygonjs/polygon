NodeConnectionId :: s64;
NodeConnectionIdOrNone :: s64;
NodeConnectionSrc :: struct {
	nodeId: NodeId;
	outputIndex: NodeInputIndex;
}
NodeConnectionDest :: struct {
	nodeId: NodeId;
	inputIndex: NodeInputIndex;
}
NodeConnection :: struct {
	src: NodeConnectionSrc;
	dest: NodeConnectionDest;
	id: NodeConnectionId=-1;
}
NodeConnectionRequest :: struct {
	src: NodeConnectionSrc;
	dest: NodeConnectionDest;
}

ConnectionIdArrayCount :: u8;
ConnectionIdArray :: struct {
	count: ConnectionIdArrayCount;
	ids: [NODES_MAX_INPUTS_COUNT]NodeConnectionId;
}
ConnectionIdArrayByNodeId :: [..]ConnectionIdArray;

NodeConnectionList :: struct {
	nextIndex: NodeConnectionId=0;
	// validIndices: Bit_Array;
	connections: [..]NodeConnection;
	connectionIdBySrcNodeId: ConnectionIdArrayByNodeId;
	connectionIdByDestNodeId: ConnectionIdArrayByNodeId;
}

nodeConnectionListInit :: (using scene:*NodesScene) {
	push_allocator(scene.allocator);
	array_init(*connections.connections, reserve=true);
	array_init(*connections.connectionIdBySrcNodeId, reserve=true);
	array_init(*connections.connectionIdByDestNodeId, reserve=true);

	assert(connections.connections.count == 0, "connections should be empty\n");
	// bit_array_resize(*connections.validIndices, 1);
	// connections.validIndices[0] = false;
	// connections.nextIndex = 1;
}
// nodeConnectionListClear :: (using list:*NodeConnectionList) {

// 	array_reset(*connections);
// 	for connectionIds, nodeId: connectionIdBySrcNodeId { array_reset(*connectionIds); }
// 	for connectionIds, nodeId: connectionIdByDestNodeId { array_reset(*connectionIds); }

// }
// nodeConnectionListDelete :: (using list:*NodeConnectionList) {

// 	// nodeConnectionListClear(list);

// 	// deinit(*validIndices);
// 	// array_reset(*connectionIdBySrcNodeId);
// 	// array_reset(*connectionIdByDestNodeId);
// }
nodeConnectionInitForNode :: (using list:*NodeConnectionList, nodeId:NodeId) {
	if nodeId >= xx connectionIdBySrcNodeId.count {
		delta := nodeId - connectionIdBySrcNodeId.count + 1;
		array_resize(*connectionIdBySrcNodeId, xx nodeId+1);
		array_resize(*connectionIdByDestNodeId, xx nodeId+1);
		// array_set_count_and_maybe_grow(*connections, xx nodeId+1);

		// for 0..(delta-1) {
		// 	initConnectionIdArray(*connectionIdBySrcNodeId[nodeId+it]);
		// 	initConnectionIdArray(*connectionIdByDestNodeId[nodeId+it]);
		// }
		// bit_array_resize(*validIndices, xx (nodeId+1));
	}
}
nodeConnectionFindSuccessorConnectionIds :: (using list:*NodeConnectionList, nodeId:NodeId)->[]NodeConnectionId {
	return array_view(connectionIdBySrcNodeId[nodeId].ids, 0, connectionIdBySrcNodeId[nodeId].count);
}
nodeConnectionFindPredecessorConnectionIds :: (using list:*NodeConnectionList, nodeId:NodeId)-> []NodeConnectionId {
	return array_view(connectionIdByDestNodeId[nodeId].ids, 0, connectionIdByDestNodeId[nodeId].count);
}
nodeConnectionFindByDestNode :: (using list:*NodeConnectionList, nodeId: NodeId, inputIndex:u8=0)->NodeConnectionId {
	connectionIds := connectionIdByDestNodeId[nodeId];
	for 0..(connectionIds.count-1) {
		connectionId := connectionIds.ids[it];
		connection := connections[connectionId];
		if connection.dest.inputIndex == inputIndex {
			return connectionId;
		}
	}
	return 0;
}

nodeConnectionAdd :: (scene:*NodesScene, using list:*NodeConnectionList, connectionRequest:NodeConnectionRequest)->NodeConnection {

	if nextIndex < xx connections.count {
		newConnection := _addAtIndex(scene, list, connectionRequest, nextIndex);
		while nextIndex < xx connections.count && connectionIdValid(connections[nextIndex].id) {
			nextIndex += 1;
		}
		return newConnection;
	} else {
		array_set_count_and_maybe_grow(*connections, xx (nextIndex+1));
		// bit_array_resize(*validIndices, xx (nextIndex+1));
		newConnection := _addAtIndex(scene, list, connectionRequest, nextIndex);
		nextIndex += 1;
		return newConnection;
	}
}

nodeConnectionRemove :: (using list:*NodeConnectionList, connection:NodeConnection) {

	// assert(connection.id == 0, "connection should not have an id here, as we are only looking for it from the src or dest node\n");
	assert(connectionIdValid(connection.id), "connection id must be valid to remove it\n");

	destNodeId := connection.dest.nodeId;
	connectionIds := connectionIdByDestNodeId[destNodeId];
	for 0..(connectionIds.count-1) {
		connectionId := connectionIds.ids[it];
		if connectionId == connection.id {
			// foundConnection := connections[connectionId];
			// if 	foundConnection.src.nodeId == connection.src.nodeId &&
			// 	foundConnection.src.outputIndex == connection.src.outputIndex &&
			// 	foundConnection.dest.nodeId == connection.dest.nodeId &&
			// 	foundConnection.dest.inputIndex == connection.dest.inputIndex {

			index := connection.id;
			// validIndices[xx index] = false;

			if index < nextIndex {
				nextIndex = index;
			}

			_removeConnectionId(*connectionIdBySrcNodeId,  connection.src.nodeId, index);
			_removeConnectionId(*connectionIdByDestNodeId, connection.dest.nodeId, index);
			_invalidateConnection(*connections[connection.id]);

			return;
			// }
		}
	}

	assert(false, "connection not found\n");
}

connectionIdValid :: (connectionId:NodeConnectionId)->bool {
	return connectionId >= 0;
}


#scope_file

_invalidateConnection :: (connection:*NodeConnection) {
	connection.id = -1;
}
// invalidateConnectionId :: (connectionIds:*ConnectionIdArray, index:s64) {
// 	(<<connectionIds)[index] = -1;
// }
// initConnectionIdArray :: (connectionIds:*ConnectionIdArray) {
// 	for 0..(NODES_MAX_INPUTS_COUNT-1) { (<<connectionIds)[it] = -1; }
// }

_addAtIndex :: (scene:*NodesScene, using list:*NodeConnectionList, connectionRequest:NodeConnectionRequest, index:NodeConnectionId) -> NodeConnection {
	// validIndices[xx index] = true;
	connection:NodeConnection = .{
		src = connectionRequest.src,
		dest = connectionRequest.dest,
		id = index
	};
	connections[index] = connection;

	_addConnectionId(scene, *connectionIdBySrcNodeId,  connection.src.nodeId, index);
	_addConnectionId(scene, *connectionIdByDestNodeId, connection.dest.nodeId, index);

	return connections[index];
}

_addConnectionId :: (scene:*NodesScene, idList: *ConnectionIdArrayByNodeId, nodeId:NodeId, connectionId:NodeConnectionId) {
	// if nodeId >= xx idList.count {
	// 	array_resize(idList, xx nodeId+1);
	// 	// initConnectionIdArray(*(<<idList)[nodeId]);
	// }
	connectionIds:*ConnectionIdArray = *(<<idList)[nodeId];
	assert(_connectionIdFind(connectionIds, connectionId)==false, "connection should not exist yet\n");

	connectionIds.ids[connectionIds.count] = connectionId;
	connectionIds.count += 1;
}
_removeConnectionId :: (idList: *ConnectionIdArrayByNodeId, nodeId:NodeId, connectionId:NodeConnectionId) {
	connectionIds :*ConnectionIdArray= *(<<idList)[nodeId];
	found, index := _connectionIdFind(connectionIds, connectionId);
	assert(found==true, "connection should exist\n");
	if connectionIds.count > 0 {
		connectionIds.ids[index] = connectionIds.ids[connectionIds.count-1];
	}
	connectionIds.count -= 1;
}
_connectionIdFind :: (connectionIds:*ConnectionIdArray, connectionId:NodeConnectionId)->(found:bool, index:ConnectionIdArrayCount) {
	if connectionIds.count == 0 {
		return false, 0;
	}
	for 0..(connectionIds.count-1) {
		if connectionIds.ids[it] == connectionId {
			return true, xx it;
		}
	}
	return false, 0;
}

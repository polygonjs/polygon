NodeConnectionId :: u64;
NodeConnection :: struct {
	NodeConnectionSrc :: struct {
		nodeId: NodeId;
		outputIndex: u8;
	}
	NodeConnectionDest :: struct {
		nodeId: NodeId;
		inputIndex: u8;
	}
	src: NodeConnectionSrc;
	dest: NodeConnectionDest;
	id: NodeConnectionId=0;
}

NodeConnectionList :: struct {
	nextIndex: NodeConnectionId=0;
	validIndices: Bit_Array;
	connections: [..]NodeConnection;
	connectionIdBySrcNodeId: [..][..]NodeConnectionId;
	connectionIdByDestNodeId: [..][..]NodeConnectionId;
}

nodeConnectionListInit :: (list:*NodeConnectionList) {
	using list;
	array_init(*connections);
	array_init(*connectionIdBySrcNodeId);
	array_init(*connectionIdByDestNodeId);

	// we add a dummy connection,
	// so that we can use the inde 0 as invalid.
	array_add(*connections, .{
		src=.{nodeId=0, outputIndex=0},
		dest=.{nodeId=0, inputIndex=0},
	});
	bit_array_resize(*validIndices, 1);
	validIndices[0] = false;
	nextIndex = 1;
}
nodeConnectionListClear :: (list:*NodeConnectionList) {
	using list;

	array_reset(*connections);
	for connectionIds, nodeId: connectionIdBySrcNodeId { array_reset(*connectionIds); }
	for connectionIds, nodeId: connectionIdByDestNodeId { array_reset(*connectionIds); }

}
nodeConnectionListDelete :: (list:*NodeConnectionList) {
	using list;

	nodeConnectionListClear(list);

	deinit(*validIndices);
	array_reset(*connectionIdBySrcNodeId);
	array_reset(*connectionIdByDestNodeId);
}
nodeConnectionInitForNode :: (list:*NodeConnectionList, nodeId:NodeId) {
	using list;
	if nodeId >= xx connectionIdBySrcNodeId.count {
		array_resize(*connectionIdBySrcNodeId, xx nodeId+1);
		array_resize(*connectionIdByDestNodeId, xx nodeId+1);
		array_set_count_and_maybe_grow(*connections, xx nodeId+1);
		bit_array_resize(*validIndices, xx (nodeId+1));
	}
}
nodeConnectionFindSuccessorConnectionIds :: (list:*NodeConnectionList, nodeId:NodeId)->[..]NodeConnectionId {
	return list.connectionIdBySrcNodeId[nodeId];
	// target:[..]NodeConnectionId;
	// // array_reset(target);
	// if connectionIdBySrcNodeId.count <= nodeId {
	// 	return target;
	// }
	// connectionIds := connectionIdBySrcNodeId[nodeId];
	// for connectionId: connectionIds {
	// 	if connectionId != 0 {
	// 		array_add(*target, connectionId);
	// 	}
	// }
	// return target;
}
nodeConnectionFindPredecessorConnectionIds :: (list:*NodeConnectionList, nodeId:NodeId)-> [..]NodeConnectionId {
	using list;
	return connectionIdByDestNodeId[nodeId];
	// target:[..]NodeConnectionId;
	// // array_copy(target, list.connectionIdByDestNodeId[nodeId]);
	// // array_reset(target);
	// if connectionIdByDestNodeId.count <= nodeId {
	// 	return target;
	// }
	// connectionIds := connectionIdByDestNodeId[nodeId];
	// for connectionId: connectionIds {
	// 	if connectionId != 0 {
	// 		array_add(*target, connectionId);
	// 	}
	// }
	// return target;
}
nodeConnectionFindByDestNode :: (list:*NodeConnectionList, nodeId: NodeId, inputIndex:u8=0)->NodeConnectionId {
	using list;
	connectionIds := connectionIdByDestNodeId[nodeId];
	for connectionId: connectionIds {
		if connectionId != 0 {
			connection := connections[connectionId];
			if connection.dest.inputIndex == inputIndex {
				return connectionId;
			}
		}
	}
	return 0;
}

nodeConnectionAdd :: (list:*NodeConnectionList, connection:NodeConnection)->NodeConnection {
	using list;

	assert(connections.count==validIndices.count, "connections and validIndices should have the same count\n");

	if nextIndex < xx connections.count {
		connectionWithId := _addAtIndex(list, connection, nextIndex);
		while nextIndex < xx validIndices.count && validIndices[xx nextIndex]==true {
			nextIndex += 1;
		}
		return connectionWithId;
	} else {
		array_set_count_and_maybe_grow(*connections, xx (nextIndex+1));
		bit_array_resize(*validIndices, xx (nextIndex+1));
		connectionWithId := _addAtIndex(list, connection, nextIndex);
		nextIndex += 1;
		return connectionWithId;
	}

	
}

nodeConnectionRemove :: (list:*NodeConnectionList, connection:NodeConnection) {
	using list;

	// assert(connection.id == 0, "connection should not have an id here, as we are only looking for it from the src or dest node\n");
	assert(connection.id != 0, "connection id must be known to remove it\n");

	destNodeId := connection.dest.nodeId;
	for connectionId: connectionIdByDestNodeId[destNodeId] {
		if connectionId == connection.id {
			// foundConnection := connections[connectionId];
			// if 	foundConnection.src.nodeId == connection.src.nodeId &&
			// 	foundConnection.src.outputIndex == connection.src.outputIndex &&
			// 	foundConnection.dest.nodeId == connection.dest.nodeId &&
			// 	foundConnection.dest.inputIndex == connection.dest.inputIndex {

			index := connection.id;
			validIndices[xx index] = false;

			if index < nextIndex {
				nextIndex = index;
			}

			_removeConnectionId(*connectionIdBySrcNodeId,  connection.src.nodeId, index);
			_removeConnectionId(*connectionIdByDestNodeId, connection.dest.nodeId, index);

			return;
			// }
		}
	}

	assert(false, "connection not found\n");
}

#scope_file

_addAtIndex :: (list:*NodeConnectionList, connection:NodeConnection, index:NodeConnectionId) -> NodeConnection {
	using list;
	validIndices[xx index] = true;
	connections[index] = connection;
	connections[index].id = index;

	_addConnectionId(*connectionIdBySrcNodeId,  connection.src.nodeId, index);
	_addConnectionId(*connectionIdByDestNodeId, connection.dest.nodeId, index);

	return connections[index];
}

_addConnectionId :: (idList: *[..][..]NodeConnectionId, nodeId:NodeId, connectionId:NodeConnectionId) {
	if nodeId >= xx idList.count {
		array_resize(idList, xx nodeId+1);
	}
	connectionIds:*[..]u64 = *(<<idList)[nodeId];
	assert(array_find_ptr(connectionIds, connectionId)==false, "connection should not exist yet\n");
	added := false;
	for connectionId, i: <<connectionIds {
		if connectionId == 0 {
			(<<idList)[nodeId][i] = connectionId;
			added = true;
			break;
		}
	}
	if(!added){
		array_add(*(<<idList)[nodeId], connectionId);
	}
}
_removeConnectionId :: (idList: *[..][..]NodeConnectionId, nodeId:NodeId, connectionId:NodeConnectionId) {
	found, index := array_find_ptr(*(<<idList)[nodeId], connectionId);
	assert(found==true, "connection should exist\n");
	(<<idList)[nodeId][index] = 0;
}
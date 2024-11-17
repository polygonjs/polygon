setInput :: (node: *$N0, inputIndex:u8=0, inputNode: *$N1, outputIndex:u8=0) -> bool
// #modify {
// 	ti0 := cast(*Type_Info) N0;
// 	tis0 := cast(*Type_Info_Struct)ti0;
// 	ctx0 := get_field(tis0, "ctx");
// 	print("ctx0: %\n", <<ctx0);
// 	print("node: %\n", node);
// 	// params_info := type_info(type_of(node.ctx0));
// 	return true;
// }
{
	// #assert(N0.ctx == N1.ctx);
	assert(node.ctx == inputNode.ctx, "nodes have different contexts");
	assert(node.nodeId != inputNode.nodeId, "node ids must be different");
	// node.inputs[inputIndex] = xx inputNode;
	// print("setInput % % %\n", node.type, node.inputs, inputNode.inputs);
	connectionCreated := graphNodeConnect(src=inputNode, dest=node, checkCycle=true);
	if connectionCreated == true {
		nodeConnectionAdd(*graphNodeScene(node).connections, .{
			src=.{
				nodeId=inputNode.nodeId,
				outputIndex=outputIndex
			},
			dest=.{
				nodeId=node.nodeId,
				inputIndex=inputIndex
			}
		});
		setDirty(node);
	}

	#if NODES_SCENE_EMIT_EVENTS {
		sceneEmitEvent(graphNodeScene(node), NodesSceneEvent.NODE_INPUT_ADDED, node, inputIndex);
	}
	return connectionCreated;
}
removeInput :: (node: *$N0, inputIndex:u8=0) -> bool {
	scene := graphNodeScene(node);
	connectionId := nodeConnectionFindByDestNode(*scene.connections, node.nodeId, inputIndex);
	if connectionId != 0 {
		connection := scene.connections.connections[connectionId];
		previousInputNodeId := connection.src.nodeId;
		previousInputNode := scene.nodes[previousInputNodeId];
		graphNodeDisconnect(src=previousInputNode, dest=node);
		nodeConnectionRemove(*scene.connections, connection);
		// node.inputs[inputIndex] = null;
		setDirty(node);

		#if NODES_SCENE_EMIT_EVENTS {
			sceneEmitEvent(graphNodeScene(node), NodesSceneEvent.NODE_INPUT_ADDED, node, inputIndex);
		}
		return true;

	} else {
		return false;
	}

}
setInput :: (node: *$N0, inputNode: *$N1) {
	setInput(node, 0, inputNode, 0);
}
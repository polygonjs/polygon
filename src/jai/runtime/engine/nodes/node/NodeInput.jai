setInput :: (node: *$T1, inputIndex:u8=0, inputNode: *$T2, outputIndex:u8=0, $doAssert:bool=true) -> bool
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
	#if doAssert assert(generatedNodeCtx(xx node) == generatedNodeCtx(xx inputNode), "nodes have different contexts");
	else if (generatedNodeCtx(xx node) != generatedNodeCtx(xx inputNode)) { return false; }
	#if doAssert assert(node.nodeId != inputNode.nodeId, "node ids must be different");
	else if (node.nodeId == inputNode.nodeId) { return false; }
	// maxInputsCount := NODE_METADATAS[node.nodeTypeId].inputsCount.max;
	#if doAssert assert(inputIndex < node.maxInputsCount, "input index out of bounds");
	else if (inputIndex >= node.maxInputsCount) { return false; }
	// node.inputs[inputIndex] = xx inputNode;
	// print("setInput % % %\n", node.type, node.inputs, inputNode.inputs);
	connectionCreated := graphNodeConnect(src=inputNode, dest=node, checkCycle=true);
	if connectionCreated == true {
		nodesScene := graphNodeScene(node);
		connection := nodeConnectionAdd(nodesScene, *nodesScene.connections, .{
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
		nodesSceneEmitEvent(graphNodeScene(node), .NODE_CONNECTION_ADDED, connection);
	}

	return connectionCreated;
}
setInput :: (node: BaseNode, inputIndex:u8=0, inputNode: BaseNode, outputIndex:u8=0) -> bool {
	return setInput(*node, inputIndex, *inputNode, outputIndex);
}
removeInput :: (node: *BaseNode, inputIndex:u8=0) -> bool {
	scene := graphNodeScene(node);
	connectionId := nodeConnectionFindByDestNode(*scene.connections, node.nodeId, inputIndex);
	if connectionIdValid(connectionId) {
		connection := scene.connections.connections[connectionId];

		nodesSceneEmitEvent(graphNodeScene(node), .NODE_CONNECTION_REMOVED, connection);

		previousInputNodeId := connection.src.nodeId;
		previousInputNode := scene.nodes[previousInputNodeId];
		graphNodeDisconnect(src=previousInputNode, dest=node);
		nodeConnectionRemove(*scene.connections, connection);
		// node.inputs[inputIndex] = null;
		setDirty(node);

		return true;

	} else {
		return false;
	}

}
setInput :: (node: *BaseNode, inputNode: *BaseNode) {
	setInput(node, 0, inputNode, 0);
}
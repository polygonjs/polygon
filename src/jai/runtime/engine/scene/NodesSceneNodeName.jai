
nodeName :: (nodesScene: *NodesScene, nodeId: NodeId)->string {
	// nodeData := *nodesScene.nodeNames[nodeId];
	// view := array_view(nodeData.array, 0, nodeData.count);
	// str := cast(string)view;
	// return str;

	return stringFixedToString(*nodesScene.nodeNames[nodeId]);
}
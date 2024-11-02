
NullGeoParams :: struct {
}
NullGeoNode :: struct {
	#as using geoNode: GeoNode(NullGeoNode, MergeGeoParams, init);
};

cook :GeoNodeCookMethod: (node: *TYPE, inputs:GeoNodeCookInput)->GeoNodeCookOutput {
	assert(inputs.count > 0, "NullGeoNode::cook not implemented, should have at least one input\n");
	return inputs[0];
}

#scope_file

TYPE :: NullGeoNode;

init :: (_node: *BaseNodeAny) {
	node := cast(*TYPE)_node;
}


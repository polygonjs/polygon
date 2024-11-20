
NullGeoParams :: struct {
}
NullGeoNode :: struct {
	// #as using geoNode: GeoNode(NullGeoNode, MergeGeoParams);
};
nodeInit :: (_node: *TYPE) {

}
registerNullGeoNode :: (){
	nodeRegisterGeo(TYPE, minInputsCount=1, maxInputsCount=1, cook=cook);
}


#scope_file

TYPE :: NullGeoNode;

cook :GeoNodeCookMethod: (scene: *NodesScene, nodeId: NodeId, inputs:GeoNodeCookInput)->GeoNodeCookOutput {
	assert(inputs.count > 0, "NullGeoNode::cook not implemented, should have at least one input\n");
	return inputs[0];
}

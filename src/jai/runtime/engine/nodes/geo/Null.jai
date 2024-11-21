
NullGeoParams :: struct {
}
NullGeoNode :: struct {
	#as using geoNode: GeoNode(NullGeoNode, MergeGeoParams);
};
nodeInit :: (_node: *TYPE) {

}
registerNullGeoNode :: (){
	nodeRegisterGeo(TYPE, minInputsCount=1, maxInputsCount=1);
}

cook :GeoNodeCookMethod: (node: *TYPE, inputs:GeoNodeCookInput)->GeoNodeCookOutput {
	assert(inputs.count > 0, "NullGeoNode::cook not implemented, should have at least one input\n");
	return inputs[0];
}


#scope_file

TYPE :: NullGeoNode;


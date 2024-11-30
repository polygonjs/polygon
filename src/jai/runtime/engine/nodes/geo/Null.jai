
NullGeoParams :: struct {
}
NullGeoNode :: struct {
	#as using geoNode: GeoNode(NullGeoNode, MergeGeoParams);
};
nodeInit :: (node: *TYPE) {
}
registerNullGeoNode :: (){
	nodeRegisterGeo(TYPE, minInputsCount=1, maxInputsCount=1);
}

cook :GeoNodeCookMethod: (node: *TYPE, inputResults:GeoNodeCookInput)->GeoNodeCookOutput {
	nodesScene := graphNodeScene(node);
	inputResult0 := inputResults[0];
	return completeGeoCookWithObjects(nodesScene, xx node, inputResult0);
}


#scope_file

TYPE :: NullGeoNode;


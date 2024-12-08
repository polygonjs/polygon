NullGeoParams :: struct {
}
NullGeoNode :: struct {
	#as using geoNode: GeoNode(NullGeoNode, MergeGeoParams);
};

registerNullGeoNode :: (){
	nodeRegisterGeo(TYPE, minInputsCount=1, maxInputsCount=1);
}

cook :GeoNodeCookMethod: (node: *TYPE, inputResults:GeoNodeCookInput) {
	nodesScene := graphNodeScene(node);
	inputResult0 := inputResults[0];
	completeGeoCookWithObjects(nodesScene, xx node, inputResult0);
}


#scope_file

TYPE :: NullGeoNode;


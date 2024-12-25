NullGeoParams :: struct {
}
NullGeoNode :: struct {
	#as using contextNode: GeoNode(NullGeoNode, NullGeoParams, inputs=.[1,1]);
};

registerNullGeoNode :: () #compile_time {
	nodeRegisterGeo(TYPE);
}

cook :GeoNodeCookMethod: (node: *TYPE, inputResults:GeoNodeCookInput) {
	nodesScene := graphNodeScene(node);
	inputResult0 := inputResults[0];
	completeGeoCookWithObjects(nodesScene, xx node, inputResult0);
}


#scope_file

TYPE :: NullGeoNode;


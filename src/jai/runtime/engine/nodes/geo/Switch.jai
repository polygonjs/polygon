SwitchGeoParams :: struct {
	input: UInt8Param = .{value=0,min=0,max=MAX_INPUTS_COUNT};
}
SwitchGeoNode :: struct {
	#as using geoNode: GeoNode(SwitchGeoNode, SwitchGeoParams);
};

registerSwitchGeoNode :: (){
	nodeRegisterGeo(TYPE, minInputsCount=0, maxInputsCount=MAX_INPUTS_COUNT);
}

nodeCompute :: (scene:*NodesScene, node: *TYPE, depth:u8=0) -> GeoNodeCookOutput {
	return nodeComputeOnlyFromInputParam(scene, node, depth);
}

cook :GeoNodeCookMethod: (node: *TYPE, inputResults:GeoNodeCookInput)->GeoNodeCookOutput {
	inputIndex := inputIndexFromInputParam(node);
	inputResult := inputResults[inputIndex];
	nodesScene := graphNodeScene(node);

	return completeGeoCookWithObjects(nodesScene, xx node, inputResult, storeResult=false);
}



#scope_file

TYPE :: SwitchGeoNode;
MAX_INPUTS_COUNT :: 16;





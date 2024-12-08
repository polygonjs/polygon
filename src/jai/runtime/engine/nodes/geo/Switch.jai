SwitchGeoParams :: struct {
	input: UInt8Param = .{value=0,min=0,max=MAX_INPUTS_COUNT};
}
SwitchGeoNode :: struct {
	#as using geoNode: GeoNode(SwitchGeoNode, SwitchGeoParams);
};

registerSwitchGeoNode :: (){
	nodeRegisterGeo(TYPE, minInputsCount=0, maxInputsCount=MAX_INPUTS_COUNT);
}

nodeComputeInputs :: (scene:*NodesScene, node: *TYPE, target:*[..]NodeId) {
	nodeComputeInputsOnlyFromInputParam(scene, node, target);
}
nodePrepareInputCookResults :: (using scene:*NodesScene, node: *TYPE) {
	_nodePrepareInputCookResultsWithoutClone(scene, node);
}
nodeDisposePreviousCookResults :: (scene:*NodesScene, node: *TYPE) {
}

cook :GeoNodeCookMethod: (node: *TYPE, inputResults:GeoNodeCookInput) {
	inputIndex := inputIndexFromInputParam(node);
	inputResult := inputResults[inputIndex];
	nodesScene := graphNodeScene(node);

	completeGeoCookWithObjects(nodesScene, xx node, inputResult);
}



#scope_file

TYPE :: SwitchGeoNode;
MAX_INPUTS_COUNT :: 16;





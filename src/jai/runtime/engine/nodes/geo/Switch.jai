SwitchGeoParams :: struct {
	input: UInt8Param = .{value=0,min=0,max=MAX_INPUTS_COUNT};
}
SwitchGeoNode :: struct {
	#as using contextNode: GeoNode(SwitchGeoNode, SwitchGeoParams, inputs=.[0, MAX_INPUTS_COUNT]);
};

registerSwitchGeoNode :: () #compile_time {
	nodeRegisterGeo(TYPE);
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
	inputIndex := inputIndexFromInputParam(xx node);
	inputResult := inputResults[inputIndex];
	nodesScene := graphNodeScene(node);

	completeGeoCookWithObjects(nodesScene, xx node, inputResult);
}



#scope_file

TYPE :: SwitchGeoNode;
MAX_INPUTS_COUNT :: 16;





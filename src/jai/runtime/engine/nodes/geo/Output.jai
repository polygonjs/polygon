OutputGeoParams :: struct {
	input: UInt8Param = .{value=0};
}
OutputGeoNode :: struct {
	#as using geoNode: GeoNode(OutputGeoNode, OutputGeoParams);
};


registerOutputGeoNode :: (){
	nodeRegisterGeo(TYPE, minInputsCount=0, maxInputsCount=10);
}

nodeInit :: (node: *TYPE) {
}

nodeCompute :: (scene:*NodesScene, node: *TYPE, depth:u8=0) -> GeoNodeCookOutput {
	return nodeComputeOnlyFromInputParam(scene, node, depth);
}

cook :GeoNodeCookMethod: (node: *TYPE, inputResults:GeoNodeCookInput)->GeoNodeCookOutput {
	inputIndex := inputIndexFromInputParam(node);
	inputResult := inputResults[inputIndex];
	nodesScene := graphNodeScene(node);
	// scene := graphNodeScene(node);
	if inputResult != null {
		sceneObjectsClear(nodesScene.worldScene);
		sceneObjectsAdd(nodesScene.worldScene, <<inputResult);
	} else {
		sceneObjectsClear(nodesScene.worldScene);
	}

	return completeGeoCookWithObjects(nodesScene, xx node, inputResult, storeResult=false);
	// return null;
}



#scope_file

TYPE :: OutputGeoNode;

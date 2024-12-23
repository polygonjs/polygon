OutputGeoParams :: struct {
	input: UInt8Param = .{value=0};
}
OutputGeoNode :: struct {
	#as using geoNode: GeoNode(OutputGeoNode, OutputGeoParams);
};

registerOutputGeoNode :: (){
	nodeRegisterGeo(TYPE, minInputsCount=0, maxInputsCount=10);
}

nodeComputeInputs :: (scene:*NodesScene, node: *TYPE, target:*[..]NodeId) {
	nodeComputeInputsOnlyFromInputParam(scene, node, target);
}
nodePrepareInputCookResults :: (using scene:*NodesScene, node: *TYPE) {
	_nodePrepareInputCookResultsWithoutClone(scene, node);
}
nodeDisposePreviousCookResults :: (scene:*NodesScene, node: *TYPE) {
}
// nodeCompute :: (scene:*NodesScene, node: *TYPE, depth:u8=0) -> GeoNodeCookOutput {
// 	return nodeComputeOnlyFromInputParam(scene, node, depth);
// }

cook :GeoNodeCookMethod: (node: *TYPE, inputResults:GeoNodeCookInput) {
	inputIndex := inputIndexFromInputParam(node);
	inputResult := inputResults[inputIndex];
	nodesScene := graphNodeScene(node);
	if inputResult != null {
		if _objectChanged(nodesScene.worldScene, inputResult) {
			sceneObjectsClear(nodesScene.worldScene);
			sceneObjectsAdd(nodesScene.worldScene, <<inputResult);
		}
	} else {
		sceneObjectsClear(nodesScene.worldScene);
	}

	completeGeoCookWithObjects(nodesScene, xx node, inputResult);
}



#scope_file

TYPE :: OutputGeoNode;

_objectChanged :: (worldScene:*Scene, objects: *[..]*Object3D)->bool {
	if worldScene.children.count != objects.count {
		return true;
	}
	for sceneChild, i: worldScene.children {
		if sceneChild.id != (<<objects)[i].id {
			return true;
		}
	}
	return false;
}

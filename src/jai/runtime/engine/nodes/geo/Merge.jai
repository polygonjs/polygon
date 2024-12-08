
MergeGeoParams :: struct {
}
MergeGeoNode :: struct {
	#as using geoNode: GeoNode(MergeGeoNode, MergeGeoParams);
};

registerMergeGeoNode :: (){
	nodeRegisterGeo(TYPE, minInputsCount=1, maxInputsCount=128);
}

cook :GeoNodeCookMethod: (node: *TYPE, inputResults:GeoNodeCookInput) {
	nodesScene := graphNodeScene(node);
	mesh := newObject3D(nodesScene.worldScene, Mesh);
	meshSetMaterial(nodesScene.worldScene, mesh, xx nodesScene.defaultMaterial.mesh);

	print("MergeGeoNode::cook not implemented\n");

	completeGeoCookWithObject(nodesScene, xx node, mesh);
}




#scope_file

TYPE :: MergeGeoNode;


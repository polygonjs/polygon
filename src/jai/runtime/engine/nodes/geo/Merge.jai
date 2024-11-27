
MergeGeoParams :: struct {
}
MergeGeoNode :: struct {
	#as using geoNode: GeoNode(MergeGeoNode, MergeGeoParams);
};
nodeInit :: (node: *TYPE) {
}
registerMergeGeoNode :: (){
	nodeRegisterGeo(TYPE, minInputsCount=1, maxInputsCount=128);
}

cook :GeoNodeCookMethod: (node: *TYPE, inputResults:GeoNodeCookInput)->GeoNodeCookOutput {
	mesh := newObject3D(graphNodeScene(node).worldScene, Mesh);
	mesh.material = xx graphNodeScene(node).defaultMaterial.mesh;

	print("MergeGeoNode::cook not implemented\n");

	return mesh;
}




#scope_file

TYPE :: MergeGeoNode;


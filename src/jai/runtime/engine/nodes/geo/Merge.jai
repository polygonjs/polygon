
MergeGeoParams :: struct {
}
MergeGeoNode :: struct {
	#as using contextNode: GeoNode(MergeGeoNode, MergeGeoParams, inputs=.[1, MAX_INPUTS_COUNT]);
};

registerMergeGeoNode :: () #compile_time {
	nodeRegisterGeo(TYPE);
}

cook :GeoNodeCookMethod: (node: *TYPE, inputResults:GeoNodeCookInput) {
	nodesScene := graphNodeScene(node);
	mesh := newObject3D(*nodesScene.worldScene, Mesh);
	meshSetMaterial(*nodesScene.worldScene, mesh, xx *nodesScene.defaultMaterial.mesh);

	print("MergeGeoNode::cook not implemented\n");

	completeGeoCookWithObject(nodesScene, xx node, mesh);
}




#scope_file

TYPE :: MergeGeoNode;
MAX_INPUTS_COUNT :: 128;


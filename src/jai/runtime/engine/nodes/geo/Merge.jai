
MergeGeoParams :: struct {
}
MergeGeoNode :: struct {
	#as using geoNode: GeoNode(MergeGeoNode, MergeGeoParams);
};
nodeInit :: (node: *TYPE) {
}

cook :GeoNodeCookMethod: (node: *TYPE, inputs:GeoNodeCookInput)->GeoNodeCookOutput {
	mat := newMaterial(NormalMeshMaterial);
	mesh := newObject3D(Mesh);

	print("MergeGeoNode::cook not implemented\n");

	return mesh;
}

#scope_file

TYPE :: MergeGeoNode;




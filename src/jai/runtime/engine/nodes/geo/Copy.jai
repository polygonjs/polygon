
CopyGeoParams :: struct {
	count: UInt8Param = .{value=2};
	t: Vector3Param = .{value=.{1,1,1}};
	r: Vector3Param = .{value=.{1,1,1}};
	s: Vector3Param = .{value=.{1,1,1}};
}
CopyGeoNode :: struct {
	#as using geoNode: GeoNode(CopyGeoNode, CopyGeoParams);
};

registerCopyGeoNode :: (){
	nodeRegisterGeo(TYPE, minInputsCount=0, maxInputsCount=1);
}

cook :GeoNodeCookMethod: (node: *TYPE, inputResults:GeoNodeCookInput) -> GeoNodeCookOutput {
	nodesScene := graphNodeScene(node);
	mesh := newMesh( nodesScene.worldScene, Mesh);


	return completeGeoCookWithObject(nodesScene, xx node, mesh);
}


#scope_file

TYPE :: CopyGeoNode;



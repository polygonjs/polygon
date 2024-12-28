
CopyGeoParams :: struct {
	count: UInt8Param = .{value=2};
	t: Vector3Param = .{value=.{1,1,1}};
	r: Vector3Param = .{value=.{1,1,1}};
	s: Vector3Param = .{value=.{1,1,1}};
}
CopyGeoNode :: struct {
	#as using contextNode: GeoNode(CopyGeoNode, CopyGeoParams, inputs=.[0,1]);
};

registerCopyGeoNode :: () #compile_time {
	nodeRegisterGeo(TYPE);
}

cook :GeoNodeCookMethod: (node: *TYPE, inputResults:GeoNodeCookInput) {
	nodesScene := graphNodeScene(node);
	mesh := newMesh( *nodesScene.worldScene, Mesh);
	completeGeoCookWithObject(nodesScene, xx node, mesh);
}


#scope_file

TYPE :: CopyGeoNode;



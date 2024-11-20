
IcosahedronGeoParams :: struct {
	radius: FloatParam = .{value=1};
	detail: UIntegerParam = .{value=2};
}
IcosahedronGeoNode :: struct {
	// #as using geoNode: GeoNode(IcosahedronGeoNode, IcosahedronGeoParams);
};

registerIcosahedronGeoNode :: (){
	nodeRegisterGeo(TYPE, minInputsCount=0, maxInputsCount=1, cook=cook);
}
nodeInit :: (node: *TYPE) {
}

#scope_file

TYPE :: IcosahedronGeoNode;

cook :GeoNodeCookMethod: (scene: *NodesScene, node: NodeId, inputs:GeoNodeCookInput)->GeoNodeCookOutput {
	// mat := newMaterial(NormalMeshMaterial);
	// mesh := newObject3D(Mesh);

	// using node.p;
	// geometry_icosahedron_attributes_set(mesh.geometry, .{
	// 	radius = radius.value,
	// 	detail = detail.value
	// });
	// geometry_attributes_validate(mesh.geometry);
	// normals_compute(mesh.geometry);

	// mesh.material = xx mat;
	// mesh.position = .{x = 0.0, y = 0.0, z = 0.0};
	// transformable_update_matrix(mesh);

	// return mesh;
	return null;
}



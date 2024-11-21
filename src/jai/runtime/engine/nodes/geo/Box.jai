
BoxGeoParams :: struct {
	size: Vector3Param = .{value=.{1,1,1}};
	scale: FloatParam = .{value=1};
	segments: Vector3UIntParam = .{value=.{1,1,1}};
}
BoxGeoNode :: struct {
	#as using geoNode: GeoNode(BoxGeoNode, BoxGeoParams);
};


registerBoxGeoNode :: (){
	nodeRegisterGeo(TYPE, minInputsCount=0, maxInputsCount=1);
}

nodeInit :: (node: *TYPE) {
}


cook :GeoNodeCookMethod: (node: *TYPE, inputs:GeoNodeCookInput) -> GeoNodeCookOutput {
	// node := cast(*TYPE)scene.nodeTypes[nodeId];
	mat := newMaterial(NormalMeshMaterial);
	mesh := newObject3D(Mesh);

	using node.p;
	geometry_box_attributes_set(mesh.geometry, .{
		size = mult(size.value, scale.value),
		segments = segments.value
	});
	geometry_attributes_validate(mesh.geometry);
	normals_compute(mesh.geometry);

	mesh.material = xx mat;
	mesh.position = .{x = 0.0, y = 0.0, z = 0.0};
	transformable_update_matrix(mesh);

	return mesh;
	// return null;
}


#scope_file

TYPE :: BoxGeoNode;



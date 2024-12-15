
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

cook :GeoNodeCookMethod: (node: *TYPE, inputResults:GeoNodeCookInput) {
	nodesScene := graphNodeScene(node);
	mesh := newMesh( nodesScene.worldScene, Mesh);

	using node.p;
	geometry_box_attributes_set(mesh.geometry, .{
		size = mult(size.value, scale.value),
		segments = segments.value
	});
	geometryAttributesValidate(mesh.geometry);
	normals_compute(mesh.geometry);

	meshSetMaterial(nodesScene.worldScene, mesh, xx nodesScene.defaultMaterial.mesh);
	mesh.position = .{x = 0.0, y = 0.0, z = 0.0};
	transformableUpdateMatrix(mesh);

	completeGeoCookWithObject(nodesScene, xx node, mesh);
}


#scope_file

TYPE :: BoxGeoNode;




IcosahedronGeoParams :: struct {
	radius: FloatParam = .{value=1};
	detail: UIntegerParam = .{value=2};
}
IcosahedronGeoNode :: struct {
	#as using contextNode: GeoNode(IcosahedronGeoNode, IcosahedronGeoParams, inputs=.[0,1]);
};

registerIcosahedronGeoNode :: () #compile_time {
	nodeRegisterGeo(TYPE);
}

cook :GeoNodeCookMethod: (node: *TYPE, inputResults:GeoNodeCookInput) {
	nodesScene := graphNodeScene(node);
	mesh := newMesh(nodesScene.worldScene, Mesh);
	// mesh.use_compute = true;

	using node.p;
	geometry_icosahedron_attributes_set(mesh.geometry, .{
		radius = radius.value,
		detail = detail.value
	});
	geometryAttributesValidate(mesh.geometry);
	normals_compute(mesh.geometry);

	meshSetMaterial(nodesScene.worldScene, mesh, xx *nodesScene.defaultMaterial.mesh);
	mesh.position = .{x = 0.0, y = 0.0, z = 0.0};
	transformableUpdateMatrix(mesh);

	completeGeoCookWithObject(nodesScene, xx node, mesh);
}


#scope_file

TYPE :: IcosahedronGeoNode;





AddGeoParams :: struct {
	position: Vector3Param = .{value=.{0,0,0}};
}
AddGeoNode :: struct {
	#as using contextNode: GeoNode(AddGeoNode, AddGeoParams, inputs=.[0,0]);
};

registerAddGeoNode :: () #compile_time {
	nodeRegisterGeo(TYPE);
}

cook :GeoNodeCookMethod: (node: *TYPE, inputResults:GeoNodeCookInput) {
	nodesScene := graphNodeScene(node);
	mesh := newMesh( nodesScene.worldScene, Mesh);

	using node.p;

	geometry := mesh.geometry;
	array_reset(*geometry.attributes.position.values);
	array_reset(*geometry.attributes.normal.values);
	array_reset(*geometry.attributes.uv.values);
	array_reset(*geometry.indices);

	array_add(*geometry.attributes.position.values, position.value);

	array_add(*geometry.attributes.normal.values, .{0,0,0});
	array_add(*geometry.attributes.uv.values, .{0,0});

	array_add(*geometry.indices, 0);

	meshSetMaterial(nodesScene.worldScene, mesh, xx nodesScene.defaultMaterial.point);
	mesh.position = .{x = 0.0, y = 0.0, z = 0.0};
	transformableUpdateMatrix(mesh);

	completeGeoCookWithObject(nodesScene, xx node, mesh);
}


#scope_file

TYPE :: AddGeoNode;



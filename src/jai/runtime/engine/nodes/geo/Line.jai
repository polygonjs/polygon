
LineGeoParams :: struct {
	origin: Vector3Param = .{value=.{0,0,0}};
	direction: Vector3Param = .{value=.{1,1,1}};
	scale: FloatParam = .{value=1};
	segments: UIntegerParam = .{value=1};
}
LineGeoNode :: struct {
	#as using contextNode: GeoNode(LineGeoNode, LineGeoParams, inputs=.[0,0]);
};

registerLineGeoNode :: () #compile_time {
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

	array_add(*geometry.attributes.position.values, origin.value);
	array_add(*geometry.attributes.position.values, direction.value);

	array_add(*geometry.attributes.normal.values, .{0,0,0});
	array_add(*geometry.attributes.normal.values, .{0,0,0});
	array_add(*geometry.attributes.uv.values, .{0,0});
	array_add(*geometry.attributes.uv.values, .{0,0});

	array_add(*geometry.indices, 0);
	array_add(*geometry.indices, 1);

	meshSetMaterial(nodesScene.worldScene, mesh, xx *nodesScene.defaultMaterial.line);
	mesh.position = .{x = 0.0, y = 0.0, z = 0.0};
	transformableUpdateMatrix(mesh);

	completeGeoCookWithObject(nodesScene, xx node, mesh);
}


#scope_file

TYPE :: LineGeoNode;



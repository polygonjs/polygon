
BoxGeoParams :: struct {
	size: Vector3Param = .{value=.{1,1,1}};
	scale: FloatParam = .{value=1};
	segments: Vector3UIntParam = .{value=.{1,1,1}};
}
BoxGeoNode :: struct {
	#as using contextNode: GeoNode(BoxGeoNode, BoxGeoParams, inputs=.[0,1]);
};

registerBoxGeoNode :: () #compile_time {
	nodeRegisterGeo(TYPE);
}

cook :GeoNodeCookMethod: (node: *TYPE, inputResults:GeoNodeCookInput) {
	nodesScene := graphNodeScene(node);
	mesh := newMesh( nodesScene.worldScene, Mesh);

	using node.p;
	geometryBoxAttributesSet(mesh.geometry, .{
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



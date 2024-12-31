
PlaneGeoParams :: struct {
	size: Vector2Param = .{value=.{1,1}};
	scale: FloatParam = .{value=1};
	segments: Vector2UIntParam = .{value=.{1,1}};
}
PlaneGeoNode :: struct {
	#as using contextNode: GeoNode(PlaneGeoNode, PlaneGeoParams, inputs=.[0,1]);
};

registerPlaneGeoNode :: () #compile_time {
	nodeRegisterGeo(TYPE);
}

cook :GeoNodeCookMethod: (node: *TYPE, inputResults:GeoNodeCookInput) {
	nodesScene := graphNodeScene(node);
	mesh := newMesh( *nodesScene.worldScene, Mesh);

	using node.p;
	geometryPlaneAttributesSet(mesh.geometry, .{
		size = mult(size.value, scale.value),
		segments = segments.value
	});
	geometryAttributesValidate(mesh.geometry);
	normals_compute(mesh.geometry);

	meshSetMaterial(*nodesScene.worldScene, mesh, xx *nodesScene.defaultMaterial.basicTexture);//.uv);
	mesh.position = .{x = 0.0, y = 0.0, z = 0.0};
	transformableUpdateMatrix(mesh);

	completeGeoCookWithObject(nodesScene, xx node, mesh);
}


#scope_file

TYPE :: PlaneGeoNode;



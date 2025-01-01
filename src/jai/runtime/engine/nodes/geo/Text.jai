
TextGeoParams :: struct {
	text: StringParam;
	size: FloatParam = .{value=1};
}
TextGeoNode :: struct {
	#as using contextNode: GeoNode(TextGeoNode, TextGeoParams, inputs=.[0,0]);
};

registerTextGeoNode :: () #compile_time {
	nodeRegisterGeo(TYPE);
}

cook :GeoNodeCookMethod: (node: *TYPE, inputResults:GeoNodeCookInput) {
	nodesScene := graphNodeScene(node);

	textValue := stringFixedToString(node.p.text.value);
	mesh := newMesh( *nodesScene.worldScene, Mesh);
	textMeshUpdate(nodesScene, textValue, mesh);
	
	mesh.position = .{x = 0.0, y = 0.0, z = 0.0};
	transformableUpdateMatrix(mesh);

	completeGeoCookWithObject(nodesScene, xx node, mesh);
}


#scope_file

TYPE :: TextGeoNode;



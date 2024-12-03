
FileSTLGeoParams :: struct {
	path: StringParam = .{value=""};
}
FileSTLGeoNode :: struct {
	#as using geoNode: GeoNode(FileSTLGeoNode, FileSTLGeoParams);
};

registerFileSTLGeoNode :: (){
	nodeRegisterGeo(TYPE, minInputsCount=0, maxInputsCount=0);
}

cook :GeoNodeCookMethod: (node: *TYPE, inputResults:GeoNodeCookInput) -> GeoNodeCookOutput {
	nodesScene := graphNodeScene(node);

	fileContent, success := read_entire_file(node.p.path.value,, temp);

	mesh := parseSTL( nodesScene, fileContent);

	geometryAttributesValidate(mesh.geometry);
	normals_compute(mesh.geometry);

	meshSetMaterial(nodesScene.worldScene, mesh, xx nodesScene.defaultMaterial.mesh);
	mesh.position = .{x = 0.0, y = 0.0, z = 0.0};
	transformable_update_matrix(mesh);

	return completeGeoCookWithObject(nodesScene, xx node, mesh);
}


#scope_file

TYPE :: FileSTLGeoNode;


#import "File";

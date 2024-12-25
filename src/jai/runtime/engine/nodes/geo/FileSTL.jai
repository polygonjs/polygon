
FileSTLGeoParams :: struct {
	path: StringParam;
}
FileSTLGeoNode :: struct {
	#as using contextNode: GeoNode(FileSTLGeoNode, FileSTLGeoParams, inputs=.[0,0]);
};

registerFileSTLGeoNode :: () #compile_time {
	nodeRegisterGeo(TYPE);
}

cook :GeoNodeCookMethod: (node: *TYPE, inputResults:GeoNodeCookInput) {
	nodesScene := graphNodeScene(node);

	urlOrPath := stringFixedToString(node.p.path.value);
	#if WASM {
		sceneAddNodeRequest(nodesScene, node, urlOrPath);
	} else {
		fileContent, success := read_entire_file(urlOrPath,, temp);
		parseData( node, fileContent);
	}

}

parseData :: (node:*TYPE, fileContent: string) {
	nodesScene := graphNodeScene(node);
	mesh := parseSTL( nodesScene, fileContent);
	// print("parseData done\n");

	using node.p;
	geometryAttributesValidate(mesh.geometry);
	normals_compute(mesh.geometry);

	meshSetMaterial(nodesScene.worldScene, mesh, xx nodesScene.defaultMaterial.mesh);
	mesh.position = .{x = 0.0, y = 0.0, z = 0.0};
	transformableUpdateMatrix(mesh);

	completeGeoCookWithObject(nodesScene, xx node, mesh);
}


#scope_file

TYPE :: FileSTLGeoNode;



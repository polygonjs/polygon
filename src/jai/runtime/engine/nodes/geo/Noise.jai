
NoiseGeoParams :: struct {
	amp: FloatParam = .{value=1};
	freq: Vector3Param = .{value=.{1,1,1}};
	offset: Vector3Param = .{value=.{0,0,0}};
}
NoiseGeoNode :: struct {
	#as using geoNode: GeoNode(NoiseGeoNode, NoiseGeoParams);
};

registerNoiseGeoNode :: (){
	nodeRegisterGeo(TYPE, minInputsCount=1, maxInputsCount=1);
}

cook :GeoNodeCookMethod: (node: *TYPE, inputResults:GeoNodeCookInput)->GeoNodeCookOutput {
	nodesScene := graphNodeScene(node);
	inputResult0 := inputResults[0];

	{
		using node.p;
		for object: <<inputResult0 {
			if object.type == Mesh {
				mesh := cast(*Mesh)object;
				geometry_add_noise(mesh.geometry, .{
					amp = amp.value,
					freq = freq.value,
					offset = offset.value
				});
			}
		}
	}

	return completeGeoCookWithObjects(nodesScene, xx node, inputResult0);
}



#scope_file

TYPE :: NoiseGeoNode;


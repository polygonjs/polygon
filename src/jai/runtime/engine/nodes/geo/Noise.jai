
NoiseGeoParams :: struct {
	amp: FloatParam = .{value=1};
	freq: Vector3Param = .{value=.{1,1,1}};
	offset: Vector3Param = .{value=.{0,0,0}};
}
NoiseGeoNode :: struct {
	#as using contextNode: GeoNode(NoiseGeoNode, NoiseGeoParams, inputs=.[1,1]);
};

registerNoiseGeoNode :: () #compile_time {
	nodeRegisterGeo(TYPE);
}

cook :GeoNodeCookMethod: (node: *TYPE, inputResults:GeoNodeCookInput) {
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
				print("noise computed: %\n", offset.value.x);
			}
		}
	}

	completeGeoCookWithObjects(nodesScene, xx node, inputResult0);
}



#scope_file

TYPE :: NoiseGeoNode;

NoiseParams :: struct {
	amp:float;
	freq: Vector3;
	offset: Vector3;
}
geometry_add_noise :: (geometry: *Geometry, using params: NoiseParams) {
	{
		position := *geometry.attributes.position;
		normal := *geometry.attributes.normal;
		for position.values {
			noiseValue := perlin_noise(
				(it.x+offset.x)*freq.x,
				(it.y+offset.y)*freq.y,
				(it.z+offset.z)*freq.z
			);
			position.values[it_index] += normal.values[it_index] * amp * noiseValue;
		}
	}
	normals_compute(geometry);
}


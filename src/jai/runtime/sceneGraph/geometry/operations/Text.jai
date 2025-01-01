textMeshUpdate :: (nodesScene: *NodesScene, text: string, mesh: *Mesh) {

	charsCount := text.count;
	pointsPerQuad :: 4;
	indicesPerQuad :u32: 6;
	pointsCount := charsCount*pointsPerQuad;
	indicesCount := charsCount*indicesPerQuad;
	geometrySetPointsCount(mesh.geometry, pointsCount);
	geometrySetIndicesCount(mesh.geometry, indicesCount);


	// print("text = %, %, %, %\n", textValue, textValue.count, pointsCount, indicesCount);
	
	for char,ic: text {

		{
			using mesh.geometry.attributes;
			pointIndex := ic*pointsPerQuad + 0;
			position.values[pointIndex] = .{xx (ic+0), 1, 0};
			uv.values[pointIndex] = fontTextureCharacterUv(char, .{0,0});
			// print("pointIndex=%, uv=%\n", pointIndex, uv.values[pointIndex]);

			pointIndex = ic*pointsPerQuad + 1;
			position.values[pointIndex] = .{xx (ic+1), 1, 0};
			uv.values[pointIndex] = fontTextureCharacterUv(char, .{1,0});
			// print("pointIndex=%, uv=%\n", pointIndex, uv.values[pointIndex]);

			pointIndex = ic*pointsPerQuad + 2;
			position.values[pointIndex] = .{xx (ic+1), 0, 0};
			uv.values[pointIndex] = fontTextureCharacterUv(char, .{1,1});
			// print("pointIndex=%, uv=%\n", pointIndex, uv.values[pointIndex]);

			pointIndex = ic*pointsPerQuad + 3;
			position.values[pointIndex] = .{xx (ic+0), 0, 0};
			uv.values[pointIndex] = fontTextureCharacterUv(char, .{0,1});
			// print("pointIndex=%, uv=%\n", pointIndex, uv.values[pointIndex]);
		}
		{
			using mesh.geometry;
			c32 :u32= xx ic;
			indices[c32*indicesPerQuad+0] = c32*pointsPerQuad + 0;
			indices[c32*indicesPerQuad+1] = c32*pointsPerQuad + 1;
			indices[c32*indicesPerQuad+2] = c32*pointsPerQuad + 2;
			indices[c32*indicesPerQuad+3] = c32*pointsPerQuad + 2;
			indices[c32*indicesPerQuad+4] = c32*pointsPerQuad + 3;
			indices[c32*indicesPerQuad+5] = c32*pointsPerQuad + 0;
		}

	}
	{
		using mesh.geometry.attributes;
		for 0..(pointsCount-1){
			normal.values[it] = .{0,0,1};
		}
	}

	geometryAttributesValidate(mesh.geometry);

	meshSetMaterial(*nodesScene.worldScene, mesh, xx *nodesScene.defaultMaterial.fontTexture);

}
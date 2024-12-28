
parseSTL :: (nodesScene:*NodesScene, fileContent: string)->*Mesh {
	mesh := newMesh( *nodesScene.worldScene, Mesh);

	colorFound := false;
	for 0..(HEADER_SIZE-1){
		if 	fileContent.data[it+0] == #char "C" &&
			fileContent.data[it+1] == #char "O" &&
			fileContent.data[it+2] == #char "L" &&
			fileContent.data[it+3] == #char "O" &&
			fileContent.data[it+4] == #char "R" &&
			fileContent.data[it+5] == #char "=" {
			colorFound = true;
			break;
		}
	}
	facesCountP :*FACE_COUNT_TYPE= xx (fileContent.data+HEADER_SIZE);
	facesCount := <<facesCountP;
	pointsCount := facesCount * 3;
	indicesCount := facesCount * 3;
	// print("facesCount %, pointsCount %\n", facesCount, pointsCount);

	{
		using mesh.geometry;
		array_resize(*attributes.position.values, pointsCount, false);
		array_resize(*attributes.normal.values, pointsCount, false);
		array_resize(*attributes.uv.values, pointsCount, false);
		array_resize(*indices, indicesCount, false);

		for 0..(facesCount-1) {
			faceStart := HEADER_SIZE + size_of(FACE_COUNT_TYPE) + it * FACE_SIZE;
			normalP :*Vector3= xx (fileContent.data + faceStart);
			normal := <<normalP;

			position0P :*Vector3= xx (fileContent.data + faceStart + size_of(Vector3));
			position0 := <<position0P;

			position1P :*Vector3= xx (fileContent.data + faceStart + size_of(Vector3) * 2);
			position1 := <<position1P;

			position2P :*Vector3= xx (fileContent.data + faceStart + size_of(Vector3) * 3);
			position2 := <<position2P;

			attributes.normal.values[it*3+0] = normal;
			attributes.normal.values[it*3+1] = normal;
			attributes.normal.values[it*3+2] = normal;
			attributes.position.values[it*3+0] = position0;
			attributes.position.values[it*3+1] = position1;
			attributes.position.values[it*3+2] = position2;
			indices[it*3+0] = it*3+0;
			indices[it*3+1] = it*3+1;
			indices[it*3+2] = it*3+2;
		}
	}
	return mesh;
}

#scope_file

// A valid binary STL buffer should consist of the following elements, in order:
// 1) 80 byte header
// 2) 4 byte face count
// 3) 50 bytes per face
HEADER_SIZE :: 80;
FACE_COUNT_TYPE :: u32;
FACE_SIZE :: 50;
isBinarySTL :: (data: *u8, size: s64)->bool {
	if size < 84 { return false; }
	facecount_pos := data + 80;
	faceCount :u32= 0;
	memcpy(*faceCount, facecount_pos, size_of(u32));
	expectedBinaryFileSize := faceCount * 50 + 84;
	return expectedBinaryFileSize == size;
}
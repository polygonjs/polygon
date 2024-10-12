IcosahedronGeometryParams :: struct {
	radius: float = 1.0;
	detail: u32 = 0;  // 0 for basic icosahedron, higher for more detail
}

geometry_icosahedron_attributes_set :: (geometry: *Geometry, params: IcosahedronGeometryParams) {
	t := (1.0 + sqrt(5.0)) / 2.0;

	// Define the 12 vertices of the icosahedron
	BASE_POSITIONS := Vector3.[
		.{-1,  t,  0}, .{ 1,  t,  0}, .{-1, -t,  0}, .{ 1, -t,  0},
		.{ 0, -1,  t}, .{ 0,  1,  t}, .{ 0, -1, -t}, .{ 0,  1, -t},
		.{ t,  0, -1}, .{ t,  0,  1}, .{-t,  0, -1}, .{-t,  0,  1}
	];

	positions: [..]Vector3;
	indices: [..]VertexIndex;
	array_reserve(*positions, BASE_POSITIONS.count);
	indices_count := BASE_INDICES.count * (xx pow(xx 4, xx params.detail) );
	print("expected index_count:u32=%;\n", indices_count);
	array_reserve(*indices, indices_count);

	// Initialize with base positions
	for v: BASE_POSITIONS array_add(*positions, v);

	// Subdivide faces
	subdivide_faces :: (v1: Vector3, v2: Vector3, v3: Vector3, detail: u32, positions: *[..]Vector3, indices: *[..]VertexIndex) {
		if detail == 0 {
			{
				found, index := array_find_ptr(positions, v1);
				array_add(indices, xx index);
			}
			{
				found, index := array_find_ptr(positions, v2);
				array_add(indices, xx index);
			}
			{
				found, index := array_find_ptr(positions, v3);
				array_add(indices, xx index);
			}
		} else {
			v12 := normalize((v1 + v2) * 0.5);
			v23 := normalize((v2 + v3) * 0.5);
			v31 := normalize((v3 + v1) * 0.5);

			if array_find_ptr(positions, v12)==false array_add(positions, v12);
			if array_find_ptr(positions, v23)==false array_add(positions, v23);
			if array_find_ptr(positions, v31)==false array_add(positions, v31);

			subdivide_faces(v1,  v12, v31, detail - 1, positions, indices);
			subdivide_faces(v2,  v23, v12, detail - 1, positions, indices);
			subdivide_faces(v3,  v31, v23, detail - 1, positions, indices);
			subdivide_faces(v12, v23, v31, detail - 1, positions, indices);
		}
	}

	// Perform subdivision
	i:=0;
	while i <= BASE_INDICES.count-1 {
		v1 := BASE_POSITIONS[BASE_INDICES[i]];
		v2 := BASE_POSITIONS[BASE_INDICES[i+1]];
		v3 := BASE_POSITIONS[BASE_INDICES[i+2]];
		subdivide_faces(v1, v2, v3, params.detail, *positions, *indices);
		i+=3;
	}

	vertexCount := positions.count;
	indexCount := indices.count;

	// Resize geometry arrays
	array_resize(*geometry.attributes.position.values, vertexCount, false);
	array_resize(*geometry.attributes.normal.values, vertexCount, false);
	array_resize(*geometry.indices, indexCount, false);

	// Set positions and normals
	for position, i: positions {
		normalized := normalize(position);
		geometry.attributes.position.values[i] = normalized * params.radius;
		geometry.attributes.normal.values[i] = normalized;
	}

	// Set indices
	memcpy(geometry.indices.data, indices.data, size_of(VertexIndex) * indexCount);

	// Generate simple UV coordinates (optional)
	array_resize(*geometry.attributes.uv.values, vertexCount, false);
	for i: 0..vertexCount-1 {
		pos := geometry.attributes.position.values[i];
		u := 0.5 + atan2(pos.z, pos.x) / (2 * PI);
		v := 0.5 - asin(pos.y) / PI;
		geometry.attributes.uv.values[i] = .{u, v};
	}

	print("points_count:u64=%;\n", positions.count);
	print("index_count:u32=%;\n", indices.count);
	// Clean up temporary arrays
	array_free(positions);
	array_free(indices);
}

#scope_file



// Define the 20 faces of the icosahedron
BASE_INDICES :: u32.[
	0, 11, 5,    0, 5, 1,    0, 1, 7,    0, 7, 10,   0, 10, 11,
	1, 5, 9,     5, 11, 4,   11, 10, 2,  10, 7, 6,   7, 1, 8,
	3, 9, 4,     3, 4, 2,    3, 2, 6,    3, 6, 8,    3, 8, 9,
	4, 9, 5,     2, 4, 11,   6, 2, 10,   8, 6, 7,    9, 8, 1
];
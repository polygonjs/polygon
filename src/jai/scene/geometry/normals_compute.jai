INDICES_PER_FACE :s64 = 3;
normals_compute :: (geometry : *Geometry) -> void {
	faces_count :u32= xx (geometry.indices.count / 3);

	using geometry.attributes;
	memset(normal.values.data, 0, normal.values.count * size_of(Vector3)); // reset normals

	for 0..(faces_count-1) {

		vertex_0 := geometry.indices[ it*3 ];
		vertex_1 := geometry.indices[ it*3 + 1 ];
		vertex_2 := geometry.indices[ it*3 + 2 ];

		position_0 := position.values[vertex_0];
		position_1 := position.values[vertex_1];
		position_2 := position.values[vertex_2];

		cb := position_2 - position_1;
		ab := position_0 - position_1;
		cc := cross(cb, ab);

		normal.values[vertex_0] += cc;
		normal.values[vertex_1] += cc;
		normal.values[vertex_2] += cc;
	}

	normals_normalize(geometry);
}

normals_normalize :: (geometry : *Geometry) {
	using geometry.attributes;
	for 0..(normal.values.count-1) {
		normal.values[it] = normalize(normal.values[it]);
	}
}
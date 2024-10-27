// inspired from threejs's polyhedron.js ( https://github.com/mrdoob/three.js/blob/dev/src/geometries/PolyhedronGeometry.js )
PolyhedronGeometryParams :: struct {
	positions: []Vector3;
	indices: []VertexIndex;
	radius: float = 1.0;
	detail: u32 = 0;
}

geometry_polyhedron_attributes_set :: (geometry: *Geometry, params: PolyhedronGeometryParams) {
	array_reset(*geometry.attributes.position.values);
	array_reset(*geometry.indices);

	subdivide(geometry, params);
	generate_indices(geometry);

	points_count := geometry.attributes.position.values.count;
	array_resize(*geometry.attributes.normal.values, points_count);
	array_resize(*geometry.attributes.uv.values, points_count);

	apply_radius(geometry, params.radius);
	normalize_normals(geometry);
	generate_uvs(geometry);

	indices_count := geometry.indices.count;
	print("polyhedron points_count:u64=%;\n", points_count);
	print("polyhedron index_count:u64=%;\n", indices_count);
}

#scope_file

Vector3Array :: [..]Vector3;
Vector3ArrayArray :: []*Vector3Array;

subdivide :: (geometry: *Geometry, params: PolyhedronGeometryParams) {
	i:=0;
	while i <= params.indices.count-1 {
		a := params.positions[params.indices[i]];
		b := params.positions[params.indices[i+1]];
		c := params.positions[params.indices[i+2]];
		subdivide_face(geometry, a, b, c, params.detail);
		i+=3;
	}
}

subdivide_face :: (geometry: *Geometry, a: Vector3, b: Vector3, c: Vector3, detail: u32) {
	cols := detail + 1;
	v :Vector3ArrayArray= NewArray(cols+1, *Vector3Array);
	for i:0..cols {

		rows := cols - i;
		vi := New(Vector3Array);
		array_resize(vi, rows+1);
		v[i] = vi;

		aj := lerp(a, c, cast(float)i / cast(float)cols);
		bj := lerp(b, c, cast(float)i / cast(float)cols);

		for j:0..rows {
			if (j == 0 && i == cols) {
				(<<vi)[j] = aj;
			} else {
				(<<vi)[j] = lerp(aj, bj, cast(float)j / cast(float)rows);
			}
		}
	}
	for i:0..cols-1 {
		j_count := 2 * (cols - i) - 1;
		for j:0..j_count-1 {
			k :u32= xx floor(cast(float)j / 2);
			if (j % 2 == 0) {
				push_vertex(geometry, (<<v[i])[k + 1]);
				push_vertex(geometry, (<<v[i + 1])[k]);
				push_vertex(geometry, (<<v[i])[k]);
			} else {
				push_vertex(geometry, (<<v[i])[k + 1]);
				push_vertex(geometry, (<<v[i + 1])[k + 1]);
				push_vertex(geometry, (<<v[i + 1])[k]);
			}
		}
	}
}

push_vertex :: (geometry: *Geometry, vertex: Vector3) {
	array_add(*geometry.attributes.position.values, vertex);
}

apply_radius :: (geometry: *Geometry, radius: float) {
	for position: geometry.attributes.position.values {
		geometry.attributes.position.values[it_index] = normalize(position) * radius;
	}
}

generate_uvs :: (geometry: *Geometry) {
	using geometry.attributes;
	for position: position.values {
		u := azimuth(position) / (2 * PI) + 0.5;
		v := inclination(position) / PI + 0.5;
		uv.values[it_index] = .{u, 1 - v};
	}
	correct_uvs(geometry);
	correct_seam(geometry);
}

azimuth :: (vector: Vector3) -> float {
	return atan2(vector.z, -vector.x);
}

inclination :: (vector: Vector3) -> float {
	return atan2(-vector.y, sqrt(vector.x * vector.x + vector.z * vector.z));
}

correct_uvs :: (geometry: *Geometry) {
	// Implement UV correction logic here
}

correct_seam :: (geometry: *Geometry) {
	// Implement seam correction logic here
}

normalize_normals :: (geometry: *Geometry) {
	for normal: geometry.attributes.normal.values {
		geometry.attributes.normal.values[it_index] = normalize(normal);
	}
}

generate_indices :: (geometry: *Geometry) {
	using geometry.attributes;
	points_count := position.values.count;

	index_by_position: Table(Vector3, VertexIndex, normalized_vector3_hash, vector3_equals);
	init(*index_by_position, points_count);
	defer deinit(*index_by_position);

	i: VertexIndex=0;
	for position: position.values {
		if !table_contains(*index_by_position, position) {
			table_set(*index_by_position, position, i);
			i+=1;
		}
	}

	array_resize(*geometry.indices, points_count);

	index := 0;
	for position: position.values {
		unique_index, found := table_find(*index_by_position, position);
		if found {
			geometry.indices[index] = xx unique_index;
			index += 1;
		}
	}
	array_resize(*position.values, index_by_position.count);

	for index,pos:index_by_position {
		position.values[index] = pos;
	}
}

normalized_vector3_hash :: (position: Vector3) -> u32 {
	normalized := normalize(position);
	x := cast(u32) (normalized.x * 1023.0); // 10 bits
	y := cast(u32) (normalized.y * 1023.0);
	z := cast(u32) (normalized.z * 1023.0);
	hash :u32= (x << 20) | (y << 10) | z;
	// Use the sign bits for the last 2 bits of the hash
	zero :u32 = 0;
	one :u32 = 1;
	sign_bits :u32= ((ifx normalized.x < 0 then one else zero) << 1) |
				 (ifx normalized.y < 0 then one else zero);
	
	hash = (hash << 2) | sign_bits;
	return hash;
}
EPSILON :: 0.0001;
vector3_equals :: (v0:Vector3, v1: Vector3)->bool {
	return 	abs(v0.x - v1.x) < EPSILON &&
			abs(v0.y - v1.y) < EPSILON &&
			abs(v0.z - v1.z) < EPSILON;
}



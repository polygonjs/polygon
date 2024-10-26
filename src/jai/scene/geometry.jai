VertexIndex :: u32;

GeometryAttribute :: struct($T: Type, $F: WGPUVertexFormat) {
	values: [..]T;
	format:WGPUVertexFormat = F;
}

GeometryAttributes :: struct {
	position: GeometryAttribute(Vector3, .Float32x3);
	normal: GeometryAttribute(Vector3, .Float32x3);
	// color: GeometryAttribute(Vector3, .Float32x3);
	uv: GeometryAttribute(Vector2, .Float32x2);
}
Geometry :: struct {
	attributes: GeometryAttributes;
	indices: [..]VertexIndex;
}


geometry_box_update :: (geometry: *Geometry, segments: Vector3UInt) {
	geometry_box_attributes_set(geometry, .{segments = segments});
	geometry_attributes_validate(geometry);
	normals_compute(geometry);
}
geometry_icosahedron_update :: (geometry: *Geometry, detail: u8) {
	geometry_icosahedron_attributes_set(geometry, .{detail = detail});
	geometry_attributes_validate(geometry);
	normals_compute(geometry);
}
geometry_plane_update :: (geometry: *Geometry, segments: Vector2UInt) {
	geometry_plane_attributes_set(geometry, .{segments = segments});
	geometry_attributes_validate(geometry);
	normals_compute(geometry);
}
geometry_sphere_update :: (geometry: *Geometry, segments: Vector2UInt) {
	geometry_sphere_attributes_set(geometry, .{widthSegments = segments.x, heightSegments = segments.y});
	geometry_attributes_validate(geometry);
	normals_compute(geometry);
}

geometry_add_noise :: (geometry: *Geometry, freq: Vector3) {
	{
		using geometry.attributes;
		for position.values {
			position.values[it_index] += normal.values[it_index]*(0.5*(perlin_noise(it.x*freq.x, it.y*freq.y, it.z*freq.z)));
		}
	}
	normals_compute(geometry);
}

geometry_attributes_validate :: (geometry: *Geometry) {
	using geometry.attributes;
	points_count := position.values.count;
	assert(points_count > 0, "points count is 0");
	assert(points_count == normal.values.count, tprint("geometry_attributes_validate: position count (%) and normal count (%) mismatch\n", points_count, normal.values.count));
	// assert(points_count == geometry.attributes.color.values.count, "geometry_attributes_validate: position and color count mismatch");
	assert(points_count == uv.values.count, tprint("geometry_attributes_validate: position count (%) and uv count (%) mismatch\n", points_count, uv.values.count));
}

GeometryAttribute :: struct($T: Type, $F: WGPUVertexFormat) {
	values: [..]T;
	format:WGPUVertexFormat = F;
}

GeometryAttributes :: struct {
	position: GeometryAttribute(Vector3, .Float32x3);
	normal: GeometryAttribute(Vector3, .Float32x3);
	color: GeometryAttribute(Vector3, .Float32x3);
	uv: GeometryAttribute(Vector2, .Float32x2);
}
Geometry :: struct {
	attributes: GeometryAttributes;
	indices: [..]VertexIndex;
}


geometry_box_update :: (geometry: *Geometry, segments: Vector3UInt, freq: Vector3) {
	geometry_box_attributes_set(geometry, .{segments = segments});
	geometry_attributes_validate(geometry);

	{
		using geometry.attributes;
		for position.values {
			position.values[it_index] += normal.values[it_index]*(0.5*(perlin_noise(it.x*freq.x, it.y*freq.y, it.z*freq.z)));
		}
	}
	normals_compute(geometry);
}
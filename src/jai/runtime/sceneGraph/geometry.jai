

Geometry :: struct {
	allocator: Allocator;
	attributes: GeometryAttributes;
	indices: [..]VertexIndex;
}
newGeometry :: (allocator: Allocator) -> *Geometry {
	previousAllocator := context.allocator;
	context.allocator = allocator;
	geometry :*Geometry= New(Geometry);
	context.allocator = previousAllocator;
	geometry.allocator = allocator;
	geometryAttributesSetAllocator(*geometry.attributes, allocator);
	geometry.indices.allocator = allocator;
	return geometry;
}
geometryDelete :: (geometry: *Geometry) {
	previousAllocator := context.allocator;
	context.allocator = geometry.allocator;
	geometryAttributesDelete(*geometry.attributes);
	array_reset(*geometry.indices);
	free(geometry,, geometry.allocator);
	context.allocator = previousAllocator;
}

geometry_box_update :: (geometry: *Geometry, segments: Vector3UInt) {
	geometry_box_attributes_set(geometry, .{segments = segments});
	geometryAttributesValidate(geometry);
	normals_compute(geometry);
}
geometry_icosahedron_update :: (geometry: *Geometry, detail: u8) {
	geometry_icosahedron_attributes_set(geometry, .{detail = detail});
	geometryAttributesValidate(geometry);
	normals_compute(geometry);
}
geometry_plane_update :: (geometry: *Geometry, size: Vector2=.{1,1}, segments: Vector2UInt=.{1,1}) {
	geometry_plane_attributes_set(geometry, .{size = size, segments = segments});
	geometryAttributesValidate(geometry);
	normals_compute(geometry);
}
geometry_sphere_update :: (geometry: *Geometry, segments: Vector2UInt) {
	geometry_sphere_attributes_set(geometry, .{widthSegments = segments.x, heightSegments = segments.y});
	geometryAttributesValidate(geometry);
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


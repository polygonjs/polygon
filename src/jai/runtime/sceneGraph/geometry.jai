

Geometry :: struct {
	allocator: Allocator;
	attributes: GeometryAttributes;
	indices: [..]VertexIndex;
}
newGeometry :: (allocator: Allocator) -> *Geometry {
	geometry :*Geometry= New(Geometry,, allocator);
	geometry.allocator = allocator;
	geometryAttributesSetAllocator(*geometry.attributes, allocator);
	geometry.indices.allocator = allocator;
	return geometry;
}
geometryClone :: (geometry: *Geometry) -> *Geometry {
	clone := newGeometry(geometry.allocator);
	geometryAttributesCopy(*geometry.attributes, *clone.attributes);
	array_copy(*clone.indices, geometry.indices);
	return clone;
}
geometryDelete :: (geometry: *Geometry) {
	geometryAttributesDelete(*geometry.attributes);
	array_reset(*geometry.indices);
	free(geometry,, geometry.allocator);
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

geometry_normalise :: (geometry: *Geometry) {
	{
		using geometry.attributes;
		for position.values {
			position.values[it_index] = normalize(position.values[it_index]);
		}
	}
	normals_compute(geometry);
}
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


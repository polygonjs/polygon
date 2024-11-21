VertexIndex :: u32;


GeometryAttributes :: struct {
	allocator: Allocator;
	position: GeometryAttribute(Vector3, .Float32x3);
	normal: GeometryAttribute(Vector3, .Float32x3);
	// color: GeometryAttribute(Vector3, .Float32x3);
	uv: GeometryAttribute(Vector2, .Float32x2);
}
geometryAttributesSetAllocator :: (attributes: *GeometryAttributes, allocator: Allocator) {
	attributes.allocator = allocator;
	geometryAttributeSetAllocator(*attributes.position, allocator);
	geometryAttributeSetAllocator(*attributes.normal, allocator);
	geometryAttributeSetAllocator(*attributes.uv, allocator);
}
geometryAttributesDelete :: (attributes: *GeometryAttributes) {
	using attributes;
	geometryAttributeDelete(*position);
	geometryAttributeDelete(*normal);
	geometryAttributeDelete(*uv);
}

geometryAttributesValidate :: (geometry: *Geometry) {
	using geometry.attributes;
	points_count := position.values.count;
	assert(points_count > 0, "points count is 0");
	assert(points_count == normal.values.count, tprint("geometryAttributesValidate: position count (%) and normal count (%) mismatch\n", points_count, normal.values.count));
	// assert(points_count == geometry.attributes.color.values.count, "geometryAttributesValidate: position and color count mismatch");
	assert(points_count == uv.values.count, tprint("geometryAttributesValidate: position count (%) and uv count (%) mismatch\n", points_count, uv.values.count));
}

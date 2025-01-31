VertexIndex :: u32;


GeometryAttributes :: struct {
	allocator: Allocator;
	position: GeometryAttribute(Vector3, .Float32x3);
	normal: GeometryAttribute(Vector3, .Float32x3);
	// color: GeometryAttribute(Vector3, .Float32x3);
	uv: GeometryAttribute(Vector2, .Float32x2);
	// charIndex: GeometryAttribute(float, .Float32);
}
geometrySetPointsCount :: (using geometry: *Geometry, pointsCount: s64) {
	array_resize(*attributes.position.values, pointsCount, false);
	array_resize(*attributes.normal.values, pointsCount, false);
	array_resize(*attributes.uv.values, pointsCount, false);
	// array_resize(*attributes.charIndex.values, pointsCount, false);
}
geometrySetIndicesCount :: (using geometry: *Geometry, indicesCount: s64) {
	array_resize(*geometry.indices, indicesCount, false);
}
geometryAttributesSetAllocator :: (attributes: *GeometryAttributes, allocator: Allocator) {
	attributes.allocator = allocator;
	geometryAttributeSetAllocator(*attributes.position, allocator);
	geometryAttributeSetAllocator(*attributes.normal, allocator);
	geometryAttributeSetAllocator(*attributes.uv, allocator);
	// geometryAttributeSetAllocator(*attributes.charIndex, allocator);
}
geometryAttributesCopy :: (src: *GeometryAttributes, target: *GeometryAttributes) {
	geometryAttributesSetAllocator(target, src.allocator);
	geometryAttributeCopy(*src.position, *target.position);
	geometryAttributeCopy(*src.normal, *target.normal);
	geometryAttributeCopy(*src.uv, *target.uv);
	// geometryAttributeCopy(*src.charIndex, *target.charIndex);
}
geometryAttributesDelete :: (using attributes: *GeometryAttributes) {
	geometryAttributeDelete(*position);
	geometryAttributeDelete(*normal);
	geometryAttributeDelete(*uv);
	// geometryAttributeDelete(*charIndex);
}

geometryAttributesValidate :: (geometry: *Geometry) {
	using geometry.attributes;
	pointsCount := position.values.count;
	assert(pointsCount > 0, "points count is 0");
	assert(pointsCount == normal.values.count, tprint("geometryAttributesValidate: position count (%) and normal count (%) mismatch\n", pointsCount, normal.values.count));
	// assert(points_count == geometry.attributes.color.values.count, "geometryAttributesValidate: position and color count mismatch");
	assert(pointsCount == uv.values.count, tprint("geometryAttributesValidate: position count (%) and uv count (%) mismatch\n", pointsCount, uv.values.count));
	// assert(pointsCount == charIndex.values.count, tprint("geometryAttributesValidate: position count (%) and charIndex count (%) mismatch\n", pointsCount, charIndex.values.count));
}



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



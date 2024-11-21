
GeometryAttribute :: struct($T: Type, $F: WGPUVertexFormat) {
	values: [..]T;
	format:WGPUVertexFormat = F;
}
geometryAttributeSetAllocator :: (attribute: *GeometryAttribute($T, $F), allocator: Allocator) {
	attribute.values.allocator = allocator;
}
geometryAttributeDelete :: (attribute: *GeometryAttribute($T, $F)) {
	array_reset(*attribute.values);
}


GeometryAttribute :: struct($T: Type, $F: WGPUVertexFormat) {
	values: [..]T;
	format:WGPUVertexFormat = F;
}
geometryAttributeSetAllocator :: (attribute: *GeometryAttribute($T, $F), allocator: Allocator) {
	attribute.values.allocator = allocator;
}
geometryAttributeCopy :: (src: *GeometryAttribute($T, $F), target: *GeometryAttribute(T, F)) {
	target.format = src.format;
	array_copy(*target.values, src.values);
}
geometryAttributeDelete :: (attribute: *GeometryAttribute($T, $F)) {
	array_reset(*attribute.values);
}

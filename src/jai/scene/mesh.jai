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

Object3DUniforms :: struct {
	transformMatrix: Matrix4x4Buffer;
}
Mesh :: struct {
	geometry: Geometry;
	transformMatrix: Matrix4;
	uniforms: Object3DUniforms;
};

mesh_create :: ()->Mesh {
	mesh :Mesh;

	identity(*mesh.transformMatrix);
	translate(*mesh.transformMatrix, .{x = 0.0, y = 0.0, z = 0.0});
	mesh_uniforms_update(*mesh);

	geometry_box_attributes_create(*mesh.geometry);
	geometry_box_indices_create(*mesh.geometry);
	geometry_attributes_validate(*mesh.geometry);
	return mesh;
}

mesh_uniforms_update :: (mesh: *Mesh) {
	transposedMatrix := transpose((<<mesh).transformMatrix);
	matrix4x4_to_buffer(*transposedMatrix, *((<<mesh).uniforms.transformMatrix));
}


geometry_attributes_validate :: (geometry: *Geometry) {
	points_count := geometry.attributes.position.values.count;
	assert(points_count > 0, "points count is 0");
	assert(points_count == geometry.attributes.normal.values.count, "geometry_attributes_validate: position and normal count mismatch");
	assert(points_count == geometry.attributes.color.values.count, "geometry_attributes_validate: position and color count mismatch");
	assert(points_count == geometry.attributes.uv.values.count, "geometry_attributes_validate: position and uv count mismatch");
}

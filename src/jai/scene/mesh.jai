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
EmptyUniforms :: struct {};
Material :: struct($UniformType: Type) {
	name: string;
	shader: string;
	uniforms: UniformType;
}
Mesh :: struct {
	geometry: Geometry;
	position: Vector3;
	quaternion: Quaternion;
	scale: Vector3 = .{x = 1.0, y = 1.0, z = 1.0};
	matrix: Matrix4;
	uniforms: Object3DUniforms;
	material: *Material(Any);
};

// EMPTY_UNIFORMS:EmptyUniforms = .{};
MATERIAL_BASIC :Material(EmptyUniforms) = .{
	name = "basic",
	shader = SHADER_RENDER_BASIC,
	// uniforms = EMPTY_UNIFORMS,
};
// SDF_UNIFORMS:SDFUniforms;
MATERIAL_RAYMARCHING :Material(SDFUniforms) = .{
	name = "raymarching",
	shader = SHADER_RENDER_RAYMARCHING,
	// uniforms = SDF_UNIFORMS,
};

mesh_create :: () -> Mesh {
	mesh :Mesh;

	identity(*mesh.matrix);
	translate(*mesh.matrix, .{x = 0.0, y = 0.0, z = 0.0});
	mesh_uniforms_update(*mesh);

	geometry_box_attributes_create(*mesh.geometry);
	geometry_box_indices_create(*mesh.geometry);
	geometry_attributes_validate(*mesh.geometry);

	// TODO: this cast may seem like it gives the expected result,
	// but it may be because we create a wgpu buffer of at least 16 bytes,
	// which will then be the same size for the empty struct and the sdf uniforms struct.
	// This may very well break for larger structs.
	mesh.material = cast(*Material(Any))	*MATERIAL_BASIC;
	return mesh;
}
// mesh_set_position :: (mesh: *Mesh, position: Vector3) {
// 	identity(*mesh.transformMatrix);
// 	rotate(*mesh.transformMatrix, position);
// 	translate(*mesh.transformMatrix, position);
// 	mesh_uniforms_update(mesh);
// }
mesh_update_matrix :: (mesh: *Mesh) {
	identity(*mesh.matrix);
	translate(*mesh.matrix, mesh.position);
	mesh.matrix = rotate(mesh.matrix, mesh.quaternion);
	scale(*mesh.matrix, mesh.scale);
	mesh_uniforms_update(mesh);
}

mesh_uniforms_update :: (mesh: *Mesh) {
	transposedMatrix := transpose(mesh.matrix);
	matrix4x4_to_buffer(*transposedMatrix, *mesh.uniforms.transformMatrix);
}


geometry_attributes_validate :: (geometry: *Geometry) {
	points_count := geometry.attributes.position.values.count;
	assert(points_count > 0, "points count is 0");
	assert(points_count == geometry.attributes.normal.values.count, "geometry_attributes_validate: position and normal count mismatch");
	assert(points_count == geometry.attributes.color.values.count, "geometry_attributes_validate: position and color count mismatch");
	assert(points_count == geometry.attributes.uv.values.count, "geometry_attributes_validate: position and uv count mismatch");
}

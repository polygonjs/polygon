
Object3DUniforms :: struct {
	transformMatrix: Matrix4x4Buffer;
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



mesh_create :: () -> Mesh {
	mesh :Mesh;

	identity(*mesh.matrix);
	translate(*mesh.matrix, .{x = 0.0, y = 0.0, z = 0.0});
	mesh_uniforms_update(*mesh);

	// geometry_box_update(*mesh.geometry, .{4,4,4});
	// geometry_box_update(*mesh.geometry, .{8,8,8});
	// geometry_box_update(*mesh.geometry, .{128, 128, 128});
	// geometry_sphere_update(*mesh.geometry, .{128,128});
	geometry_icosahedron_update(*mesh.geometry, 2);

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



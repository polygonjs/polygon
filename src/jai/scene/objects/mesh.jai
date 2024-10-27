Mesh :: struct {
	#as using object3D: Object3D;
	object3D.init = init_mesh;

	geometry: *Geometry;
	material: *Material;
	use_compute: bool=false;
};

init_mesh :: (object: *Object3D) {
	mesh := cast(*Mesh)object;

	mesh.geometry = New(Geometry);

	// geometry_box_update(mesh.geometry, .{2,2,2});
	// mesh.material = cast(*Material(Any))	*MATERIAL_BASIC;

	assert(mesh.geometry.attributes.position.format != WGPUVertexFormat.Undefined, "mesh.geometry.attributes.position.format is Undefined\n");
}


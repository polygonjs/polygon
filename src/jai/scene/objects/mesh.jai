Mesh :: struct {
	#as using object3D: Object3D;

	geometry: *Geometry;
	material: *Material;
	use_compute: bool=false;
};

object3DInit :: (mesh: *Mesh) {
	object3DInit(cast(*Object3D)mesh);

	mesh.geometry = New(Geometry);

	// geometry_box_update(mesh.geometry, .{2,2,2});
	// mesh.material = cast(*Material(Any))	*MATERIAL_BASIC;

	assert(mesh.geometry.attributes.position.format != WGPUVertexFormat.Undefined, "mesh.geometry.attributes.position.format is Undefined\n");
}


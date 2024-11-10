Mesh :: struct {
	#as using object3D: Object3D;

	geometry: *Geometry;
	material: *Material;
	use_compute: bool=false;
};

newMesh :: ($T: Type, geometry: *Geometry=null, material: *Material=null) -> *T {
	object := object3DAllocate(T);

	object3DInit(object, geometry, material);

	return object;
}

object3DInit :: (mesh: *Mesh) {
	object3DInit(mesh, null, null);
}
object3DInit :: (mesh: *Mesh, geometry: *Geometry=null, material: *Material=null) {
	object3DInit(cast(*Object3D)mesh);

	if geometry == null {
		mesh.geometry = New(Geometry);
	} else {
		mesh.geometry = geometry;
	}

	if material != null {
		mesh.material = material;
	}

	// geometry_box_update(mesh.geometry, .{2,2,2});
	// mesh.material = cast(*Material(Any))	*MATERIAL_BASIC;
	assert(mesh.geometry != null, "mesh.geometry is null\n");
	assert(mesh.geometry.attributes.position.format != WGPUVertexFormat.Undefined, "mesh.geometry.attributes.position.format is Undefined\n");
}


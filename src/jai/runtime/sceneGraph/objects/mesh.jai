Mesh :: struct {
	#as using object3D: Object3D;

	geometry: *Geometry;
	material: *Material;
	use_compute: bool=false;
};

newMesh :: (scene:*Scene, $T: Type, geometry: *Geometry=null, material: *Material=null) -> *T {
	object := object3DAllocate(T, scene.allocator);

	if geometry == null {
		object.geometry = newGeometry(scene.allocator);
	} else {
		object.geometry = geometry;
	}

	if material != null {
		object.material = material;
	}

	object3DInit(object);

	return object;
}
worldObjectClone :: (object: *TYPE)->*TYPE {
	clone := New(TYPE,, object.allocator);
	memcpy(clone, object, size_of(TYPE));
	clone.geometry = geometryClone(object.geometry);
	return clone;
}

// object3DInit :: (mesh: *TYPE) {
// 	object3DInit(mesh, null, null);
// }
object3DInit :: (mesh: *TYPE) {
	object3DInit(cast(*Object3D)mesh);


	// geometry_box_update(mesh.geometry, .{2,2,2});
	// mesh.material = cast(*Material(Any))	*MATERIAL_BASIC;
	assert(mesh.geometry != null, "mesh.geometry is null\n");
	assert(mesh.geometry.attributes.position.format != WGPUVertexFormat.Undefined, "mesh.geometry.attributes.position.format is Undefined\n");
}
worldObjectDelete :: (object: *TYPE) {
	if object.geometry != null {
		geometryDelete(object.geometry);
	}
	worldObjectDelete(cast(*Object3D)object);
}

#scope_file

TYPE :: Mesh;
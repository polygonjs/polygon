BackgroundMeshData :: struct {
	initialized:bool=false;
	added:bool=false;
	mesh: Mesh;
	geometry: Geometry;
}

rendererInitBackgroundMesh :: (using renderer: *Renderer) {
	if(includeBackgroundObject == false) {
		return;
	}
	using backgroundMeshData;
	if (initialized) return;
	initialized = true;

	worldObjectInit(*mesh);
	geometrySetAllocator(*geometry, allocator);
	mesh.geometry = *geometry;
	mesh.material = xx *renderer.defaultMaterial.backgroundBasic;
	object3DInit(*mesh);
	geometryPlaneAttributesSet(*geometry, .{size=.{2,2}, segments=.{1,1}});
}

rendererAddBackgroundMesh :: (using renderer: *Renderer) {
	if renderer.includeBackgroundObject && !renderer.backgroundMeshData.added {
		rendererObjectAdd(renderer, renderer.backgroundMeshData.mesh);
		renderer.backgroundMeshData.added = true;
	}
}
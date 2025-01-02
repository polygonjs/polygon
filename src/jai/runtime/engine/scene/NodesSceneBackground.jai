BackgroundMeshData :: struct {
	mesh: Mesh;
	geometry: Geometry;
}

nodesSceneInitBackgroundMesh :: (using scene: *NodesScene) {
	using backgroundMeshData;
	worldObjectInit(*mesh);
	mesh.geometry = *geometry;
	mesh.material = xx *scene.defaultMaterial.backgroundBasic;
	object3DInit(*mesh);
	geometryPlaneAttributesSet(mesh.geometry, .{size=.{2,2}, segments=.{1,1}});
}
// BackgroundMeshData :: struct {
// 	mesh: Mesh;
// 	geometry: Geometry;
// }

// nodesSceneInitBackgroundMesh :: (using scene: *NodesScene) {
// 	using backgroundMeshData;
// 	worldObjectInit(*mesh);
// 	geometrySetAllocator(*geometry, allocator);
// 	mesh.geometry = *geometry;
// 	mesh.material = xx *scene.defaultMaterial.backgroundBasic;
// 	object3DInit(*mesh);
// 	geometryPlaneAttributesSet(*geometry, .{size=.{2,2}, segments=.{1,1}});
// }
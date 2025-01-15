
nodesSceneInitThreeReport :: (using scene: *NodesScene) {
	array_init(*threeReportObjects, scene.allocator);

	threeReport.objects = threeReportObjects.data;
}
nodesSceneUpdateThreeReport :: (using scene: *NodesScene) {
	threeReport.objectsCount = xx scene.worldScene.children.count;
	threeReportObjects.count = scene.worldScene.children.count;
	maybe_grow(*threeReportObjects);

	threeReport.objects = threeReportObjects.data;

	for object, i: scene.worldScene.children {
		if object.type == Mesh {
			mesh := cast(*Mesh)object;
			geometry := mesh.geometry;
			position := geometry.attributes.position;
			normal := geometry.attributes.normal;
			indices := geometry.indices;
			threeReport.objects[i] = .{
				position = .{
					start = cast(*void)position.values.data,
					size = xx position.values.count
				},
				normal = .{
					start = cast(*void)normal.values.data,
					size = xx normal.values.count
				},
				index = .{
					start = cast(*void)indices.data,
					size = xx indices.count
				}
			};
		}
	}

	onThreeReportUpdated(cast(*u8)*threeReport);
}
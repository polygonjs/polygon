
nodesSceneInitThreeReport :: (using scene: *NodesScene) {
	array_init(*threeReportBuffers, scene.allocator);

	threeReport.buffers = threeReportBuffers.data;
}
nodesSceneUpdateThreeReport :: (using scene: *NodesScene) {
	threeReport.objectsCount = xx scene.worldScene.children.count;
	threeReportBuffers.count = scene.worldScene.children.count;
	maybe_grow(*threeReportBuffers);

	threeReport.buffers = threeReportBuffers.data;

	for object, i: scene.worldScene.children {
		if object.type == Mesh {
			mesh := cast(*Mesh)object;
			geometry := mesh.geometry;
			position := geometry.attributes.position;
			threeReport.buffers[i] = .{
				start = cast(*void)position.values.data,
				size = xx position.values.count
			};
		}
	}

	onThreeReportUpdated(cast(*u8)*threeReport);
}
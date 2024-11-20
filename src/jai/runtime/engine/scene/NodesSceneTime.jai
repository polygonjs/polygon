TimeNode :: struct {
	#as using coreGraphNode: CoreGraphNode;//(TimeNode);
}

sceneOnTick :: (scene: *NodesScene, time:Time) {
	sceneSetTime(scene, time);
	sceneUniformsUpdate(scene);
}

sceneSetTime :: (scene: *NodesScene, time:Time) {
	scene.time = time;
	setDirty(*scene.timeGraphNode);
}
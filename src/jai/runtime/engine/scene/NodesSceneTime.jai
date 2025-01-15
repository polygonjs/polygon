TimeNode :: struct {
	#as using coreGraphNode: CoreGraphNode;
}

sceneOnTick :: (scene:*NodesScene, time:Time){
	sceneOnBeforeTick(scene, time);
	nodesSceneOutputNodesCompute(scene);
	reset_temporary_storage();
	sceneOnAfterTick(scene);
}

sceneOnBeforeTick :: (scene: *NodesScene, time:Time) {
	sceneSetTime(scene, time);
	sceneUniformsUpdate(scene);
	scene.onBeforeTick(scene);
}
sceneOnAfterTick :: (scene: *NodesScene) {
	scene.framesCount += 1;
}

sceneSetTime :: (scene: *NodesScene, time:Time) {
	scene.time = time;
	setDirty(*scene.timeGraphNode);
}
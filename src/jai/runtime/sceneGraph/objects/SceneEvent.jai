SceneEvent :: enum u8 {
	OBJECT_ADDED :: 0;
	OBJECT_BEFORE_REMOVE;
}


sceneAddObserver :: (scene: *Scene, observer: Any) {
	array_add(*scene.observers, observer);
}
sceneRemoveObserver :: (scene: *Scene, observer: Any) {
	for o, i: scene.observers {
		if o.value_pointer == observer.value_pointer {
			array_unordered_remove_by_index(*scene.observers, i);
			return;
		}
	}
}
sceneEmitEvent :: (scene: *Scene, $event: SceneEvent, object: *$T) {
	using scene;
	// if observer.value_pointer == null {
	// 	return;
	// }
	if event == {
		case .OBJECT_ADDED; 	{for o:observers sceneObserverOnObjectAdded(o, scene, object);}
		case .OBJECT_BEFORE_REMOVE; 	{for o:observers sceneObserverOnObjectBeforeRemove(o, scene, object);}
	}
}
// sceneEmitEvent :: (scene: *NodesScene, $event: NodesSceneEvent, node: *$T, inputIndex: u8=0) {
// 	using scene;
// 	if observer.value_pointer == null {
// 		return;
// 	}
// 	if event == {
// 		case NodesSceneEvent.NODE_INPUT_ADDED; 	{nodeSceneObserverOnNodeInputAdded(observer, scene, node, inputIndex);}
// 		case NodesSceneEvent.NODE_INPUT_REMOVED;{nodeSceneObserverOnNodeInputRemoved(observer, scene, node, inputIndex);}
// 	}
// }
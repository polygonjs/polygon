SceneEvent :: enum u8 {
	OBJECT_ADDED :: 0;
	OBJECT_BEFORE_REMOVE;
}


sceneAddObserver :: (scene: *Scene, observer: Any) {
	// assert(scene.observer.value_pointer==null, "there is already an observer");
	// scene.observer = observer;
	array_add(*scene.observers, observer);
}
sceneRemoveObserver :: (scene: *Scene, observer: Any) {
	// assert(scene.observer.value_pointer!=null && scene.observer.value_pointer==observer.value_pointer, tprint("observer not found: % %\n", scene.observer.value_pointer, <<observer.type));
	// scene.observer.value_pointer = null;
	print("remove to be implemented\n");
	// array_remove(*scene.observers, observer);
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
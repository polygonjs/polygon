NodesSceneEvent :: enum u8 {
	NODE_ADDED :: 0;
	NODE_BEFORE_REMOVE;
	NODE_ON_DIRTY;
	NODE_INPUT_ADDED;
	NODE_INPUT_REMOVED;
}


sceneAddObserver :: (scene: *NodesScene, observer: Any) {
	assert(scene.observer.value_pointer==null, "there is already an observer");
	scene.observer = observer;
	// array_add(*scene.observers, observer);
}
sceneRemoveObserver :: (scene: *NodesScene, observer: Any) {
	assert(scene.observer.value_pointer!=null && scene.observer.value_pointer==observer.value_pointer, tprint("observer not found: % %\n", scene.observer.value_pointer, <<observer.type));
	scene.observer.value_pointer = null;
	// array_remove(*scene.observers, observer);
}
sceneEmitEvent :: (scene: *NodesScene, $event: NodesSceneEvent, nodeId: NodeId) {
	using scene;
	if observer.value_pointer == null {
		return;
	}
	if event == {
		// case NodesSceneEvent.NODE_ADDED; 	{nodeSceneObserverOnNodeAdded(observer, scene, nodeId);}
		// case NodesSceneEvent.NODE_BEFORE_REMOVE; 	{nodeSceneObserverOnNodeBeforeRemove(observer, scene, nodeId);}
	}
}
sceneEmitEvent :: (scene: *NodesScene, $event: NodesSceneEvent, nodeId: NodeId, inputIndex: u8=0) {
	using scene;
	if observer.value_pointer == null {
		return;
	}
	if event == {
		// case NodesSceneEvent.NODE_INPUT_ADDED; 	{nodeSceneObserverOnNodeInputAdded(observer, scene, nodeId, inputIndex);}
		// case NodesSceneEvent.NODE_INPUT_REMOVED;{nodeSceneObserverOnNodeInputRemoved(observer, scene, nodeId, inputIndex);}
	}
}
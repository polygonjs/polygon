NodesSceneEvent :: enum u8 {
	NODE_ADDED :: 0;
	NODE_BEFORE_REMOVE;
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
sceneEmitEvent :: (scene: *NodesScene, $event: NodesSceneEvent, node: *$T) {
	using scene;
	if observer.value_pointer == null {
		return;
	}
	if event == {
		// case NodesSceneEvent.NODE_ADDED; 	{for o: scene.observers nodeSceneObserverOnNodeAdded(o, scene, node); return;}
		// case NodesSceneEvent.NODE_REMOVED; 	{for o: scene.observers nodeSceneObserverOnNodeRemoved(o, scene, node); return;}
		case NodesSceneEvent.NODE_ADDED; 	{nodeSceneObserverOnNodeAdded(observer, scene, node);}
		case NodesSceneEvent.NODE_BEFORE_REMOVE; 	{nodeSceneObserverOnNodeBeforeRemove(observer, scene, node);}
	}
}
sceneEmitEvent :: (scene: *NodesScene, $event: NodesSceneEvent, node: *$T, inputIndex: u8=0) {
	using scene;
	if observer.value_pointer == null {
		return;
	}
	if event == {
		case NodesSceneEvent.NODE_INPUT_ADDED; 	{nodeSceneObserverOnNodeInputAdded(observer, scene, node, inputIndex);}
		case NodesSceneEvent.NODE_INPUT_REMOVED;{nodeSceneObserverOnNodeInputRemoved(observer, scene, node, inputIndex);}
	}
}
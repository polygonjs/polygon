NodesSceneEvent :: enum u8 {
	NODE_ADDED :: 0;
	NODE_BEFORE_REMOVE;
	NODE_ON_DIRTY;
	NODE_INPUT_ADDED;
	NODE_INPUT_REMOVED;
}


nodesSceneAddObserver :: (scene: *NodesScene, observer: Any) {
	assert(scene.observer.value_pointer==null, "there is already an observer");
	scene.observer = observer;
	// array_add(*scene.observers, observer);
}
nodesSceneRemoveObserver :: (scene: *NodesScene, observer: Any) {
	assert(scene.observer.value_pointer!=null && scene.observer.value_pointer==observer.value_pointer, tprint("observer not found: % %\n", scene.observer.value_pointer, <<observer.type));
	scene.observer.value_pointer = null;
	// array_remove(*scene.observers, observer);
}
nodesSceneEmitEvent :: (scene: *NodesScene, $event: NodesSceneEvent, node: *$T) {
	using scene;
	if observer.value_pointer == null {
		return;
	}
	if event == {
		case .NODE_ADDED; 	{nodeSceneObserverOnNodeAdded(observer, scene, node);}
		case .NODE_BEFORE_REMOVE; 	{nodeSceneObserverOnNodeBeforeRemove(observer, scene, node);}
	}
}
nodesSceneEmitEvent :: (scene: *NodesScene, $event: NodesSceneEvent, node: *$T, inputIndex: u8=0) {
	using scene;
	if observer.value_pointer == null {
		return;
	}
	if event == {
		case .NODE_INPUT_ADDED; 	{nodeSceneObserverOnNodeInputAdded(observer, scene, node, inputIndex);}
		case .NODE_INPUT_REMOVED;{nodeSceneObserverOnNodeInputRemoved(observer, scene, node, inputIndex);}
	}
}
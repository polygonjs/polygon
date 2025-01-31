NodesSceneEvent :: enum u8 {
	NODE_ADDED :: 0;
	NODE_BEFORE_REMOVE;
	NODE_ON_DIRTY;
	NODE_CONNECTION_ADDED;
	NODE_CONNECTION_REMOVED;
	COMPUTE_STARTED;
	COMPUTE_COMPLETED;
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
nodesSceneEmitEvent :: (using scene: *NodesScene, $event: NodesSceneEvent) #expand {
	#if NODES_SCENE_EMIT_EVENTS {
		if observer.value_pointer == null {
			return;
		}
		if event == {
			case .COMPUTE_STARTED; 		{nodeSceneObserverOnComputeStarted(observer, scene);}
			case .COMPUTE_COMPLETED; 	{nodeSceneObserverOnComputeCompleted(observer, scene);}
		}
	}
}
nodesSceneEmitEvent :: (using scene: *NodesScene, $event: NodesSceneEvent, node: *$T) #expand {
	#if NODES_SCENE_EMIT_EVENTS {
		if observer.value_pointer == null {
			return;
		}
		if event == {
			case .NODE_ADDED; 	{nodeSceneObserverOnNodeAdded(observer, scene, xx node);}
			case .NODE_BEFORE_REMOVE; 	{nodeSceneObserverOnNodeBeforeRemove(observer, scene, xx node);}
		}
	}
}
nodesSceneEmitEvent :: (using scene: *NodesScene, $event: NodesSceneEvent, connection: NodeConnection) #expand {
	#if NODES_SCENE_EMIT_EVENTS {
		if observer.value_pointer == null {
			return;
		}
		if event == {
			case .NODE_CONNECTION_ADDED; 	{nodeSceneObserverOnNodeConnectionAdded(observer, scene, connection);}
			case .NODE_CONNECTION_REMOVED;{nodeSceneObserverOnNodeConnectionRemoved(observer, scene, connection);}
		}
	}
}
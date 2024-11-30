SceneEvent :: enum u8 {
	OBJECT_ADDED :: 0;
	OBJECTS_ADDED :: 0;
	OBJECT_BEFORE_REMOVE;
	OBJECTS_BEFORE_REMOVE;
	RENDERABLE_MATERIAL_CHANGED;
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
	if event == {
		case .OBJECT_ADDED; 	{for o:observers sceneObserverOnObjectAdded(o, scene, object);}
		case .OBJECT_BEFORE_REMOVE; 	{for o:observers sceneObserverOnObjectBeforeRemove(o, scene, object);}
	}
}
sceneEmitEvent :: (scene: *Scene, $event: SceneEvent, objects: []*$T) {
	using scene;
	if event == {
		/*
		if we send an event with scene.children as a list,
		the list will probably be modified before the event is processed.
		*/
		case .OBJECTS_ADDED; {
			push_allocator(temp);
			objectsCopy := array_copy(objects);
			for o:observers {
				sceneObserverOnObjectsAdded(o, scene, objectsCopy);
			}
		}
		case .OBJECTS_BEFORE_REMOVE; {
			push_allocator(temp);
			objectsCopy := array_copy(objects);
			for o:observers {
				sceneObserverOnObjectsBeforeRemove(o, scene, objectsCopy);
			}
		}
	}
}
sceneEmitEvent :: (scene: *Scene, $event: SceneEvent, object: *$T, previousMaterial: *Material) {
	using scene;
	if event == {
		case .RENDERABLE_MATERIAL_CHANGED; {for o:observers sceneObserverOnRenderableMaterialChanged(o, scene, object, previousMaterial);}
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
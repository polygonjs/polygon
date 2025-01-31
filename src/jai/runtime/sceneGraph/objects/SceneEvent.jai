SceneEvent :: enum u8 {
	OBJECT_ADDED :: 0;
	OBJECTS_ADDED;
	OBJECT_BEFORE_REMOVE;
	OBJECTS_BEFORE_REMOVE;
	RENDERABLE_MATERIAL_CHANGED;
	OBJECT_MATRIX_UPDATED;
	CAMERA_MATRIX_UPDATED;
}
SCENE_EVENTS_COUNT :: #run enum_values_as_s64(SceneEvent).count;


sceneAddObserver :: (using scene: *Scene, observer: Any) {
	array_add(*observers, observer);
}
sceneRemoveObserver :: (using scene: *Scene, observer: Any) {
	for o, i: observers {
		if o.value_pointer == observer.value_pointer {
			array_unordered_remove_by_index(*observers, i);
			return;
		}
	}
}


sceneEmitEvent :: (using scene: *Scene, $event: SceneEvent, object: *$T) {
	_incrementEventsCount(scene, event);
	if event == {
		case .OBJECT_ADDED; 	{for o:observers sceneObserverOnObjectAdded(o, scene, object);return;}
		case .OBJECT_BEFORE_REMOVE; 	{for o:observers sceneObserverOnObjectBeforeRemove(o, scene, object);return;}
		case .OBJECT_MATRIX_UPDATED; {for o:observers sceneObserverOnObjectMatrixUpdated(o, scene, object);return;}
		case .CAMERA_MATRIX_UPDATED; {for o:observers sceneObserverOnCameraMatrixUpdated(o, scene, cast(*CameraAny)object);return;}
	}
}
sceneEmitEvent :: (using scene: *Scene, $event: SceneEvent, objects: []*$T) {
	_incrementEventsCount(scene, event);
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
			return;
		}
		case .OBJECTS_BEFORE_REMOVE; {
			push_allocator(temp);
			objectsCopy := array_copy(objects);
			for o:observers {
				sceneObserverOnObjectsBeforeRemove(o, scene, objectsCopy);
			}
			return;
		}
	}
}
sceneEmitEvent :: (using scene: *Scene, $event: SceneEvent, object: *$T, previousMaterial: *Material) {
	_incrementEventsCount(scene, event);
	if event == {
		case .RENDERABLE_MATERIAL_CHANGED; {for o:observers sceneObserverOnRenderableMaterialChanged(o, scene, object, previousMaterial);return;}
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

eventsCount :: (scene: *Scene, event: SceneEvent) -> u64 {
	#if RUN_TESTS {
		return scene.eventsCountByEvent[event];
	}
	return 0;
}

#scope_file

_incrementEventsCount :: (scene: *Scene, event: SceneEvent) #expand {
	#if RUN_TESTS {
		scene.eventsCountByEvent[event] += 1;
	}
}

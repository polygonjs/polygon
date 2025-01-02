
sceneObserverOnObjectAdded :: (observer: Any, scene: *Scene, object:*Object3DAny) {
	#insert ON_OBJECT_ADDED;
	assert(false, tprint("sceneObserverOnObjectAdded: observer type '%' is not implemented", cast(*Type_Info_Struct)observer.type));
}
sceneObserverOnObjectsAdded :: (observer: Any, scene: *Scene, objects: []*Object3DAny) {
	#insert ON_OBJECTS_ADDED;
	assert(false, tprint("sceneObserverOnObjectsAdded: observer type '%' is not implemented", cast(*Type_Info_Struct)observer.type));
}
sceneObserverOnObjectBeforeRemove :: (observer: Any, scene: *Scene, object:*Object3DAny) {
	#insert ON_OBJECT_BEFORE_REMOVE;
	assert(false, tprint("sceneObserverOnObjectBeforeRemove: observer type '%' is not implemented", cast(*Type_Info_Struct)observer.type));
}
sceneObserverOnObjectsBeforeRemove :: (observer: Any, scene: *Scene, objects: []*Object3DAny) {
	#insert ON_OBJECTS_BEFORE_REMOVE;
	assert(false, tprint("sceneObserverOnObjectsBeforeRemove: observer type '%' is not implemented", cast(*Type_Info_Struct)observer.type));
}
sceneObserverOnRenderableMaterialChanged :: (observer: Any, scene: *Scene, object:*Object3DAny, previousMaterial:*Material) {
	#insert ON_RENDERABLE_MATERIAL_CHANGED;
	assert(false, tprint("sceneObserverOnRenderableMaterialChanged: observer type '%' is not implemented", cast(*Type_Info_Struct)observer.type));
}
sceneObserverOnObjectMatrixUpdated :: (observer: Any, scene: *Scene, object:*Object3DAny) {
	#insert ON_OBJECT_MATRIX_UPDATED;
	assert(false, tprint("sceneObserverOnObjectMatrixUpdated: observer type '%' is not implemented", cast(*Type_Info_Struct)observer.type));
}
sceneObserverOnCameraMatrixUpdated :: (observer: Any, scene: *Scene, camera:*CameraAny) {
	#insert ON_CAMERA_MATRIX_UPDATED;
	assert(false, tprint("sceneObserverOnCameraMatrixUpdated: observer type '%' is not implemented", cast(*Type_Info_Struct)observer.type));
}



#scope_file

ON_OBJECT_ADDED,
ON_OBJECTS_ADDED,
ON_OBJECT_BEFORE_REMOVE,
ON_OBJECTS_BEFORE_REMOVE,
ON_RENDERABLE_MATERIAL_CHANGED,
ON_OBJECT_MATRIX_UPDATED,
ON_CAMERA_MATRIX_UPDATED :: #run registerSceneObserver();

SCENE_OBSERVER_TYPES :[..]Type;

IF_FIRST_LINE :: "if (cast(*Type_Info_Struct)observer.type).name == {\n";

sceneObserverRegister :: ($T:Type) #compile_time {
	array_add(*SCENE_OBSERVER_TYPES, T);
}

registerSceneObserver :: ()-> (
	ON_OBJECT_ADDED:string,
	ON_OBJECTS_ADDED:string,
	ON_OBJECT_BEFORE_REMOVE:string,
	ON_OBJECTS_BEFORE_REMOVE:string,
	ON_RENDERABLE_MATERIAL_CHANGED:string,
	ON_OBJECT_MATRIX_UPDATED:string,
	ON_CAMERA_MATRIX_UPDATED:string
) #compile_time {
	sceneObserverRegister(Renderer);

	

	SceneObserverGeneratedCode :: struct {
		onObjectAdded: string;
		onObjectsAdded: string;
		onObjectBeforeRemove: string;
		onObjectsBeforeRemove: string;
		onRenderableMaterialChanged: string;
		onObjectMatrixUpdated: string;
		onCameraMatrixUpdated: string;
	}
	generated: SceneObserverGeneratedCode;
	using generated;
	onObjectAdded = _loopObject("onObjectAdded");
	onObjectsAdded = _loopObjects("onObjectsAdded");
	onObjectBeforeRemove = _loopObject("onObjectBeforeRemove");
	onObjectsBeforeRemove = _loopObjects("onObjectsBeforeRemove");
	onRenderableMaterialChanged = _loopObjectWithArg("onRenderableMaterialChanged","previousMaterial");
	onObjectMatrixUpdated = _loopObject("onObjectMatrixUpdated");
	onCameraMatrixUpdated = _loopCamera("onCameraMatrixUpdated");
	return
		onObjectAdded,
		onObjectsAdded,
		onObjectBeforeRemove,
		onObjectsBeforeRemove,
		onRenderableMaterialChanged,
		onObjectMatrixUpdated,
		onCameraMatrixUpdated;
}


_loopObject :: (funcName:string)->string #compile_time {
	builder: String_Builder;
	print_to_builder(*builder, IF_FIRST_LINE);
	for observerType: SCENE_OBSERVER_TYPES {
		print_to_builder(*builder, tprint("\tcase \"%\"; %(cast(*%) observer.value_pointer, scene, object); return;\n", observerType, funcName, observerType));
	}
	print_to_builder(*builder, "}");
	return builder_to_string(*builder);
}
_loopObjects :: (funcName:string)->string #compile_time {
	builder: String_Builder;
	// print_to_builder(*builder, "print(\"type:.\%.\\n\", (cast(*Type_Info_Struct)observer.type).name);");
	print_to_builder(*builder, IF_FIRST_LINE);
	for observerType: SCENE_OBSERVER_TYPES {
		print_to_builder(*builder, tprint("\tcase \"%\"; %(cast(*%) observer.value_pointer, scene, objects); return;\n", observerType, funcName, observerType));
	}
	print_to_builder(*builder, "}");
	return builder_to_string(*builder);
}
_loopObjectWithArg :: (funcName:string, argName:string)->string #compile_time {
	builder: String_Builder;
	print_to_builder(*builder, IF_FIRST_LINE);
	for observerType: SCENE_OBSERVER_TYPES {
		print_to_builder(*builder, tprint("\tcase \"%\"; %(cast(*%) observer.value_pointer, scene, object, %); return;\n", observerType, funcName, observerType, argName));
	}
	print_to_builder(*builder, "}");
	return builder_to_string(*builder);
}
_loopCamera :: (funcName:string)->string #compile_time {
	builder: String_Builder;
	print_to_builder(*builder, IF_FIRST_LINE);
	for observerType: SCENE_OBSERVER_TYPES {
		print_to_builder(*builder, tprint("\tcase \"%\"; %(cast(*%) observer.value_pointer, scene, camera); return;\n", observerType, funcName, observerType));
	}
	print_to_builder(*builder, "}");
	return builder_to_string(*builder);
}
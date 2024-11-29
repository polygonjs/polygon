
sceneObserverOnObjectAdded :: (observer: Any, scene: *Scene, object:*$O) {
	#insert ON_OBJECT_ADDED;
	assert(false, tprint("sceneObserverOnObjectAdded: observer type '%' is not implemented", cast(*Type_Info_Struct)observer.type));
}
sceneObserverOnObjectBeforeRemove :: (observer: Any, scene: *Scene, object:*$O) {
	#insert ON_OBJECT_BEFORE_REMOVE;
	assert(false, tprint("sceneObserverOnObjectBeforeRemove: observer type '%' is not implemented", cast(*Type_Info_Struct)observer.type));
}
sceneObserverOnObjectsBeforeRemove :: (observer: Any, scene: *Scene, objects: []*$O) {
	#insert ON_OBJECTS_BEFORE_REMOVE;
	assert(false, tprint("sceneObserverOnObjectsBeforeRemove: observer type '%' is not implemented", cast(*Type_Info_Struct)observer.type));
}
sceneObserverOnRenderableMaterialChanged :: (observer: Any, scene: *Scene, object:*$O, previousMaterial:*Material) {
	#insert ON_RENDERABLE_MATERIAL_CHANGED;
	assert(false, tprint("sceneObserverOnRenderableMaterialChanged: observer type '%' is not implemented", cast(*Type_Info_Struct)observer.type));
}



#scope_file

ON_OBJECT_ADDED,
ON_OBJECT_BEFORE_REMOVE,
ON_OBJECTS_BEFORE_REMOVE,
ON_RENDERABLE_MATERIAL_CHANGED :: #run registerSceneObserver();

SCENE_OBSERVER_TYPES :[..]Type;

sceneObserverRegister :: ($T:Type) {
	array_add(*SCENE_OBSERVER_TYPES, T);
}

registerSceneObserver :: ()-> (
	ON_OBJECT_ADDED:string,
	ON_OBJECT_BEFORE_REMOVE:string,
	ON_OBJECTS_BEFORE_REMOVE:string,
	ON_RENDERABLE_MATERIAL_CHANGED:string
) {
	sceneObserverRegister(Renderer);

	IF_FIRST_LINE :: "if (cast(*Type_Info_Struct)observer.type).name == {\n";

	SceneObserverGeneratedCode :: struct {
		onObjectAdded: string;
		onObjectBeforeRemove: string;
		onObjectsBeforeRemove: string;
		onRenderableMaterialChanged: string;
	}

	generated: SceneObserverGeneratedCode;
	{
		builder: String_Builder;
		print_to_builder(*builder, IF_FIRST_LINE);
		for observerType: SCENE_OBSERVER_TYPES {
			print_to_builder(*builder, tprint("\tcase \"%\"; onObjectAdded(cast(*%) observer.value_pointer, scene, object); return;\n", observerType, observerType));
		}
		print_to_builder(*builder, "}");
		generated.onObjectAdded = builder_to_string(*builder);
	}
	{
		builder: String_Builder;
		// print_to_builder(*builder, "print(\"type:.\%.\\n\", (cast(*Type_Info_Struct)observer.type).name);");
		print_to_builder(*builder, IF_FIRST_LINE);
		for observerType: SCENE_OBSERVER_TYPES {
			print_to_builder(*builder, tprint("\tcase \"%\"; onObjectBeforeRemove(cast(*%) observer.value_pointer, scene, object); return;\n", observerType, observerType));
		}
		print_to_builder(*builder, "}");
		generated.onObjectBeforeRemove = builder_to_string(*builder);
	}
	{
		builder: String_Builder;
		// print_to_builder(*builder, "print(\"type:.\%.\\n\", (cast(*Type_Info_Struct)observer.type).name);");
		print_to_builder(*builder, IF_FIRST_LINE);
		for observerType: SCENE_OBSERVER_TYPES {
			print_to_builder(*builder, tprint("\tcase \"%\"; onObjectsBeforeRemove(cast(*%) observer.value_pointer, scene, objects); return;\n", observerType, observerType));
		}
		print_to_builder(*builder, "}");
		generated.onObjectsBeforeRemove = builder_to_string(*builder);
	}
	{
		builder: String_Builder;
		// print_to_builder(*builder, "print(\"type:.\%.\\n\", (cast(*Type_Info_Struct)observer.type).name);");
		print_to_builder(*builder, IF_FIRST_LINE);
		for observerType: SCENE_OBSERVER_TYPES {
			print_to_builder(*builder, tprint("\tcase \"%\"; onRenderableMaterialChanged(cast(*%) observer.value_pointer, scene, object, previousMaterial); return;\n", observerType, observerType));
		}
		print_to_builder(*builder, "}");
		generated.onRenderableMaterialChanged = builder_to_string(*builder);
	}
	
	return generated.onObjectAdded,
	generated.onObjectBeforeRemove,
	generated.onObjectsBeforeRemove,
	generated.onRenderableMaterialChanged;
}

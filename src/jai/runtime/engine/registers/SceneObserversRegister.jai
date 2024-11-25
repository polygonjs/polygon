
sceneObserverOnObjectAdded :: (observer: Any, scene: *Scene, object:*$O) {
	#insert SCENE_OBSERVER_ON_OBJECT_ADDED;
	assert(false, tprint("sceneObserverOnObjectAdded: observer type '%' is not implemented", cast(*Type_Info_Struct)observer.type));
}
sceneObserverOnObjectBeforeRemove :: (observer: Any, scene: *Scene, object:*$O) {
	#insert SCENE_OBSERVER_ON_OBJECT_BEFORE_REMOVE;
	assert(false, tprint("sceneObserverOnObjectBeforeRemove: observer type '%' is not implemented", cast(*Type_Info_Struct)observer.type));
}



#scope_file


SCENE_OBSERVER_ON_OBJECT_ADDED,
SCENE_OBSERVER_ON_OBJECT_BEFORE_REMOVE :: #run registerSceneObserver();

SCENE_OBSERVER_TYPES :[..]Type;

sceneObserverRegister :: ($T:Type) {
	array_add(*SCENE_OBSERVER_TYPES, T);
}

registerSceneObserver :: ()-> onObjectAdded:string, onObjectBeforeRemove:string {
	sceneObserverRegister(Renderer);

	IF_FIRST_LINE :: "if (cast(*Type_Info_Struct)observer.type).name == {\n";

	SceneObserverGeneratedCode :: struct {
		onObjectAdded: string;
		onObjectBeforeRemove: string;
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
	
	return 	generated.onObjectAdded,
			generated.onObjectBeforeRemove;
}

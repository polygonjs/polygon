
nodeSceneObserverOnNodeAdded :: (observer: Any, scene: *NodesScene, node:*BaseNodeAny) {
	#insert NODES_SCENE_OBSERVER_ON_NODE_ADDED;
	assert(false, tprint("nodeSceneObserverOnNodeAdded: observer type '%' is not implemented", observer.type));
}
nodeSceneObserverOnNodeBeforeRemove :: (observer: Any, scene: *NodesScene, node:*BaseNodeAny) {
	#insert NODES_SCENE_OBSERVER_ON_NODE_BEFORE_REMOVE;
	assert(false, tprint("nodeSceneObserverOnNodeBeforeRemove: observer type '%' is not implemented", observer.type));
}
nodeSceneObserverOnNodeConnectionAdded :: (observer: Any, scene: *NodesScene, connection:NodeConnection) {
	#insert NODES_SCENE_OBSERVER_ON_NODE_CONNECTION_ADDED;
	assert(false, tprint("nodeSceneObserverOnNodeConnectionAdded: observer type '%' is not implemented", observer.type));
}
nodeSceneObserverOnNodeConnectionRemoved :: (observer: Any, scene: *NodesScene, connection:NodeConnection) {
	#insert NODES_SCENE_OBSERVER_ON_NODE_CONNECTION_REMOVED;
	assert(false, tprint("nodeSceneObserverOnNodeConnectionRemoved: observer type '%' is not implemented", observer.type));
}


#scope_file


NODES_SCENE_OBSERVER_ON_NODE_ADDED,
NODES_SCENE_OBSERVER_ON_NODE_BEFORE_REMOVE,
NODES_SCENE_OBSERVER_ON_NODE_CONNECTION_ADDED,
NODES_SCENE_OBSERVER_ON_NODE_CONNECTION_REMOVED :: #run registerNodesSceneObserver();

NODES_SCENE_OBSERVER_TYPES :[..]Type;

nodesSceneObserverRegister :: ($T:Type) #compile_time {
	array_add(*NODES_SCENE_OBSERVER_TYPES, T);
}

registerNodesSceneObserver :: ()-> (
	onNodeAdded:string,
	onNodeBeforeRemove:string,
	onNodeconnectionAdded:string,
	onNodeConnectionRemoved:string) #compile_time {
	nodesSceneObserverRegister(Editor);

	IF_FIRST_LINE :: "if (cast(*Type_Info_Struct)observer.type).name == {\n";

	NodesSceneObserverGeneratedCode :: struct {
		onNodeAdded: string;
		onNodeBeforeRemove: string;
		onNodeConnectionAdded: string;
		onNodeConnectionRemoved: string;
	}

	generated: NodesSceneObserverGeneratedCode;
	{
		builder: String_Builder;
		print_to_builder(*builder, IF_FIRST_LINE);
		for observerType: NODES_SCENE_OBSERVER_TYPES {
			print_to_builder(*builder, tprint("\tcase \"%\"; onNodeAdded(cast(*%) observer.value_pointer, scene, node); return;\n", observerType, observerType));
		}
		print_to_builder(*builder, "}");
		generated.onNodeAdded = builder_to_string(*builder);
	}
	{
		builder: String_Builder;
		// print_to_builder(*builder, "print(\"type:.\%.\\n\", (cast(*Type_Info_Struct)observer.type).name);");
		print_to_builder(*builder, IF_FIRST_LINE);
		for observerType: NODES_SCENE_OBSERVER_TYPES {
			print_to_builder(*builder, tprint("\tcase \"%\"; onNodeBeforeRemove(cast(*%) observer.value_pointer, scene, node); return;\n", observerType, observerType));
		}
		print_to_builder(*builder, "}");
		generated.onNodeBeforeRemove = builder_to_string(*builder);
	}
	{
		builder: String_Builder;
		print_to_builder(*builder, IF_FIRST_LINE);
		for observerType: NODES_SCENE_OBSERVER_TYPES {
			print_to_builder(*builder, tprint("\tcase \"%\"; onNodeConnectionAdded(cast(*%) observer.value_pointer, scene, connection); return;\n", observerType, observerType));
		}
		print_to_builder(*builder, "}");
		generated.onNodeConnectionAdded = builder_to_string(*builder);
	}
	{
		builder: String_Builder;
		print_to_builder(*builder, IF_FIRST_LINE);
		for observerType: NODES_SCENE_OBSERVER_TYPES {
			print_to_builder(*builder, tprint("\tcase \"%\"; onNodeConnectionRemoved(cast(*%) observer.value_pointer, scene, connection); return;\n", observerType, observerType));
		}
		print_to_builder(*builder, "}");
		generated.onNodeConnectionRemoved = builder_to_string(*builder);
	}
	return 	generated.onNodeAdded,
			generated.onNodeBeforeRemove,
			generated.onNodeConnectionAdded,
			generated.onNodeConnectionRemoved;
}

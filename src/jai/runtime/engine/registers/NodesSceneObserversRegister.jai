
nodeSceneObserverOnNodeAdded :: (observer: Any, scene: *NodesScene, node:*$N) {
	#insert NODES_SCENE_OBSERVER_ON_NODE_ADDED;
	assert(false, tprint("nodeSceneObserverOnNodeAdded: node type '%' is not implemented", node.type));
}
nodeSceneObserverOnNodeBeforeRemove :: (observer: Any, scene: *NodesScene, node:*$N) {
	#insert NODES_SCENE_OBSERVER_ON_NODE_BEFORE_REMOVE;
	assert(false, tprint("nodeSceneObserverOnNodeBeforeRemove: node type '%' is not implemented", node.type));
}
nodeSceneObserverOnNodeInputAdded :: (observer: Any, scene: *NodesScene, node:*$N, inputIndex:u8) {
	#insert NODES_SCENE_OBSERVER_ON_NODE_INPUT_ADDED;
	assert(false, tprint("nodeSceneObserverOnNodeInputAdded: node type '%' is not implemented", node.type));
}
nodeSceneObserverOnNodeInputRemoved :: (observer: Any, scene: *NodesScene, node:*$N, inputIndex:u8) {
	#insert NODES_SCENE_OBSERVER_ON_NODE_INPUT_REMOVED;
	assert(false, tprint("nodeSceneObserverOnNodeInputRemoved: node type '%' is not implemented", node.type));
}


#scope_file


NODES_SCENE_OBSERVER_ON_NODE_ADDED,
NODES_SCENE_OBSERVER_ON_NODE_BEFORE_REMOVE,
NODES_SCENE_OBSERVER_ON_NODE_INPUT_ADDED,
NODES_SCENE_OBSERVER_ON_NODE_INPUT_REMOVED :: #run registerNodesSceneObserver();

NODES_SCENE_OBSERVER_TYPES :[..]Type;

nodesSceneObserverRegister :: ($T:Type) {
	array_add(*NODES_SCENE_OBSERVER_TYPES, T);
}

registerNodesSceneObserver :: ()-> onNodeAdded:string, onNodeBeforeRemove:string, onNodeInputAdded:string, onNodeInputRemoved:string {
	nodesSceneObserverRegister(Editor);

	IF_FIRST_LINE :: "if (cast(*Type_Info_Struct)observer.type).name == {\n";

	NodesSceneObserverGeneratedCode :: struct {
		onNodeAdded: string;
		onNodeBeforeRemove: string;
		onNodeInputAdded: string;
		onNodeInputRemoved: string;
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
			print_to_builder(*builder, tprint("\tcase \"%\"; onNodeInputAdded(cast(*%) observer.value_pointer, scene, node, inputIndex); return;\n", observerType, observerType));
		}
		print_to_builder(*builder, "}");
		generated.onNodeInputAdded = builder_to_string(*builder);
	}
	{
		builder: String_Builder;
		print_to_builder(*builder, IF_FIRST_LINE);
		for observerType: NODES_SCENE_OBSERVER_TYPES {
			print_to_builder(*builder, tprint("\tcase \"%\"; onNodeInputRemoved(cast(*%) observer.value_pointer, scene, node, inputIndex); return;\n", observerType, observerType));
		}
		print_to_builder(*builder, "}");
		generated.onNodeInputRemoved = builder_to_string(*builder);
	}
	return 	generated.onNodeAdded,
			generated.onNodeBeforeRemove,
			generated.onNodeInputAdded,
			generated.onNodeInputRemoved;
}

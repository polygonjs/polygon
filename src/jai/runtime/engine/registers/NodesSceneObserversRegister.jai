
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
nodeSceneObserverOnComputeStarted :: (observer: Any, scene: *NodesScene) {
	#insert NODES_SCENE_OBSERVER_ON_COMPUTE_STARTED;
	assert(false, tprint("nodeSceneObserverOnComputeStarted: observer type '%' is not implemented", observer.type));
}
nodeSceneObserverOnComputeCompleted :: (observer: Any, scene: *NodesScene) {
	#insert NODES_SCENE_OBSERVER_ON_COMPUTE_COMPLETED;
	assert(false, tprint("nodeSceneObserverOnComputeCompleted: observer type '%' is not implemented", observer.type));
}


#scope_file


NODES_SCENE_OBSERVER_ON_NODE_ADDED,
NODES_SCENE_OBSERVER_ON_NODE_BEFORE_REMOVE,
NODES_SCENE_OBSERVER_ON_NODE_CONNECTION_ADDED,
NODES_SCENE_OBSERVER_ON_NODE_CONNECTION_REMOVED,
NODES_SCENE_OBSERVER_ON_COMPUTE_STARTED,
NODES_SCENE_OBSERVER_ON_COMPUTE_COMPLETED :: #run registerNodesSceneObserver();

NODES_SCENE_OBSERVER_TYPES :[..]Type;

IF_FIRST_LINE :: "if (cast(*Type_Info_Struct)observer.type).name == {\n";


nodesSceneObserverRegister :: ($T:Type) #compile_time {
	array_add(*NODES_SCENE_OBSERVER_TYPES, T);
}

registerNodesSceneObserver :: ()-> (
	onNodeAdded:string,
	onNodeBeforeRemove:string,
	onNodeconnectionAdded:string,
	onNodeConnectionRemoved:string,
	onComputeStarted:string,
	onComputeCompleted:string) #compile_time {

	#if USE_EDITOR {
		nodesSceneObserverRegister(Editor);
	}


	NodesSceneObserverGeneratedCode :: struct {
		onNodeAdded: string;
		onNodeBeforeRemove: string;
		onNodeConnectionAdded: string;
		onNodeConnectionRemoved: string;
		onComputeStarted: string;
		onComputeCompleted: string;
	}

	generated: NodesSceneObserverGeneratedCode;
	// {
	// 	builder: String_Builder;
	// 	print_to_builder(*builder, IF_FIRST_LINE);
	// 	for observerType: NODES_SCENE_OBSERVER_TYPES {
	// 		print_to_builder(*builder, tprint("\tcase \"%\"; onNodeAdded(cast(*%) observer.value_pointer, scene, node); return;\n", observerType, observerType));
	// 	}
	// 	print_to_builder(*builder, "}");
	// 	generated.onNodeAdded = builder_to_string(*builder);
	// }
	// {
	// 	builder: String_Builder;
	// 	// print_to_builder(*builder, "print(\"type:.\%.\\n\", (cast(*Type_Info_Struct)observer.type).name);");
	// 	print_to_builder(*builder, IF_FIRST_LINE);
	// 	for observerType: NODES_SCENE_OBSERVER_TYPES {
	// 		print_to_builder(*builder, tprint("\tcase \"%\"; onNodeBeforeRemove(cast(*%) observer.value_pointer, scene, node); return;\n", observerType, observerType));
	// 	}
	// 	print_to_builder(*builder, "}");
	// 	generated.onNodeBeforeRemove = builder_to_string(*builder);
	// }
	generated.onNodeAdded = _forNode("onNodeAdded");
	generated.onNodeBeforeRemove = _forNode("onNodeBeforeRemove");
	// {
	// 	builder: String_Builder;
	// 	print_to_builder(*builder, IF_FIRST_LINE);
	// 	for observerType: NODES_SCENE_OBSERVER_TYPES {
	// 		print_to_builder(*builder, tprint("\tcase \"%\"; onNodeConnectionAdded(cast(*%) observer.value_pointer, scene, connection); return;\n", observerType, observerType));
	// 	}
	// 	print_to_builder(*builder, "}");
	// 	generated.onNodeConnectionAdded = builder_to_string(*builder);
	// }
	// {
	// 	builder: String_Builder;
	// 	print_to_builder(*builder, IF_FIRST_LINE);
	// 	for observerType: NODES_SCENE_OBSERVER_TYPES {
	// 		print_to_builder(*builder, tprint("\tcase \"%\"; onNodeConnectionRemoved(cast(*%) observer.value_pointer, scene, connection); return;\n", observerType, observerType));
	// 	}
	// 	print_to_builder(*builder, "}");
	// 	generated.onNodeConnectionRemoved = builder_to_string(*builder);
	// }
	generated.onNodeConnectionAdded = _forConnection("onNodeConnectionAdded");
	generated.onNodeConnectionRemoved = _forConnection("onNodeConnectionRemoved");

	generated.onComputeStarted = _forScene("onComputeStarted");
	generated.onComputeCompleted = _forScene("onComputeCompleted");

	return 	generated.onNodeAdded,
			generated.onNodeBeforeRemove,
			generated.onNodeConnectionAdded,
			generated.onNodeConnectionRemoved,
			generated.onComputeStarted,
			generated.onComputeCompleted;
}

_forScene :: (functionName:string)->string {
	builder: String_Builder;
	// print_to_builder(*builder, "print(\"type:.\%.\\n\", (cast(*Type_Info_Struct)observer.type).name);");
	print_to_builder(*builder, IF_FIRST_LINE);
	for observerType: NODES_SCENE_OBSERVER_TYPES {
		print_to_builder(*builder, tprint("\tcase \"%\"; %(cast(*%) observer.value_pointer, scene); return;\n", observerType, functionName, observerType));
	}
	print_to_builder(*builder, "}");
	return builder_to_string(*builder);
}
_forNode :: (functionName:string)->string {
	builder: String_Builder;
	// print_to_builder(*builder, "print(\"type:.\%.\\n\", (cast(*Type_Info_Struct)observer.type).name);");
	print_to_builder(*builder, IF_FIRST_LINE);
	for observerType: NODES_SCENE_OBSERVER_TYPES {
		print_to_builder(*builder, tprint("\tcase \"%\"; %(cast(*%) observer.value_pointer, scene, node); return;\n", observerType, functionName, observerType));
	}
	print_to_builder(*builder, "}");
	return builder_to_string(*builder);
}
_forConnection :: (functionName:string)->string {
	builder: String_Builder;
	print_to_builder(*builder, IF_FIRST_LINE);
	for observerType: NODES_SCENE_OBSERVER_TYPES {
		print_to_builder(*builder, tprint("\tcase \"%\"; %(cast(*%) observer.value_pointer, scene, connection); return;\n", observerType, functionName, observerType));
	}
	print_to_builder(*builder, "}");
	return builder_to_string(*builder);
}
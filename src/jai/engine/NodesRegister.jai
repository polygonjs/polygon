// NodeCastFunction :: #type (node: *CoreGraphNode)->Type;

// TypePair :: struct {
// 	src: Type;
// 	dest: Type;
// };


// #run array_i(*NODE_CAST_TYPE_BY_TYPE, 64);


// generatedNodeInit :: (scene: *NodesScene, node: *$T) {
// 	#insert GENERATED_CODE_NODE_INIT;
// 	assert(false, tprint("generatedNodeInit: node type % is not implemented", inputNode.type));
// }

nodeSceneObserverOnNodeAdded :: (observer: Any, scene: *NodesScene, node:*$N) {
	#insert NODES_SCENE_OBSERVER_ON_NODE_ADDED;
	assert(false, tprint("nodeSceneObserverOnNodeAdded: node type % is not implemented", node.type));
}
nodeSceneObserverOnNodeRemoved :: (observer: Any, scene: *NodesScene, node:*$N) {
	#insert NODES_SCENE_OBSERVER_ON_NODE_REMOVED;
	assert(false, tprint("nodeSceneObserverOnNodeRemoved: node type % is not implemented", node.type));
}
nodeSceneObserverOnNodeInputAdded :: (observer: Any, scene: *NodesScene, node:*$N, inputIndex:u8) {
	#insert NODES_SCENE_OBSERVER_ON_NODE_INPUT_ADDED;
	assert(false, tprint("nodeSceneObserverOnNodeInputAdded: node type % is not implemented", node.type));
}
nodeSceneObserverOnNodeInputRemoved :: (observer: Any, scene: *NodesScene, node:*$N, inputIndex:u8) {
	#insert NODES_SCENE_OBSERVER_ON_NODE_INPUT_REMOVED;
	assert(false, tprint("nodeSceneObserverOnNodeInputRemoved: node type % is not implemented", node.type));
}

generatedNodeCompute :: (inputNode: *$T, depth:u8=0)->GeoNodeCookOutput {
	#insert GENERATED_CODE_NODE_COMPUTE;
	assert(false, tprint("generatedNodeCompute: node type % is not implemented", inputNode.type));
	return newObject3D(Mesh);
}

generatedSceneNodeDelete :: (scene: *NodesScene, node: *$T, $removeFromGraph:bool = true) {
	#insert GENERATED_CODE_SCENE_NODE_DELETE;
	assert(false, tprint("generatedSceneNodeDelete: node type % is not implemented", node.type));
}

generatedCameraProjectionUpdate :: (object:*$T) {
	#insert GENERATED_CODE_CAMERA_PROJECTION_UPDATE;
	assert(false, tprint("generatedCameraProjectionUpdate: object type % is not implemented", object.type));
}

#scope_file


GENERATED_CODE_NODE_COMPUTE,
GENERATED_CODE_SCENE_NODE_DELETE :: #run registerNodes();

GENERATED_CODE_CAMERA_PROJECTION_UPDATE :: #run registerCameras();

NODES_SCENE_OBSERVER_ON_NODE_ADDED,
NODES_SCENE_OBSERVER_ON_NODE_REMOVED,
NODES_SCENE_OBSERVER_ON_NODE_INPUT_ADDED,
NODES_SCENE_OBSERVER_ON_NODE_INPUT_REMOVED :: #run registerNodesSceneObserver();


NOTE_TYPES :[..]Type;
CAMERA_TYPES :[..]Type;
NODES_SCENE_OBSERVER_TYPES :[..]Type;
// PARAM_TYPES :[..]Type;

nodeRegister :: ($T:Type) {
	array_add(*NOTE_TYPES, T);
}
cameraRegister :: ($T:Type) {
	array_add(*CAMERA_TYPES, T);
}

nodesSceneObserverRegister :: ($T:Type) {
	array_add(*NODES_SCENE_OBSERVER_TYPES, T);
}
// paramRegister :: ($paramType:Type) {
// 	// print("> paramRegister: %\n", paramType);
// 	array_add(*PARAM_TYPES, paramType);
// 	// table_set(*NODE_CAST_TYPE_BY_TYPE, nodeType, T);
// }

registerNodesSceneObserver :: ()-> onNodeAdded:string, onNodeRemoved:string, onNodeInputAdded:string, onNodeInputRemoved:string {
	nodesSceneObserverRegister(Editor);

	IF_FIRST_LINE :: "if (cast(*Type_Info_Struct)observer.type).name == {\n";

	SceneObserverGeneratedCode :: struct {
		onNodeAdded: string;
		onNodeRemoved: string;
		onNodeInputAdded: string;
		onNodeInputRemoved: string;
	}

	generated: SceneObserverGeneratedCode;
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
		print_to_builder(*builder, IF_FIRST_LINE);
		for observerType: NODES_SCENE_OBSERVER_TYPES {
			print_to_builder(*builder, tprint("\tcase \"%\"; onNodeRemoved(cast(*%) observer.value_pointer, scene, node); return;\n", observerType, observerType));
		}
		print_to_builder(*builder, "}");
		generated.onNodeRemoved = builder_to_string(*builder);
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
			generated.onNodeRemoved,
			generated.onNodeInputAdded,
			generated.onNodeInputRemoved;
}
// generateNodeInits :: ()->string {
// 	builder: String_Builder;
// 	print_to_builder(*builder, "if node.type == {\n");
// 	for nodeType: NOTE_TYPES {
// 		print_to_builder(*builder, tprint("\tcase %; nodeInit(scene, cast(*%) node); return;\n", nodeType, nodeType));
// 	}
// 	print_to_builder(*builder, "}");

// 	result := builder_to_string(*builder);
// 	return result;
// }
generateNodeComputes :: ()->string {
	builder: String_Builder;
	print_to_builder(*builder, "if inputNode.type == {\n");
	for nodeType: NOTE_TYPES {
		print_to_builder(*builder, tprint("\tcase %; return nodeCompute(cast(*%) inputNode, depth);\n", nodeType, nodeType));
	}
	print_to_builder(*builder, "}");

	result := builder_to_string(*builder);
	return result;
}
generateSceneNodeDelete :: ()->string {
	builder: String_Builder;
	print_to_builder(*builder, "if node.type == {\n");
	for nodeType: NOTE_TYPES {
		print_to_builder(*builder, tprint("\tcase %; sceneDeleteNode(scene, cast(*%) node, removeFromGraph);return;\n", nodeType, nodeType));
	}
	print_to_builder(*builder, "}");

	result := builder_to_string(*builder);
	return result;
}

registerNodes :: () -> nodeCompute:string, sceneNodeDelete:string {
	// paramRegister(FloatParam);
	// paramRegister(UIntegerParam);
	// paramRegister(Vector3Param);
	// paramRegister(Vector3UIntParam);

	nodeRegister(BoxGeoNode);
	nodeRegister(IcosahedronGeoNode);
	nodeRegister(MergeGeoNode);
	nodeRegister(NullGeoNode);
	nodeRegister(OutputGeoNode);

	// nodeInit := generateNodeInits();
	nodeCompute := generateNodeComputes();
	sceneNodeDelete := generateSceneNodeDelete();

	return 	nodeCompute,
			sceneNodeDelete;
}
registerCameras :: () -> projectionUpdate:string {

	cameraRegister(PerspectiveCamera);
	cameraRegister(OrthographicCamera);

	builder: String_Builder;
	print_to_builder(*builder, "if object.type == {\n");
	for type: CAMERA_TYPES {
		print_to_builder(*builder, tprint("\tcase %; cameraProjectionUpdate( cast(*%) object);return;\n", type, type));
	}
	print_to_builder(*builder, "}");

	result := builder_to_string(*builder);

	return result;
}


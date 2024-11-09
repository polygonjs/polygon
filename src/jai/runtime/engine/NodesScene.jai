NodeId :: u32;

NodesScene :: struct {
	nextNodeId: NodeId = INIT_NEXT_NODE_ID;
	graph: CoreGraph;
	time:Time=0;
	timeGraphNode:TimeNode;
	nodes: [..]*GeoNodeAny;
	worldScene: *Scene;
	cookResultByNodeId:Table(CoreGraphNodeId, GeoNodeCookOutput);

	// #if NODES_SCENE_EMIT_EVENTS { // maybe let's keep this in the struct until we have tested serializing
		observers:[..]Any;
	// }
	// allocator: Allocator;
	// temporary_storage: Temporary_Storage;
}

NodesSceneEvent :: enum u8 {
	NODE_ADDED :: 0;
	NODE_REMOVED;
	NODE_INPUT_ADDED;
	NODE_INPUT_REMOVED;
}



// SCENE_ALLOCATOR :Allocator: .{temporary_allocator_proc, null};
// SCENE_TEMPORARY_STORAGE :Temporary_Storage = .{};

newNodesScene :: (/*allocator: Allocator=SCENE_ALLOCATOR*/) -> *NodesScene {
	// print("temporary_storage: %\n", <<context.temporary_storage);
	// push_allocator(allocator);
	scene: *NodesScene = alloc(size_of(NodesScene));

	array_init(*scene.nodes);
	// #if NODES_SCENE_EMIT_EVENTS {
		array_init(*scene.observers);
	// }
	{
		graph:CoreGraph;
		graph.scene = scene;
		graph_member := get_field(type_info(NodesScene), "graph");
		src_ptr := cast(*u8)*graph;
		target_ptr := cast(*u8)scene + graph_member.offset_in_bytes;
		memcpy(target_ptr, src_ptr, size_of(CoreGraph));
	}
	scene.time = 0;
	sceneInit(scene);

	return scene;
}
sceneInit :: (scene: *NodesScene) {
	scene.nextNodeId = INIT_NEXT_NODE_ID;
	// scene.allocator = allocator;
	// scene.temporary_storage = SCENE_TEMPORARY_STORAGE;
	// sceneAllocatorPush(scene);
	init(*scene.cookResultByNodeId, 64);

	graphInit(*scene.graph, scene);
	scene.timeGraphNode.type = TimeNode;
	graphNodeInit(*scene.timeGraphNode, *scene.graph);

	scene.worldScene = newObject3D(Scene);
}
sceneDelete :: (scene: *NodesScene) {
	for node, i: scene.nodes {
		if node != null {
			generatedSceneNodeDelete(scene, node, removeFromGraph=false);
		}
	}
	{
		using scene;
		array_reset(*nodes);
		deinit(*cookResultByNodeId);
		graphDelete(*graph);
	}
	object3DDelete(scene.worldScene);
	free(scene/*,,allocator=scene.allocator*/);
	// sceneAllocatorPush(scene);
	// reset_temporary_storage();
}
// sceneAllocatorPush :: (scene: *NodesScene) #expand #no_debug {
// 	old_allocator := context.allocator;
// 	old_temporary_storage := context.temporary_storage;
// 	context.allocator = scene.allocator;
// 	context.temporary_storage = *scene.temporary_storage;

// 	`defer context.allocator = old_allocator;
// 	`defer context.temporary_storage = old_temporary_storage;
// }
sceneAddObserver :: (scene: *NodesScene, observer: Any) {
	array_add(*scene.observers, observer);
}
sceneEmitEvent :: (scene: *NodesScene, $event: NodesSceneEvent, node: *$T) {
	if event == {
		case NodesSceneEvent.NODE_ADDED; 	{for o: scene.observers nodeSceneObserverOnNodeAdded(o, scene, node); return;}
		case NodesSceneEvent.NODE_REMOVED; 	{for o: scene.observers nodeSceneObserverOnNodeRemoved(o, scene, node); return;}
	}
}
sceneEmitEvent :: (scene: *NodesScene, $event: NodesSceneEvent, node: *$T, inputIndex: u8=0) {
	if event == {
		case NodesSceneEvent.NODE_INPUT_ADDED; 	{for o: scene.observers nodeSceneObserverOnNodeInputAdded(o, scene, node, inputIndex); return;}
		case NodesSceneEvent.NODE_INPUT_REMOVED;{for o: scene.observers nodeSceneObserverOnNodeInputRemoved(o, scene, node, inputIndex); return;}
	}
}

sceneDeleteNode :: (scene: *NodesScene, node: *$T, $removeFromGraph:bool = true) {
	found, index := array_find(scene.nodes, cast(*GeoNodeAny)node);
	assert(found, "node not found");

	#if removeFromGraph {
		for :params param: node { graphNodeDelete(param); }
		graphNodeDelete(node);
	}
	array_reset(*node.params);

	free(node);
	scene.nodes[index] = null;

	#if NODES_SCENE_EMIT_EVENTS {
		sceneEmitEvent(scene, NodesSceneEvent.NODE_REMOVED, node);
	}
}

sceneOnTick :: (scene: *NodesScene, time:Time) {
	sceneSetTime(scene, time);
	sceneUniformsUpdate(scene);
}

// sceneDebug :: (scene: *NodesScene, message:string) {
// 	print("---- sceneDebug START (%) (%)\n", scene, message);
// 	print("count: %\n", scene.nodes.count);
// 	for node, i: scene.nodes {
// 		print("% %", i, node);
// 		print("   % % %\n", i, node.type, node.inputs);
// 	}
// 	print("---- sceneDebug END\n");
// }

#scope_file

INIT_NEXT_NODE_ID :NodeId: 1;

sceneSetTime :: (scene: *NodesScene, time:Time) {
	scene.time = time;
	setDirty(*scene.timeGraphNode);
}
sceneUniformsUpdate :: (scene: *NodesScene) {
	sceneUniformsUpdate(scene.worldScene, scene.time);
}
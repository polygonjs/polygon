NodeId :: u32;

NodesScene :: struct {
	nextNodeId: NodeId = INIT_NEXT_NODE_ID;
	graph: CoreGraph;
	time:Time=0;
	timeGraphNode:TimeNode;
	// validNodeIds: Bit_Array;
	nodes: [..]*GeoNodeAny;
	worldScene: *Scene;
	nodeInputCookResults:[..]GeoNodeCookInput;
	cookResults:[..]GeoNodeCookOutput;
	connections: NodeConnectionList;

	// #if NODES_SCENE_EMIT_EVENTS { // maybe let's keep this in the struct until we have tested serializing
		// observers:[..]Any;
		observer:Any;
	// }
	// allocator: Allocator;
	// temporary_storage: Temporary_Storage;
}




// SCENE_ALLOCATOR :Allocator: .{temporary_allocator_proc, null};
// SCENE_TEMPORARY_STORAGE :Temporary_Storage = .{};

newNodesScene :: (/*allocator: Allocator=SCENE_ALLOCATOR*/) -> *NodesScene {
	// print("temporary_storage: %\n", <<context.temporary_storage);
	// push_allocator(allocator);
	scene: *NodesScene = alloc(size_of(NodesScene));

	{
		using scene;
		array_init(*nodes);
		nodeConnectionListInit(*connections);
		// #if NODES_SCENE_EMIT_EVENTS {
			// array_init(*observers);
		// }
	}
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
	using scene;
	nextNodeId = INIT_NEXT_NODE_ID;
	// array_add(*nodes, null);
	// bit_array_resize(*validNodeIds, 1);
	// validNodeIds[0] = false;
	// scene.allocator = allocator;
	// scene.temporary_storage = SCENE_TEMPORARY_STORAGE;
	// sceneAllocatorPush(scene);
	array_init(*nodeInputCookResults);
	array_init(*cookResults);
	graphInit(*graph, scene);
	scene.timeGraphNode.type = TimeNode;
	graphNodeInit(*scene.timeGraphNode, *scene.graph);

	scene.worldScene = newObject3D(Scene);
}

// sceneAllocatorPush :: (scene: *NodesScene) #expand #no_debug {
// 	old_allocator := context.allocator;
// 	old_temporary_storage := context.temporary_storage;
// 	context.allocator = scene.allocator;
// 	context.temporary_storage = *scene.temporary_storage;

// 	`defer context.allocator = old_allocator;
// 	`defer context.temporary_storage = old_temporary_storage;
// }





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

INIT_NEXT_NODE_ID :NodeId: 0;


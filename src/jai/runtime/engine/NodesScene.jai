

NodesScene :: struct {
	pool: Flat_Pool;
	allocator: Allocator;
	//
	nextNodeId: NodeId = INIT_NEXT_NODE_ID;
	graph: CoreGraph;
	time:Time=0;
	timeGraphNode:TimeNode;
	// nodes: [..]*GeoNodeAny;
	validNodeTypes: Bit_Array;
	nodeTypes: [..]*BaseNodeAny;
	worldScene: *Scene;
	nodeInputCookResults:[..]GeoNodeCookInput;
	cookResults:[..]GeoNodeCookOutput;
	cooksCount:[..]u32;
	connections: NodeConnectionList;
	defaultMaterial: *Material;

	// #if NODES_SCENE_EMIT_EVENTS { // maybe let's keep this in the struct until we have tested serializing
		// observers:[..]Any;
		observer:Any;
	// }
	// allocator: Allocator;
	// temporary_storage: Temporary_Storage;
}



// SCENE_ALLOCATOR :Allocator: .{temporary_allocator_proc, null};
// SCENE_TEMPORARY_STORAGE :Temporary_Storage = .{};

newNodesScene :: (_allocator: *Allocator=null) -> *NodesScene {
	// print("temporary_storage: %\n", <<context.temporary_storage);
	// push_allocator(allocator);
	scene: *NodesScene = alloc(size_of(NodesScene));
	if _allocator == null {
		flat_pool:Flat_Pool;
		scene.pool = flat_pool;
		scene.allocator.proc = flat_pool_allocator_proc;
		scene.allocator.data = *scene.pool;
		// scene.allocator = *get_unmapping_allocator();
	} else {
		scene.allocator = _allocator;
	}
	scene.defaultMaterial = xx newMaterial(NormalMeshMaterial, scene);
	{
		using scene;
		// #if NODES_SCENE_EMIT_EVENTS {
			// array_init(*observers);
		// }
	}
	{
		graph:CoreGraph;
		graph.scene = scene;
		graph_member := get_field(type_info(NodesScene), "graph");
		srPtr := cast(*u8)*graph;
		targetPtr := cast(*u8)scene + graph_member.offset_in_bytes;
		memcpy(targetPtr, srPtr, size_of(CoreGraph));
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
	// array_init(*nodes);
	array_init(*nodeTypes, scene.allocator);
	nodeConnectionListInit(*connections);
	array_init(*nodeInputCookResults, scene.allocator);
	array_init(*cookResults, scene.allocator);
	array_init(*cooksCount, scene.allocator);
	graphInit(*graph, scene);
	// scene.timeGraphNode.type = TimeNode;
	scene.timeGraphNode.name = "TimeNode";
	graphAddNode(*scene.graph, *scene.timeGraphNode);

	scene.worldScene = newScene(scene);
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


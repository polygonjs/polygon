NodesScene :: struct {
	nodes: [..]*GeoNodeAny;
	graph: CoreGraph;
	worldScene: *Scene;
	cookResultByNodeId:Table(CoreGraphNodeId, GeoNodeCookOutput);

	// allocator: Allocator;
	// temporary_storage: Temporary_Storage;
}

// SCENE_ALLOCATOR :Allocator: .{temporary_allocator_proc, null};
// SCENE_TEMPORARY_STORAGE :Temporary_Storage = .{};

newNodesScene :: (/*allocator: Allocator=SCENE_ALLOCATOR*/) -> *NodesScene {
	// print("temporary_storage: %\n", <<context.temporary_storage);
	// push_allocator(allocator);
	scene: *NodesScene = alloc(size_of(NodesScene));
	// scene.allocator = allocator;
	// scene.temporary_storage = SCENE_TEMPORARY_STORAGE;
	// sceneAllocatorPush(scene);
	array_init(*scene.nodes);
	init(*scene.cookResultByNodeId, 64);

	{
		graph:CoreGraph;
		graph.scene = scene;
		graph_member := get_field(type_info(NodesScene), "graph");
		src_ptr := cast(*u8)*graph;
		target_ptr := cast(*u8)scene + graph_member.offset_in_bytes;
		memcpy(target_ptr, src_ptr, size_of(CoreGraph));
	}
	graphInit(*scene.graph);

	scene.worldScene = newObject3D(Scene);
	
	return scene;
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



NodesScene :: struct {
	#if USE_FLAT_POOL {
		pool: Flat_Pool;
	} else #if USE_POOL {
		pool: Pool;
	}
	allocator: Allocator;
	//
	nextNodeId: NodeId = INIT_NEXT_NODE_ID;
	graph: CoreGraph;
	time:Time=0;
	timeGraphNode:TimeNode;
	framesCount:FrameCount = 0;
	fps:FrameCount = 0;
	validNodes: Bit_Array;
	nodes: [..]*BaseNodeAny;
	nodeNames: [..]NodeName;
	worldScene: *Scene;
	cookResults:[..]GeoNodeCookOutput;
	nodeInputCookResults:[..][NODE_MAX_INPUTS_COUNT]GeoNodeCookOutput;
	cookResultsToDispose:[..]*Object3D;
	cooksCount:[..]u32;
	connections: NodeConnectionList;

	DefaultMaterial :: struct {
		line: *LineBasicMaterial;
		mesh: *MeshBasicMaterial;
		point: *PointBasicMaterial;
	}
	defaultMaterial:DefaultMaterial;

	// #if NODES_SCENE_EMIT_EVENTS { // maybe let's keep this in the struct until we have tested serializing
		// observers:[..]Any;
		observer:Any;
	// }
	// allocator: Allocator;
	// temporary_storage: Temporary_Storage;

	computablesTree:ComputablesTree;
	nodeRequests:[..]NodeSceneRequest;
}



// SCENE_ALLOCATOR :Allocator: .{temporary_allocator_proc, null};
// SCENE_TEMPORARY_STORAGE :Temporary_Storage = .{};

newNodesScene :: (_allocator: *Allocator=null) -> *NodesScene {
	// print("temporary_storage: %\n", <<context.temporary_storage);
	// push_allocator(allocator);
	scene: *NodesScene = New(NodesScene);
	if _allocator == null {
		allocatorAssign(scene);
	} else {
		scene.allocator = _allocator;
	}
	{
		// using scene;
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
	_sceneInit(scene);

	return scene;
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

_sceneInit :: (using scene: *NodesScene) {
	nextNodeId = INIT_NEXT_NODE_ID;
	// array_add(*nodes, null);
	// bit_array_resize(*validNodeIds, 1);
	// validNodeIds[0] = false;
	// scene.allocator = allocator;
	// scene.temporary_storage = SCENE_TEMPORARY_STORAGE;
	// sceneAllocatorPush(scene);
	// array_init(*nodes);
	array_init(*nodes, scene.allocator, reserve=true);
	array_init(*nodeNames, scene.allocator, reserve=true);
	nodeConnectionListInit(scene);
	array_init(*nodeInputCookResults, scene.allocator, reserve=true);
	array_init(*cookResults, scene.allocator, reserve=true);
	array_init(*cooksCount, scene.allocator, reserve=true);
	array_init(*cookResultsToDispose, scene.allocator, reserve=true);
	graphInit(*graph, scene);
	// scene.timeGraphNode.type = TimeNode;
	// scene.timeGraphNode.name = "TimeNode";
	graphAddNode(*scene.graph, *scene.timeGraphNode);

	nodesSceneComputableTreeInit(scene);

	array_init(*nodeRequests, scene.allocator, reserve=true);

	scene.worldScene = newScene(scene);
	scene.defaultMaterial.line = xx newMaterial(scene.worldScene, LineBasicMaterial);
	scene.defaultMaterial.mesh = xx newMaterial(scene.worldScene, MeshNormalMaterial);
	scene.defaultMaterial.point = xx newMaterial(scene.worldScene, PointBasicMaterial);

}
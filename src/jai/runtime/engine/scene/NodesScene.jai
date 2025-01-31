
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
	worldScene: Scene;
	cookResults:[..]GeoNodeCookOutput;
	nodeInputCookResults:[..][NODES_MAX_INPUTS_COUNT]GeoNodeCookOutput;
	cookResultsToDispose:[..]*Object3DAny;
	cooksCount:[..]u32;
	connections: NodeConnectionList;

	DefaultMaterial :: struct {
		line: LineBasicMaterial;
		mesh: MeshNormalMaterial;
		point: PointBasicMaterial;
		uv: MeshUVMaterial;
		basicTexture: MeshBasicTextureMaterial;
		text: MeshTextMaterial;
		// backgroundBasic: MeshBackgroundBasicMaterial;
	}
	defaultMaterial:DefaultMaterial;
	// backgroundMeshData:BackgroundMeshData;

	// #if NODES_SCENE_EMIT_EVENTS { // maybe let's keep this in the struct until we have tested serializing
		// observers:[..]Any;
		observer:Any;
	// }
	// allocator: Allocator;
	// temporary_storage: Temporary_Storage;

	computablesTree:ComputablesTree;
	nodeRequests:[..]NodeSceneRequest;

	onBeforeTick: NodesSceneOnBeforeTickCallback=DEFAULT_NODES_SCENE_ON_BEFORE_TICK;
	onNodesComputed:NodesSceneOnNodesComputedCallback = DEFAULT_NODES_SCENE_ON_NODES_COMPUTED;

	initialized:bool = false;
	disposed:bool = false;

	#if FOR_THREE {
		threeReport: NodesSceneThreeReport;
		threeReportObjects: [..]NodesSceneThreeReportObjectItem;
	}
}



// SCENE_ALLOCATOR :Allocator: .{temporary_allocator_proc, null};
// SCENE_TEMPORARY_STORAGE :Temporary_Storage = .{};

// newNodesScene :: () -> *NodesScene {
// 	// print("temporary_storage: %\n", <<context.temporary_storage);
// 	// push_allocator(allocator);
// 	scene: *NodesScene = New(NodesScene);
// 	// } else {
// 	// 	scene.allocator = _allocator;
// 	// }
// 	{
// 		// using scene;
// 		// #if NODES_SCENE_EMIT_EVENTS {
// 			// array_init(*observers);
// 		// }
// 	}
// 	{
// 		graph:CoreGraph;
// 		graph.scene = scene;
// 		graph_member := get_field(type_info(NodesScene), "graph");
// 		srPtr := cast(*u8)*graph;
// 		targetPtr := cast(*u8)scene + graph_member.offset_in_bytes;
// 		memcpy(targetPtr, srPtr, size_of(CoreGraph));
// 	}
// 	scene.time = 0;
// 	nodesSceneInit(scene);

// 	return scene;
// }


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

nodesSceneValid :: (scene: *NodesScene)-> bool {
	return scene.initialized==true && scene.disposed==false;
}

nodesSceneInit :: (scene: *NodesScene) {
	if(scene.disposed==true){
		assert(false, "scene: already disposed");
		return;
	}
	if(scene.initialized==true){
		assert(false, "nodesSceneInit: already initialized");
		return;
	}
	scene.initialized = true;

	allocatorAssign(scene);

	// using scene;
	scene.nextNodeId = INIT_NEXT_NODE_ID;
	// array_add(*nodes, null);
	// bit_array_resize(*validNodeIds, 1);
	// validNodeIds[0] = false;
	// scene.allocator = allocator;
	// scene.temporary_storage = SCENE_TEMPORARY_STORAGE;
	// sceneAllocatorPush(scene);
	// array_init(*nodes);
	{
		push_allocator(scene.allocator);
		init_bit_array(*scene.validNodes);
	}
	// scene.validNodes.allocator = scene.allocator;
	array_init(*scene.nodes, scene.allocator, reserve=true);
	array_init(*scene.nodeNames, scene.allocator, reserve=true);
	nodeConnectionListInit(scene);
	array_init(*scene.nodeInputCookResults, scene.allocator, reserve=true);
	array_init(*scene.cookResults, scene.allocator, reserve=true);
	array_init(*scene.cooksCount, scene.allocator, reserve=true);
	array_init(*scene.cookResultsToDispose, scene.allocator, reserve=true);
	graphInit(*scene.graph, scene);
	// scene.timeGraphNode.type = TimeNode;
	// scene.timeGraphNode.name = "TimeNode";
	graphAddNode(*scene.graph, *scene.timeGraphNode);

	nodesSceneComputableTreeInit(scene);

	array_init(*scene.nodeRequests, scene.allocator, reserve=true);
	#if FOR_THREE {
		nodesSceneInitThreeReport(scene);
	}

	// scene.worldScene = newScene(scene);
	worldSceneInit(*scene.worldScene);
	{
		using scene.defaultMaterial;
		materialInit(*line);
		materialInit(*mesh);
		materialInit(*point);
		materialInit(*uv);
		materialInit(*basicTexture);
		materialInit(*text);
		// materialInit(*backgroundBasic);
		setColor(*basicTexture, .{1.0, 1.0, 1.0, 1.0});
		setColor(*text, .{1.0, 1.0, 1.0, 1.0});
		// setColor(*backgroundBasic, DEFAULT_RENDERER_BG_COLOR);

		setTexture(*basicTexture, *FONT_TEXTURE);
	}
	// nodesSceneInitBackgroundMesh(scene);
}

NodesSceneOnBeforeTickCallback :: #type (nodesScene: *NodesScene);
NodesSceneOnNodesComputedCallback :: #type (nodesScene: *NodesScene);

#scope_file

INIT_NEXT_NODE_ID :NodeId: 0;


DEFAULT_NODES_SCENE_ON_BEFORE_TICK :NodesSceneOnBeforeTickCallback: (nodesScene: *NodesScene) {}
DEFAULT_NODES_SCENE_ON_NODES_COMPUTED :NodesSceneOnNodesComputedCallback: (nodesScene: *NodesScene) {}


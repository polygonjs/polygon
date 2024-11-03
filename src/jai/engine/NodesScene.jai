NodesScene :: struct {
	nodes: [..]*GeoNodeAny;
	graph: CoreGraph;
	worldScene: Scene;
	cookResultByNodeId:Table(CoreGraphNodeId, GeoNodeCookOutput);

	allocator: Allocator;
}

newNodesScene :: (allocator: Allocator=.{}) -> *NodesScene {
	scene: *NodesScene = alloc(size_of(NodesScene));
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
	
	return scene;
}
sceneDelete :: (scene: *NodesScene) {
	for node, i: scene.nodes {
		if node != null {
			generatedSceneNodeDelete(scene, node);
		}
	}
	array_reset(*scene.nodes);
	deinit(*scene.cookResultByNodeId);
	free(scene);
}

sceneDeleteNode :: (scene: *NodesScene, node: *$T) {
	found, index := array_find(scene.nodes, cast(*GeoNodeAny)node);
	assert(found, "node not found");

	for :params param: node {
		graphNodeDelete(param);
	}
	graphNodeDelete(node);

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


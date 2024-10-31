NodesScene :: struct {
	nodes: [..]*GeoNodeAny;
	graph: CoreGraph;
	worldScene: Scene;
	cookResultByNodeId:Table(CoreGraphNodeId, GeoNodeCookOutput);
}

newNodesScene :: () -> *NodesScene {
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
	initGraph(*scene.graph);
	
	return scene;
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


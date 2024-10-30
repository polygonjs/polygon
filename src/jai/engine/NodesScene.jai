NodesScene :: struct {
	nodes: [..]*GeoNodeAny;
	graph: CoreGraph;
}

newNodesScene :: () -> *NodesScene {
	print("newNodesScene\n");
	scene: *NodesScene = alloc(size_of(NodesScene));
	array_init(*scene.nodes);

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


// BoxGeoType :: struct {
// 	type::"box";
// }
// BoxGeoType :string: "box";
BoxGeoParams :: struct {
	size: Vector3Param = .{value=.{1,1,1}};
	scale: FloatParam = .{value=1};
}
BoxGeoNode :: struct {
	#as using geoNode: GeoNode("box", BoxGeoParams);
	geoNode.init_typed_node = init_box_geo_node;
};

nodeCompute :: (node: *BoxGeoNode) {
	print("nodeCompute START\n");
	print("nodeCompute END\n");
}

#scope_file

init_box_geo_node :: (_node: *BaseNodeAny) {
	node := cast(*BoxGeoNode)_node;
	// print("init_box_geo_node\n");
	// print("node.params.count 2: %, %\n", node.params.count, node.params);
	init_geo_node(node);
}


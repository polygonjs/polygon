// SwitchGeoType :: struct {}
SwitchGeoParams :: struct {
	input: IntegerParam;
}
SwitchGeoNode :: struct {
	#as using geoNode: GeoNode("switch", SwitchGeoParams);
	geoNode.init_typed_node = init_switch_geo_node;
};

#scope_file

init_switch_geo_node :: (_node: *BaseNodeAny) {
	node := cast(*SwitchGeoNode)_node;
	// print("init_switch_geo_node\n");
	init_geo_node(node);
}


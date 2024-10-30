// SphereGeoType :: struct {}
SphereGeoParams :: struct {
	radius: FloatParam;
}
SphereGeoNode :: struct {
	#as using geoNode: GeoNode("sphere", SphereGeoParams);
	geoNode.init_typed_node = init_sphere_geo_node;
};

#scope_file

init_sphere_geo_node :: (_node: *BaseNodeAny) {
	node := cast(*SphereGeoNode)_node;
	// print("init_sphere_geo_node\n");
	init_geo_node(node);
}


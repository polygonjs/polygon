GeoNode :: struct ($geoNodeType:string, $geoParamsType: Type) {
	#as using baseNode: BaseNode(NodeContext.GEOMETRY, geoNodeType, geoParamsType);
	// baseNode.ctx = NodeContext.GEOMETRY;
	// baseNode.init_context_node = init_geo_node;

	// p: Params;
	baseNode.onDirty = onGeoNodeDirty;
};
GeoNodeAny :: GeoNode("unknown", Any);



// geo_node_to_type_node :: (node: *GeoNodeAny) -> *Any {
// 	if node.type == {
// 		case BoxGeoNode; return cast(*BoxGeoNode)node;
// 	}
// 	return null;
// }

init_geo_node :: (node: *$N) {
	geoNode := cast(*GeoNodeAny)node;
	// print("init_geo_node geo_node\n");
}

#scope_file
onGeoNodeDirty :CoreGraphNodeOnDirtyMethod: (coreGraphNode: *CoreGraphNode) {
	node := cast(*GeoNodeAny)coreGraphNode;
	// print("init_geo_node geo_node\n");
}

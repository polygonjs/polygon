GeoNodeCookOutput :: *Object3D;
GeoNodeCookInput  :: []GeoNodeCookOutput;
GeoNodeCookMethod :: #type (node: *$T, inputs:GeoNodeCookInput) -> GeoNodeCookOutput;
GeoNode :: struct ($geoNodeT: Type, $geoParamsType: Type, $geoInitMethod:BaseTypedNodeInitMethod, $minInputs: u8=0, $maxInputs: u8=1) {
	#as using baseNode: BaseNode(geoNodeT, NodeContext.GEOMETRY, geoParamsType, geoInitMethod, minInputs, maxInputs);
	// baseNode.ctx = NodeContext.GEOMETRY;
	// baseNode.init_context_node = init_geo_node;

	// p: Params;
	// baseNode.onDirty = onGeoNodeDirty;
	
};
GeoNodeAny :: GeoNode(Any, Any, init);



// geo_node_to_type_node :: (node: *GeoNodeAny) -> *Any {
// 	if node.type == {
// 		case BoxGeoNode; return cast(*BoxGeoNode)node;
// 	}
// 	return null;
// }



#scope_file

TYPE :: GeoNodeAny;

// onGeoNodeDirty :CoreGraphNodeOnDirtyMethod: (coreGraphNode: *CoreGraphNode) {
// 	// node := cast(*GeoNodeAny)coreGraphNode;
// 	// print("init_geo_node geo_node\n");
// }

init :: (node: *$N) {
	geoNode := cast(*TYPE)node;
	// print("init_geo_node geo_node\n");
}

// cook :GeoNodeCookMethod: (node: *Any, inputs:GeoNodeCookInput)->GeoNodeCookOutput {
// 	mesh := newObject3D(Mesh);
// 	assert(false, "geo cook should not be used");
// 	return mesh;
// }

// nodeCompute :NodeComputeMethod: (node: *Any, depth:u8=0)->GeoNodeCookOutput {
// 	return nodeCompute(cast(*TYPE)node, depth);
// }
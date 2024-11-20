

// generatedNodeCompute :: (inputNode: *$T, depth:u8=0)->GeoNodeCookOutput {
// 	#insert GENERATED_CODE_NODE_COMPUTE;
// 	assert(false, tprint("generatedNodeCompute: node type '%' is not implemented", inputNode.type));
// 	return newObject3D(Mesh);
// }

generatedSceneNodeDelete :: (scene: *NodesScene, node: *$T, $removeFromGraph:bool = true) {
	#insert GENERATED_CODE_SCENE_NODE_DELETE;
	assert(false, tprint("generatedSceneNodeDelete: node type '%' is not implemented", node.type));
}

registerNodes :: () {

	registerBoxGeoNode();
	registerIcosahedronGeoNode();
	registerMergeGeoNode();
	registerNullGeoNode();
	registerOutputGeoNode();
	
}
registerNodesAndGenerateCode :: () -> sceneNodeDelete:string {

	registerNodes();

	// nodeCompute := generateNodeComputes();
	sceneNodeDelete := generateSceneNodeDelete();

	// return 	nodeCompute,
	return		sceneNodeDelete;
}

getNodeTypeId :: (T:Type)->u64 {
	found, index := array_find(NODE_TYPES, T);
	assert(found, tprint("node type not found: '%'", T));
	// assert(found, "node type not found");
	return xx index;
}

nodeRegister :: (
	ctx: NodeContext,
	$T:Type,
	minInputsCount:u8,
	maxInputsCount:u8,
	cook:GeoNodeCookMethod,
	onDirty:CoreGraphNodeOnDirtyMethod=null
	) {
	
	array_add(*NODE_CONTEXTS, ctx);
	array_add(*NODE_TYPES, T);
	array_add(*NODE_INPUTS_COUNT, .{min=minInputsCount, max=maxInputsCount});
	printRed("REGISTERS\n");
	print(">>> registered node type '%' minInputsCount: % maxInputsCount: %, cook: %\n", T, minInputsCount, maxInputsCount, cook);

	// cookMethod:Any;
	// cookMethod = cook;
	array_add(*COOK_METHODS, cook);
	array_add(*ON_DIRTY_METHODS, onDirty);

	// node_info :*Type_Info= type_info(T);
	// print("info.type == %\n", node_info.type);
	// info_struct := cast(*Type_Info_Struct) node_info;
	// print("info_struct.polymorph_source_struct == %\n", info_struct.polymorph_source_struct);
	// // node_tis := cast(*Type_Info_Struct)node_info;
	// // minInputsCountField := get_field(node_tis, "minInputsCount");
	// // print("minInputsCountField: %\n", <<minInputsCountField);
	// // print("type: %\n", <<minInputsCountField.type.type);
	// // print("constant: %\n", minInputsCountField.offset_into_constant_storage);
	// // print("value: %\n", node_tis.constant_storage[minInputsCountField.offset_into_constant_storage]);
	// builder: String_Builder;
	// print_type_to_builder(*builder, node_info);
	// content := builder_to_string(*builder);
	// print("content: %\n", content);

	// any: Any;
	// any.type = type_info(u8);
	// any.value_pointer = node_tis.constant_storage.data + minInputsCountField.offset_into_constant_storage;
	// print("%\n", any);
}
nodeRegisterGeo :: (
	$T:Type,
	minInputsCount:u8,
	maxInputsCount:u8,
	cook:GeoNodeCookMethod,
	onDirty:CoreGraphNodeOnDirtyMethod=null
	){
		nodeRegister(NodeContext.GEOMETRY, T, minInputsCount, maxInputsCount, cook, onDirty);
	}

NODE_CONTEXTS :[..]NodeContext;
NODE_TYPES :[..]Type;
NODE_INPUTS_COUNT :[..]NodeInputsCount;
COOK_METHODS :[..]GeoNodeCookMethod;
ON_DIRTY_METHODS :[..]CoreGraphNodeOnDirtyMethod;

NodeInputsCount :: struct {
	min: u8;
	max: u8;
}

#scope_file


// GENERATED_CODE_NODE_COMPUTE,
GENERATED_CODE_SCENE_NODE_DELETE :: #run registerNodesAndGenerateCode();







// generateNodeComputes :: ()->string {
// 	builder: String_Builder;
// 	print_to_builder(*builder, "if inputNode.type == {\n");
// 	for nodeType: NODE_TYPES {
// 		print_to_builder(*builder, tprint("\tcase %; return nodeCompute(cast(*%) inputNode, depth);\n", nodeType, nodeType));
// 	}
// 	print_to_builder(*builder, "}");

// 	result := builder_to_string(*builder);
// 	reset(*builder);
// 	return result;
// }
generateSceneNodeDelete :: ()->string {
	builder: String_Builder;
	print_to_builder(*builder, "if node.type == {\n");
	for nodeType: NODE_TYPES {
		print_to_builder(*builder, tprint("\tcase %; sceneDeleteNode(scene, cast(*%) node, removeFromGraph);return;\n", nodeType, nodeType));
	}
	print_to_builder(*builder, "}");

	result := builder_to_string(*builder);
	reset(*builder);
	return result;
}


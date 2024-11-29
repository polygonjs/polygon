

generatedNodeCompute :: (scene: *NodesScene, inputNode: *$T, depth:u8=0)->GeoNodeCookOutput {
	#insert GENERATED_CODE_NODE_COMPUTE;
	assert(false, tprint("generatedNodeCompute: node type '%' is not implemented", inputNode.type));
	return newObject3D(scene.worldScene, Mesh);
}
generatedSceneNodeDelete :: (scene: *NodesScene, node: *$T, $removeFromGraph:bool = true) {
	#insert GENERATED_CODE_SCENE_NODE_DELETE;
	assert(false, tprint("generatedSceneNodeDelete: node type '%' is not implemented", node.type));
}
generatedNodeParamsRenderUI :: (node: *$T) {
	#insert GENERATED_CODE_PARAMS_RENDER_UI;
	assert(false, tprint("generatedNodeParamsRenderUI: node type '%' is not implemented", node.type));
}

registerNodes :: () {

	array_reset(*TMP_METADATAS);

	registerAddGeoNode();
	registerBoxGeoNode();
	registerIcosahedronGeoNode();
	registerLineGeoNode();
	registerMergeGeoNode();
	registerNullGeoNode();
	registerOutputGeoNode();
	
}
nodesMetaDatasCount :: ()->u64{
	registerNodes();
	return xx TMP_METADATAS.count;
}
nodesMetaDatas :: ()->[NODE_METADATAS_COUNT]NodeMetaData {
	registerNodes();

	list:[NODE_METADATAS_COUNT]NodeMetaData;

	for nodeMetaData, i: TMP_METADATAS {
		list[i] = nodeMetaData;
	}
	return list;
}

registerNodesAndGenerateCode :: () -> (
	nodeCompute:string,
	sceneNodeDelete:string,
	paramsRenderUI:string
) {

	registerNodes();

	nodeCompute := generateNodeComputes();
	sceneNodeDelete := generateSceneNodeDelete();
	paramsRenderUI := generateNodeParamsRenderUI();

	return 	nodeCompute,
		sceneNodeDelete,
	paramsRenderUI;
}

getNodeTypeId :: (T:Type)->u64 {
	index := -1;
	found := false;
	for nodeMetaData, i: NODE_METADATAS {
		if nodeMetaData.type == T {
			found = true;
			index = i;
			break;
		}
	}
	assert(found, tprint("node type not found: '%'", T));
	// assert(found, "node type not found");
	return xx index;
}

nodeRegister :: (
	ctx: NodeContext,
	$T:Type,
	minInputsCount:u8,
	maxInputsCount:u8
	// cook:GeoNodeCookMethod,
	// onDirty:CoreGraphNodeOnDirtyMethod=null
	) {
	array_add(*TMP_METADATAS, .{
		ctx = ctx,
		type = T,
		inputsCount = .{min=minInputsCount, max=maxInputsCount}
	});
	// array_add(*NODE_CONTEXTS, ctx);
	// array_add(*NODE_TYPES, T);
	// array_add(*NODE_INPUTS_COUNT, .{min=minInputsCount, max=maxInputsCount});
	// printRed("REGISTERS\n");
	// print(">>> registered node type '%' minInputsCount: % maxInputsCount: %\n", T, minInputsCount, maxInputsCount);

	// cookMethod:Any;
	// cookMethod = cook;
	// array_add(*COOK_METHODS, cook);
	// array_add(*ON_DIRTY_METHODS, onDirty);

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
	maxInputsCount:u8
	// cook:GeoNodeCookMethod,
	// onDirty:CoreGraphNodeOnDirtyMethod=null
	){
		nodeRegister(NodeContext.GEOMETRY, T, minInputsCount, maxInputsCount);
	}

NodeMetaData :: struct {
	ctx: NodeContext;
	type: Type;
	inputsCount: NodeInputsCount;
}

#no_reset NODE_METADATAS_COUNT :u64: #run nodesMetaDatasCount();
#no_reset NODE_METADATAS :[NODE_METADATAS_COUNT]NodeMetaData: #run nodesMetaDatas();
// COOK_METHODS :[..]GeoNodeCookMethod;
// ON_DIRTY_METHODS :[..]CoreGraphNodeOnDirtyMethod;

NodeInputsCount :: struct {
	min: u8;
	max: u8;
}

#scope_file

TMP_METADATAS: [..]NodeMetaData;


GENERATED_CODE_NODE_COMPUTE,
GENERATED_CODE_SCENE_NODE_DELETE,
GENERATED_CODE_PARAMS_RENDER_UI :: #run registerNodesAndGenerateCode();







generateNodeComputes :: ()->string {
	builder: String_Builder;
	print_to_builder(*builder, "if inputNode.type == {\n");
	for nodeMetaData: NODE_METADATAS {
		nodeType := nodeMetaData.type;
		print_to_builder(*builder, tprint("\tcase %; return nodeCompute(scene, cast(*%) inputNode, depth);\n", nodeType, nodeType));
	}
	print_to_builder(*builder, "}");

	result := builder_to_string(*builder);
	reset(*builder);
	return result;
}
generateSceneNodeDelete :: ()->string {
	builder: String_Builder;
	print_to_builder(*builder, "if node.type == {\n");
	for nodeMetaData: NODE_METADATAS {
		nodeType := nodeMetaData.type;
		print_to_builder(*builder, tprint("\tcase %; _sceneDeleteNode_(scene, cast(*%) node, removeFromGraph);return;\n", nodeType, nodeType));
	}
	print_to_builder(*builder, "}");

	result := builder_to_string(*builder);
	reset(*builder);
	return result;
}
generateNodeParamsRenderUI :: ()->string {
	builder: String_Builder;
	print_to_builder(*builder, "if node.type == {\n");
	for nodeMetaData: NODE_METADATAS {
		nodeType := nodeMetaData.type;
		print_to_builder(*builder, tprint("\tcase %; for :params param: cast(*%)node { generatedParamRenderUI(param, paramName); };return;\n", nodeType, nodeType));
	}
	print_to_builder(*builder, "}");

	result := builder_to_string(*builder);
	reset(*builder);
	return result;
}


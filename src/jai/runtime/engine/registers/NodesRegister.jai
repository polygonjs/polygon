

generatedNodeComputeInputs :: (scene: *NodesScene, node: *BaseNodeAny, target:*[..]NodeId) {
	#insert GENERATED_CODE_NODE_COMPUTE_INPUTS;
	assert(false, tprint("generatedNodeComputeInputs: node type '%' is not implemented", node.type));
}
generatedNodePrepareInputCookResults :: (scene: *NodesScene, node: *BaseNodeAny) {
	#insert GENERATED_CODE_NODE_PREPARE_INPUT_COOK_RESULTS;
	assert(false, tprint("generatedNodePrepareInputCookResults: node type '%' is not implemented", node.type));
}
generatedNodeDisposePreviousCookResults :: (scene: *NodesScene, node: *BaseNodeAny) {
	#insert GENERATED_CODE_NODE_DISPOSE_PREVIOUS_COOK_RESULTS;
	assert(false, tprint("generatedNodeDisposePreviousCookResults: node type '%' is not implemented", node.type));
}
generatedNodeCook :: (node: *BaseNodeAny, inputResults:GeoNodeCookInput) {
	#insert GENERATED_CODE_COOK;
	assert(false, tprint("generatedNodeCook: node type '%' is not implemented", node.type));
}
generatedSceneNodeDelete :: (scene: *NodesScene, node: *BaseNodeAny, $removeFromGraph:bool = true) {
	#insert GENERATED_CODE_SCENE_NODE_DELETE;
	assert(false, tprint("generatedSceneNodeDelete: node type '%' is not implemented", node.type));
}
generatedNodeCtx :: (node: *BaseNodeAny)->NodeContext {
	#insert GENERATED_CODE_NODE_CTX;
	assert(false, tprint("generatedNodeDelete: node type '%' is not implemented", node.type));
	return .ANY;
}
#if USE_EDITOR {
	generatedNodeParamsRenderUI :: (node: *BaseNodeAny) {
		#insert GENERATED_CODE_PARAMS_RENDER_UI;
		assert(false, tprint("generatedNodeParamsRenderUI: node type '%' is not implemented", node.type));
	}
}
generatedParamsInit :: (node: *BaseNodeAny) #expand {
	#insert GENERATED_CODE_PARAMS_INIT;
	assert(false, tprint("generatedParamsInit: node.nodeTypeId '%' is not implemented", node.nodeTypeId));
}
generatedParamsReset :: (node: *BaseNodeAny) #expand {
	#insert GENERATED_CODE_PARAMS_RESET;
	assert(false, tprint("generatedParamsReset: node.nodeTypeId '%' is not implemented", node.nodeTypeId));
}
// no #expand, as it is otherwise repeated many times in .added_strings, since it is called from _sceneDeleteNode_
generatedParamsGraphNodeDelete :: (node: *BaseNodeAny) {
	#insert GENERATED_CODE_PARAMS_GRAPH_NODE_DELETE;
	assert(false, tprint("generatedParamsGraphNodeDelete: node.nodeTypeId '%' is not implemented", node.nodeTypeId));
}

registerNodes :: (label:string) #compile_time {
	array_reset_keeping_memory(*TMP_METADATAS);

	registerAddGeoNode();
	registerBoxGeoNode();
	registerCopyGeoNode();
	registerFileSTLGeoNode();
	registerIcosahedronGeoNode();
	registerLineGeoNode();
	registerMergeGeoNode();
	registerNoiseGeoNode();
	registerNullGeoNode();
	registerPlaneGeoNode();
	registerOutputGeoNode();
	registerSwitchGeoNode();
	registerTextGeoNode();
	registerTransformGeoNode();

}
nodesMetaDatasCount :: ()->u64 #compile_time {
	registerNodes("nodesMetaDatasCount");
	return xx TMP_METADATAS.count;
}
nodesMetaDatas :: ()->[NODE_METADATAS_COUNT]NodeMetaData #compile_time {
	registerNodes("nodesMetaDatas");

	list:[NODE_METADATAS_COUNT]NodeMetaData;

	for nodeMetaData, i: TMP_METADATAS {
		list[i] = nodeMetaData;
	}
	return list;
}
nodesMaxInputsCount :: () -> NodeInputsCount #compile_time {
	maxInputsCount :NodeInputsCount= 0;
	for nodeMetaData, i: NODE_METADATAS {
		if nodeMetaData.inputsCount.max > maxInputsCount {
			maxInputsCount = nodeMetaData.inputsCount.max;
		}
	}
	return maxInputsCount;
}
nodeMinInputsCount :: (node: *BaseNodeAny)->NodeInputsCount #expand {
	return NODE_METADATAS[node.nodeTypeId].inputsCount.min;
}
nodeMaxInputsCount :: (node: *BaseNodeAny)->NodeInputsCount #expand {
	return NODE_METADATAS[node.nodeTypeId].inputsCount.max;
}
nodeType :: (node: *BaseNodeAny)->Type #expand {
	return NODE_METADATAS[node.nodeTypeId].type;
}
getNodeTypeId :: (T:Type)->(found:bool, id: NodeTypeId) {
	found := false;
	for nodeMetaData, i: NODE_METADATAS {
		if nodeMetaData.type == T {
			return true, xx i;
		}
	}
	assert(found, tprint("node type not found: '%'", T));
	// assert(found, "node type not found");
	return false, 0;
}

registerNodesAndGenerateCode :: () -> (
	nodeComputeInputs:string,
	nodePrepareInputCookResults:string,
	nodeDisposePreviousCookResults:string,
	nodeCook:string,
	sceneNodeDelete:string,
	nodeCtx:string,
	paramsRenderUI:string,
	paramsInit:string,
	paramsReset:string,
	paramsGraphNodeDelete:string
) #compile_time {

	registerNodes("registerNodesAndGenerateCode");

	nodeComputeInputs := generateNodeComputeInputs();
	nodePrepareInputCookResults := generateNodePrepareInputCookResults();
	nodeDisposePreviousCookResults := generateNodeDisposePreviousCookResults();
	nodeCook := generateNodeCook();
	sceneNodeDelete := generateSceneNodeDelete();
	nodeCtx := generateNodeCtx();
	paramsRenderUI := generateNodeParamsRenderUI();
	paramsInit := generateParamsInit();
	paramsReset := generateParamsReset();
	paramsGraphNodeDelete := generateParamsGraphNodeDelete();
	return
		nodeComputeInputs,
		nodePrepareInputCookResults,
		nodeDisposePreviousCookResults,
		nodeCook,
		sceneNodeDelete,
		nodeCtx,
		paramsRenderUI,
		paramsInit,
		paramsReset,
		paramsGraphNodeDelete;
}



nodeRegister :: (
	// ctx: NodeContext,
	$T:Type
	// minInputsCount:u8,
	// maxInputsCount:u8
	) #compile_time {


	// paramMetaDatas: [..]NodeParamMetaData;
	// {
	// 	node_info := type_info(T);
	// 	print("node_info: %\n", <<node_info);
	// 	node_tis := cast(*Type_Info_Struct)node_info;
	// 	paramsField := get_field(node_tis, "p");
	// 	print("paramsField: %\n", <<(<<paramsField).type);
	// 	params_tis := cast(*Type_Info_Struct)paramsField;

	// 	print("params_tis.members: % -> %\n", T, params_tis.members);

	// 	for member, i: params_tis.members {
	// 		paramField := get_field(params_tis, member.name);
	// 		member_tis := cast(*Type_Info_Struct)paramField.type;
	// 		offset := paramsField.offset_in_bytes + paramField.offset_in_bytes;
	// 		paramMetaData:NodeParamMetaData = .{
	// 			type = paramField.name,
	// 			name = member.name,
	// 			offset = xx offset
	// 		};
	// 		array_add(*paramMetaDatas, paramMetaData);
	// 	}
	// }
	node: T;
	params := paramsMetaDataFixed(*node);

	nodeMetaData: NodeMetaData = .{
		// ctx = ctx,
		type = T,
		inputsCount = .{min=node.minInputsCount, max=node.maxInputsCount},
		params = params
	};

	array_add(*TMP_METADATAS, nodeMetaData);

}
nodeRegisterGeo :: nodeRegister;

NodeParamMetaData::struct {
	type: string;
	name: string;
	offset:u64;
}
FixedParamMetaData :: struct {
	count: u64;
	metaDatas: [256]NodeParamMetaData;
}

NodeMetaData :: struct {
	// ctx: NodeContext;
	type: Type;
	inputsCount: NodeInputsCountBounds;
	params: FixedParamMetaData;
}

#no_reset NODES_MAX_INPUTS_COUNT :NodeInputsCount: #run nodesMaxInputsCount();

#scope_file

TMP_METADATAS: [..]NodeMetaData;

#no_reset NODE_METADATAS_COUNT :u64: #run nodesMetaDatasCount();
#no_reset NODE_METADATAS :[NODE_METADATAS_COUNT]NodeMetaData: #run nodesMetaDatas();


GENERATED_CODE_NODE_COMPUTE_INPUTS,
GENERATED_CODE_NODE_PREPARE_INPUT_COOK_RESULTS,
GENERATED_CODE_NODE_DISPOSE_PREVIOUS_COOK_RESULTS,
GENERATED_CODE_COOK,
GENERATED_CODE_SCENE_NODE_DELETE,
GENERATED_CODE_NODE_CTX,
GENERATED_CODE_PARAMS_RENDER_UI,
GENERATED_CODE_PARAMS_INIT,
GENERATED_CODE_PARAMS_RESET,
GENERATED_CODE_PARAMS_GRAPH_NODE_DELETE :: #run registerNodesAndGenerateCode();



generateNodeComputeInputs :: ()->string #compile_time {
	builder: String_Builder;
	print_to_builder(*builder, "if node.type == {\n");
	for nodeMetaData: NODE_METADATAS {
		nodeType := nodeMetaData.type;
		print_to_builder(*builder, tprint("\tcase %; nodeComputeInputs(scene, cast(*%) node, target); return;\n", nodeType, nodeType));
	}
	print_to_builder(*builder, "}");
	result := builder_to_string(*builder);
	// reset(*builder);
	return result;
	// return _generateSceneNode("nodeComputeInputs");
}
generateNodePrepareInputCookResults :: ()->string #compile_time {
	return _generateSceneNode("nodePrepareInputCookResults");
}
generateNodeDisposePreviousCookResults :: ()->string #compile_time {
	return _generateSceneNode("nodeDisposePreviousCookResults");
}
generateNodeCook :: ()->string #compile_time {
	builder: String_Builder;
	print_to_builder(*builder, "if node.type == {\n");
	for nodeMetaData: NODE_METADATAS {
		nodeType := nodeMetaData.type;
		print_to_builder(*builder, tprint("\tcase %; cook(cast(*%) node, inputResults); return;\n", nodeType, nodeType));
	}
	print_to_builder(*builder, "}");

	result := builder_to_string(*builder);
	// reset(*builder);
	return result;
}
generateSceneNodeDelete :: ()->string #compile_time {
	builder: String_Builder;
	print_to_builder(*builder, "if node.type == {\n");
	for nodeMetaData: NODE_METADATAS {
		nodeType := nodeMetaData.type;
		print_to_builder(*builder, tprint("\tcase %; _sceneDeleteNode_(scene, cast(*%) node, removeFromGraph);return;\n", nodeType, nodeType));
	}
	print_to_builder(*builder, "}");

	result := builder_to_string(*builder);
	// reset(*builder);
	return result;
}
generateNodeCtx :: ()->string #compile_time {
	builder: String_Builder;
	print_to_builder(*builder, "if node.type == {\n");
	for nodeMetaData: NODE_METADATAS {
		nodeType := nodeMetaData.type;
		print_to_builder(*builder, tprint("\tcase %; return (cast(*%) node).ctx;\n", nodeType, nodeType));
	}
	print_to_builder(*builder, "}");

	result := builder_to_string(*builder);
	// reset(*builder);
	return result;
}
// generateNodeParamsRenderUI :: ()->string {
// 	builder: String_Builder;
// 	print_to_builder(*builder, "if node.type == {\n");
// 	for nodeMetaData: NODE_METADATAS {
// 		nodeType := nodeMetaData.type;
// 		// print_to_builder(*builder, tprint("\tcase %; iterateParams(cast(*%)node, #code { generatedParamRenderUI(param, paramName); });return;\n", nodeType, nodeType));
// 		print_to_builder(*builder, tprint("\tcase %; return;\n", nodeType, nodeType));
// 	}
// 	print_to_builder(*builder, "}");

// 	result := builder_to_string(*builder);
// 	reset(*builder);
// 	return result;
// }

_generateSceneNode :: (functionName:string)->string #compile_time {
	builder: String_Builder;
	print_to_builder(*builder, "if node.type == {\n");
	for nodeMetaData: NODE_METADATAS {
		nodeType := nodeMetaData.type;
		print_to_builder(*builder, tprint("\tcase %; %(scene, cast(*%) node); return;\n", nodeType, functionName, nodeType));
	}
	print_to_builder(*builder, "}");
	result := builder_to_string(*builder);
	// reset(*builder);
	return result;
}
// _generateSceneNodeWithReturn :: (functionName:string)->string {
// 	builder: String_Builder;
// 	print_to_builder(*builder, "if node.type == {\n");
// 	for nodeMetaData: NODE_METADATAS {
// 		nodeType := nodeMetaData.type;
// 		print_to_builder(*builder, tprint("\tcase %; return %(scene, cast(*%) node);\n", nodeType, functionName, nodeType));
// 	}
// 	print_to_builder(*builder, "}");
// 	result := builder_to_string(*builder);
// 	reset(*builder);
// 	return result;
// }


generateNodeParamsRenderUI :: ()->string #compile_time {
	return _forParams((param: NodeParamMetaData, builder: *String_Builder){
		print_to_builder(builder, "		paramRenderUI(cast(*%)((cast(*u8)node) + %), \"%\"); // %\n", param.type, param.offset, param.name, param.name);
	});
}

generateParamsInit :: ()->string #compile_time {
	return _forParams((param: NodeParamMetaData, builder: *String_Builder){
		print_to_builder(builder, "		paramInit(cast(*%)((cast(*u8)node) + %), node); // %\n", param.type, param.offset, param.name);
	});
}
generateParamsReset :: ()->string #compile_time {
	return _forParams((param: NodeParamMetaData, builder: *String_Builder){
		print_to_builder(builder, "		paramsResetValue(cast(*%)((cast(*u8)node) + %)); // %\n", param.type, param.offset, param.name);
	});
}
generateParamsGraphNodeDelete :: ()->string #compile_time {
	return _forParams((param: NodeParamMetaData, builder: *String_Builder){
		print_to_builder(builder, "		graphNodeDelete(cast(*%)((cast(*u8)node) + %)); // %\n", param.type, param.offset, param.name);
	});
}

ForParamsCallback :: #type (metadata: NodeParamMetaData, builder: *String_Builder);
_forParams :: (callback:ForParamsCallback)->string #compile_time {
	builder: String_Builder;
	print_to_builder(*builder, "if node.nodeTypeId == {\n");
	for nodeMetaData, nodeTypeId: NODE_METADATAS {

		params := nodeMetaData.params;
		print_to_builder(*builder, tprint("\tcase %; { // % (% %)\n", nodeTypeId, nodeMetaData.type, params.count, ifx params.count==1 then "param" else "params"));

		if params.count > 0 {
			for 0..(params.count-1) {
				param := params.metaDatas[it];
				callback(param, *builder);
				// print_to_builder(*builder, "		paramInit(cast(*%)((cast(*u8)node) + %), node); // %\n", param.type, param.offset, param.name);
			}
		}
		print_to_builder(*builder, "		return;\n");
		print_to_builder(*builder, "	}\n");

	}
	print_to_builder(*builder, "}");

	result := builder_to_string(*builder);
	// reset(*builder);
	return result;
}
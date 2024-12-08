

generatedNodeComputeInputs :: (scene: *NodesScene, node: *$T, target:*[..]NodeId) {
	#insert GENERATED_CODE_NODE_COMPUTE_INPUTS;
	assert(false, tprint("generatedNodeComputeInputs: node type '%' is not implemented", node.type));
}
generatedNodePrepareInputCookResults :: (scene: *NodesScene, node: *$T) {
	#insert GENERATED_CODE_NODE_PREPARE_INPUT_COOK_RESULTS;
	assert(false, tprint("generatedNodePrepareInputCookResults: node type '%' is not implemented", node.type));
}
generatedNodeDisposePreviousCookResults :: (scene: *NodesScene, node: *$T) {
	#insert GENERATED_CODE_NODE_DISPOSE_PREVIOUS_COOK_RESULTS;
	assert(false, tprint("generatedNodeDisposePreviousCookResults: node type '%' is not implemented", node.type));
}
generatedNodeCook :: (node: *$T, inputResults:GeoNodeCookInput) {
	#insert GENERATED_CODE_COOK;
	assert(false, tprint("generatedNodeCook: node type '%' is not implemented", node.type));
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
	registerCopyGeoNode();
	registerFileSTLGeoNode();
	registerIcosahedronGeoNode();
	registerLineGeoNode();
	registerMergeGeoNode();
	registerNoiseGeoNode();
	registerNullGeoNode();
	registerOutputGeoNode();
	registerSwitchGeoNode();
	registerTransformGeoNode();

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
	nodeComputeInputs:string,
	nodePrepareInputCookResults:string,
	nodeDisposePreviousCookResults:string,
	nodeCook:string,
	sceneNodeDelete:string,
	paramsRenderUI:string
) {

	registerNodes();

	nodeComputeInputs := generateNodeComputeInputs();
	nodePrepareInputCookResults := generateNodePrepareInputCookResults();
	nodeDisposePreviousCookResults := generateNodeDisposePreviousCookResults();
	nodeCook := generateNodeCook();
	sceneNodeDelete := generateSceneNodeDelete();
	paramsRenderUI := generateNodeParamsRenderUI();

	return 	nodeComputeInputs,
	nodePrepareInputCookResults,
	nodeDisposePreviousCookResults,
	nodeCook,
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
	) {
	array_add(*TMP_METADATAS, .{
		ctx = ctx,
		type = T,
		inputsCount = .{min=minInputsCount, max=maxInputsCount}
	});

}
nodeRegisterGeo :: (
	$T:Type,
	minInputsCount:u8,
	maxInputsCount:u8
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

GENERATED_CODE_NODE_COMPUTE_INPUTS,
GENERATED_CODE_NODE_PREPARE_INPUT_COOK_RESULTS,
GENERATED_CODE_NODE_DISPOSE_PREVIOUS_COOK_RESULTS,
GENERATED_CODE_COOK,
GENERATED_CODE_SCENE_NODE_DELETE,
GENERATED_CODE_PARAMS_RENDER_UI :: #run registerNodesAndGenerateCode();



generateNodeComputeInputs :: ()->string {
	builder: String_Builder;
	print_to_builder(*builder, "if node.type == {\n");
	for nodeMetaData: NODE_METADATAS {
		nodeType := nodeMetaData.type;
		print_to_builder(*builder, tprint("\tcase %; nodeComputeInputs(scene, cast(*%) node, target); return;\n", nodeType, nodeType));
	}
	print_to_builder(*builder, "}");
	result := builder_to_string(*builder);
	reset(*builder);
	return result;
	// return _generateSceneNode("nodeComputeInputs");
}
generateNodePrepareInputCookResults :: ()->string {
	// builder: String_Builder;
	// print_to_builder(*builder, "if node.type == {\n");
	// for nodeMetaData: NODE_METADATAS {
	// 	nodeType := nodeMetaData.type;
	// 	print_to_builder(*builder, tprint("\tcase %; nodePrepareInputCookResults(scene, cast(*%) node); return;\n", nodeType, nodeType));
	// }
	// print_to_builder(*builder, "}");
	// result := builder_to_string(*builder);
	// reset(*builder);
	// return result;
	return _generateSceneNode("nodePrepareInputCookResults");
}
generateNodeDisposePreviousCookResults :: ()->string {
	// builder: String_Builder;
	// print_to_builder(*builder, "if node.type == {\n");
	// for nodeMetaData: NODE_METADATAS {
	// 	nodeType := nodeMetaData.type;
	// 	print_to_builder(*builder, tprint("\tcase %; nodeDisposePreviousCookResults(scene, cast(*%) node); return;\n", nodeType, nodeType));
	// }
	// print_to_builder(*builder, "}");
	// result := builder_to_string(*builder);
	// reset(*builder);
	// return result;
	return _generateSceneNode("nodeDisposePreviousCookResults");
}
generateNodeCook :: ()->string {
	builder: String_Builder;
	print_to_builder(*builder, "if node.type == {\n");
	for nodeMetaData: NODE_METADATAS {
		nodeType := nodeMetaData.type;
		print_to_builder(*builder, tprint("\tcase %; cook(cast(*%) node, inputResults); return;\n", nodeType, nodeType));
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

_generateSceneNode :: (functionName:string)->string {
	builder: String_Builder;
	print_to_builder(*builder, "if node.type == {\n");
	for nodeMetaData: NODE_METADATAS {
		nodeType := nodeMetaData.type;
		print_to_builder(*builder, tprint("\tcase %; %(scene, cast(*%) node); return;\n", nodeType, functionName, nodeType));
	}
	print_to_builder(*builder, "}");
	result := builder_to_string(*builder);
	reset(*builder);
	return result;
}
// BaseContextNodeInitMethod :: #type (node: *BaseNodeAny);
BaseTypedNodeInitMethod :: #type (node: *$T);
NodeCookMethod :: #type (node: *$T, inputResults:GeoNodeCookInput) -> GeoNodeCookOutput;
NodeComputeMethod :: #type (node: *$T, depth:u8=0) -> GeoNodeCookOutput;

NodeContext :: enum u8 {
	ANY :: 0;
	GEOMETRY :: 1;
	MATERIAL :: 2;
};

BaseNode :: struct ($nodeCtx: NodeContext, $ParamsType: Type, $initMethod:BaseTypedNodeInitMethod, $baseMinInputs: u8=0, $baseMaxInputs: u8=1) {
	#as using coreGraphNode: CoreGraphNode;
	ctx: NodeContext=nodeCtx;
	// type: string=nodeType;
	// name: string;
	// init_context_node :BaseContextNodeInitMethod;//= dummy_init_context_node;
	initTypedNode :BaseTypedNodeInitMethod:initMethod;
	minInputsCount: u8= baseMinInputs;
	// maxInputsCount: u8= baseMaxInputs;
	// cook:GeoNodeCookMethod:cookMethod;
	// nodeCompute:NodeComputeMethod:nodeComputeMethod;

	params: [..]*BaseParamAny;
	// let's have the structs whose size can change at the end of the struct,
	// to make it easier to cast and not have read/write issues.
	p:ParamsType;
	inputs: [baseMaxInputs]*BaseNode(nodeCtx, Any, initTypedNodeDummy);
}
BaseNodeAny :: BaseNode(NodeContext.ANY, Any, initTypedNodeDummy);

newNode :: (scene: *NodesScene, $T: Type) -> *T {
	// node: *T = alloc(size_of(T));
	node: *T = newCoreGraphNode(*scene.graph, T);
	// node.type = T;

	node.scene = scene;
	array_add(*scene.nodes, xx node);

	tmp :T;
	// node.type = T;//tmp.type;
	node.ctx = tmp.ctx;
	node.p = tmp.p;
	node.onDirty = tmp.onDirty;
	// node.cook = tmp.cook;
	// node.nodeCompute = tmp.nodeCompute;
	// node.name = tprint("%-name1",T);
	array_init(*node.params);
	for nodeInput, i: node.inputs {
		node.inputs[i] = null;
	}
	// array_init(*node.inputs);
	// node.init_context_node = tmp.init_context_node;
	// node.initTypedNode = tmp.initTypedNode;

	initBaseNode(node);
	// node.init_context_node(xx node);
	// if node.ctx == {
	// 	case NodeContext.GEOMETRY; init_geo_node(node);
	// }

	node.initTypedNode(xx node);
	// print("newNode % % % %\n", node.type, node.inputs, node, <<node);
	// print("cook: % %\n", node.type, node.cook);
	// print("nodeCompute: % %\n", node.type, node.nodeCompute);

	return node;
}



setInput :: (node: *$N0, inputIndex:u8=0, inputNode: *$N1, outputIndex:u8=0)
// #modify {
// 	ti0 := cast(*Type_Info) N0;
// 	tis0 := cast(*Type_Info_Struct)ti0;
// 	ctx0 := get_field(tis0, "ctx");
// 	print("ctx0: %\n", <<ctx0);
// 	print("node: %\n", node);
// 	// params_info := type_info(type_of(node.ctx0));
// 	return true;
// }
{
	// #assert(N0.ctx == N1.ctx);
	assert(node.ctx == inputNode.ctx, "nodes have different contexts");
	node.inputs[inputIndex] = xx inputNode;
	// print("setInput % % %\n", node.type, node.inputs, inputNode.inputs);
	graphConnect(*node.scene.graph, inputNode, node);
	setDirty(node);
}
setInput :: (node: *$N0, inputNode: *$N1) {
	setInput(node, 0, inputNode, 0);
}


nodeCompute :: (node: *$T, depth:u8=0) -> GeoNodeCookOutput {
	assert(node != null, "nodeCompute: node name is null");
	// print("% 2.nodeCompute %\n", indent(depth), <<node);
	// sceneDebug(node.scene, tprint("%nodeCompute %", indent(depth), node.name));
	if node.dirty == false {
		result, found := table_find(*node.scene.cookResultByNodeId, node.id);
		if found {
			return result;
		}
	}

	inputResults:GeoNodeCookInput=.[];
	// using node;
	array_resize(*inputResults, node.inputs.count);
	// print("%inputResults PRE: %\n", indent(depth), inputResults);

	for inputNode, i: node.inputs {
		// print("%nodeCompute %input: %=%\n", indent(depth), node.name, i, inputNode);
		if inputNode != null {
			// print("%not in cache, computing\n", indent(depth));
			inputResult:GeoNodeCookOutput;
			if inputNode.type == {
				case BoxGeoNode; inputResult = nodeCompute(cast(*BoxGeoNode) inputNode, depth+1);
				case OutputGeoNode; inputResult = nodeCompute(cast(*OutputGeoNode) inputNode, depth+1);
			}
			// print("%inputResult: %\n", indent(depth), inputResult);
			// print("%set % % %\n", indent(depth), i, inputResults, inputResult);
			inputResults[i] = inputResult;
		}
	}
	
	// print("%inputResults POST: %\n", indent(depth), inputResults);
	result := cook(node, inputResults);
	node.dirty = false;
	// TODO: dispose previous result
	table_set(*node.scene.cookResultByNodeId, node.id, result);
	return result;
}

// nodeCompute :: (node: *GeoNodeAny) -> GeoNodeCookOutput {
// 	if node.type == {
// 		case "box"; return nodeCompute(cast(*BoxGeoNode)node);
// 		case "output"; return nodeCompute(cast(*OutputGeoNode)node);
// 		// case SphereGeoNode; return cook(cast(*SphereGeoNode)node, inputResults);
// 	}
// 	assert(false, tprint("nodeCompute: node type % is not implemented", node.type));
// 	return newObject3D(Mesh);
// }
// cook :: (node: *GeoNodeAny, inputResults:GeoNodeCookInput) -> GeoNodeCookOutput {
// 	if node.type == {
// 		case "box"; return cook(cast(*BoxGeoNode)node, inputResults);
// 		case "output"; return cook(cast(*OutputGeoNode)node, inputResults);
// 		// case SphereGeoNode; return cook(cast(*SphereGeoNode)node, inputResults);
// 	}
// 	assert(false, tprint("cook: node type % is not implemented", node.type));
// 	return newObject3D(Mesh);
// }


#scope_file

TYPE :: BaseNodeAny;

initBaseNode :: (node: *$T) {
	array_init(*node.params);
	nodeInitParams(node);
}

initTypedNodeDummy :BaseTypedNodeInitMethod: (node: *$T) {
}

cookDummy :GeoNodeCookMethod: (node: *Any, inputs:GeoNodeCookInput)->GeoNodeCookOutput {
	mesh := newObject3D(Mesh);
	assert(false, "geo cook should not be used");
	return mesh;
}
nodeComputeDummy :NodeComputeMethod: (node: *Any, depth:u8=0) -> GeoNodeCookOutput {
	tmp: GeoNodeCookOutput;
	return tmp;
}

nodeInitParams :: (node: *$N) {
	// print("nodeInitParams:%\n", type_of(node), <<node);
	// node := cast(*nodeType)_node;

	node_info := type_info(type_of(<<node));
	node_tis := cast(*Type_Info_Struct)node_info;
	paramsField := get_field(node_tis, "p");
	params_info := type_info(type_of(node.p));
	if params_info.type != .STRUCT {
		print("*** handle_params: not a struct\n");
		return;
	}

	params_tis := cast(*Type_Info_Struct)params_info;
	for member: params_tis.members {
		paramField := get_field(params_info, member.name);
		paramPtr := (cast(*u8)node) + paramsField.offset_in_bytes + paramField.offset_in_bytes;
		param := cast(*BaseParamAny)paramPtr;
		initParamByType(param, node);
		// nodeInitParam(node, paramPtr);
	}
}
// nodeInitParam :: (node: *$N, paramPtr: *u8) {
// 	if (cast(*BaseParamAny)paramPtr).type == {
// 		case ParamType.FLOAT;		{ initParam(cast(*FloatParam)		paramPtr, node); return; }
// 		case ParamType.INTEGER; 	{ initParam(cast(*IntegerParam)		paramPtr, node); return; }
// 		case ParamType.VECTOR3; 	{ initParam(cast(*Vector3Param)		paramPtr, node); return; }
// 		case ParamType.VECTOR3UINT; { initParam(cast(*Vector3UIntParam)	paramPtr, node); return; }
// 	}
// 	assert(false, tprint("nodeInitParam: param type % is not implemented", (cast(*BaseParamAny)paramPtr).type));
// }

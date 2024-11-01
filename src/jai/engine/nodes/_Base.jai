// BaseContextNodeInitMethod :: #type (node: *BaseNodeAny);
BaseTypedNodeInitMethod :: #type (node: *$T);
NodeCookMethod :: #type (node: *$T, inputResults:GeoNodeCookInput) -> GeoNodeCookOutput;
NodeComputeMethod :: #type (node: *$T, depth:u8=0) -> GeoNodeCookOutput;

NodeContext :: enum u8 {
	ANY		:: 0;
	ROOT	:: 1;
	GEOMETRY:: 2;
	MATERIAL:: 3;
	TEXTURE	:: 4;
	CPU		:: 5;
	WGSL	:: 6;
	ACTOR	:: 7;
	AUDIO	:: 8;
	RENDER	:: 9;
};

BaseNode :: struct ($baseNodeT: Type, $nodeCtx: NodeContext, $ParamsType: Type, $initMethod:BaseTypedNodeInitMethod, $baseMinInputs: u8=0, $baseMaxInputs: u8=1) {
	#as using coreGraphNode: CoreGraphNode(baseNodeT);
	ctx: NodeContext=nodeCtx;
	nodeId: NodeId;
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
	inputs: [baseMaxInputs]*BaseNode(Any, nodeCtx, Any, initTypedNodeDummy);
}
BaseNodeAny :: BaseNode(Any, NodeContext.ANY, Any, initTypedNodeDummy);

newNode :: (scene: *NodesScene, $T: Type) -> *T {
	// node: *T = alloc(size_of(T));
	node: *T = newCoreGraphNode(*scene.graph, T);
	// node.type = T;

	// node.scene = scene;
	array_add(*scene.nodes, xx node);

	tmp :T;
	// node.type = T;//tmp.type;
	node.ctx = tmp.ctx;
	node.nodeId = NEXT_NODE_ID;
	NEXT_NODE_ID += 1;
	node.p = tmp.p;
	// node.onDirty = tmp.onDirty;
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
	graphConnect(inputNode, node);
	setDirty(node);
}
setInput :: (node: *$N0, inputNode: *$N1) {
	setInput(node, 0, inputNode, 0);
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
NodeId :: u32;
NEXT_NODE_ID :NodeId= 1;

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
		// print("paramField: % % % %\n", member.name, paramField, <<paramField.type);
		member_tis := cast(*Type_Info_Struct)paramField.type;
		paramPtr := (cast(*u8)node) + paramsField.offset_in_bytes + paramField.offset_in_bytes;
		param := cast(*BaseParamAny)paramPtr;
		if cast(*void)param.type == null {
			param.type = paramType(member_tis.name);
		}
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

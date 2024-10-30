// BaseContextNodeInitMethod :: #type (node: *BaseNodeAny);
BaseTypedNodeInitMethod :: #type (node: *BaseNodeAny);

NodeContext :: enum u8 {
	ANY :: 0;
	GEOMETRY :: 1;
	MATERIAL :: 2;
};

BaseNode :: struct ($nodeCtx: NodeContext, $nodeType:string, $ParamsType: Type) {
	#as using coreGraphNode: CoreGraphNode;
	ctx: NodeContext:nodeCtx;
	type: string:nodeType;
	
	// init_context_node :BaseContextNodeInitMethod;//= dummy_init_context_node;
	init_typed_node :BaseTypedNodeInitMethod= dummy_init_typed_node;

	params: [..]*BaseParamAny;
	// let's have the structs whose size can change at the end of the struct,
	// to make it easier to cast and not have read/write issues.
	p:ParamsType;
}
BaseNodeAny :: BaseNode(NodeContext.ANY, "unknown", Any);

newNode :: (scene: *NodesScene, $T: Type) -> *T {
	// node: *T = alloc(size_of(T));
	node: *T = newCoreGraphNode(*scene.graph, T);
	// node.type = T;

	node.scene = scene;
	array_add(*scene.nodes, xx node);

	tmp :T;
	// node.type = tmp.type;
	// node.ctx = tmp.ctx;
	node.p = tmp.p;
	array_init(*node.params);
	// node.init_context_node = tmp.init_context_node;
	node.init_typed_node = tmp.init_typed_node;

	init_base_node(node);
	// node.init_context_node(xx node);
	// if node.ctx == {
	// 	case NodeContext.GEOMETRY; init_geo_node(node);
	// }

	node.init_typed_node(xx node);
	

	return node;
}

init_base_node :: (node: *$T) {
	array_init(*node.params);
	nodeInitParams(node);
}

// dummy_init_context_node :: (node: *BaseNodeAny) {
// }

dummy_init_typed_node :: (node: *BaseNodeAny) {
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
	#assert(N0.ctx == N1.ctx);
	// TODO: ensure the nodes have the same context
}
setInput :: (node: *$N0, inputNode: *$N1) {
	setInput(node, 0, inputNode, 0);
}


#scope_file

nodeInitParams :: (node: *$N) {
	// node := cast(*nodeType)_node;

	node_info := type_info(type_of(<<node));
	node_tis := cast(*Type_Info_Struct)node_info;
	params_field := get_field(node_tis, "p");
	params_info := type_info(type_of(node.p));
	if params_info.type != .STRUCT {
		print("*** handle_params: not a struct\n");
		return;
	}

	params_tis := cast(*Type_Info_Struct)params_info;
	for member: params_tis.members {
		param_field := get_field(params_info, member.name);
		param_ptr := (cast(*u8)node) + params_field.offset_in_bytes + param_field.offset_in_bytes;
		if (cast(*BaseParamAny)param_ptr).type == {
			case ParamType.FLOAT;	initParam(cast(*FloatParam)		param_ptr, node);
			case ParamType.INTEGER; initParam(cast(*IntegerParam)	param_ptr, node);
			case ParamType.VECTOR3; initParam(cast(*Vector3Param)	param_ptr, node);
		}
	}
}

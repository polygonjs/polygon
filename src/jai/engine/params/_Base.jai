ParamInitMethod :: #type (param: *$P, node: *$N);

ParamType :: enum u8 {
	ANY :: 0;
	FLOAT :: 1;
	UINTEGER :: 2;
	VECTOR3 :: 3;
	VECTOR3UINT :: 4;
};
paramValueByType :: (T:ParamType)->Type {
	// if T == {
	// 	case FloatParam; return float32;
	// 	case UIntegerParam; return u32;
	// 	case Vector3Param; return Vector3;
	// 	case Vector3UIntParam; return Vector3UInt;
	// }
	// print("paramValueByType unknown type: %\n", T);
	// // #assert(false);//, tprint("paramValueByType unknown type: %\n", T));
	// assert(false, tprint("paramValueByType unknown type: %\n", T));
	// return u8;
	if T == {
		case ParamType.ANY; return u8;
		case ParamType.FLOAT; return float32;
		case ParamType.UINTEGER; return u32;
		case ParamType.VECTOR3; return Vector3;
		case ParamType.VECTOR3UINT; return Vector3UInt;
	}
	// print("paramValueByType unknown type: %\n", T);
	// #assert(false);//, tprint("paramValueByType unknown type: %\n", T));
	assert(false, tprint("paramValueByType unknown type: %\n", T));
	return u8;
}
initParamByType :: (param: *$P, node: *$N) {
	if param.paramType == {
		case ParamType.FLOAT; {initParam(cast(*FloatParam)param, node);return;}
		case ParamType.UINTEGER; {initParam(cast(*UIntegerParam)param, node);return;}
		case ParamType.VECTOR3; {initParam(cast(*Vector3Param)param, node);return;}
		case ParamType.VECTOR3UINT; {initParam(cast(*Vector3UIntParam)param, node);return;}
	}
	assert(false, tprint("initParamByType unknown type: %\n", param.paramType));
}

BaseParam :: struct ($baseParamT: Type, $ParamTypeValue:ParamType) {
	#as using coreGraphNode: CoreGraphNode(baseParamT);
	// type: ParamType= paramType;
	paramType:ParamType=ParamTypeValue;
	node: *BaseNodeAny;
	// initParam :ParamInitMethod:initMethod;
	
}
BaseParamAny :: BaseParam(Any, ParamType.ANY);

// newParam :: (node: *BaseNode, $T: Type) -> *T {
// 	param: *T = alloc(size_of(T));
// 	param.type = ParamType;

// 	tmp :T;
// 	param.initParam = tmp.initParam;

// 	initParam(param, node);

// 	return node;
// }
initParam :: (param: *$P, node: *$N) {
	// print("initParam START %\n", <<param);
	param.node = xx node;

	param.type = P;
	// tmp:P;

	graphNodeInit(param, graph(node.graphId));

	array_add(*node.params, xx param);
	graphConnect(param, node);

	// initBaseParam(param);
	// param.initParam(param, node);
	// print("initParam END %\n", <<param);
}


// initBaseParam :: (param: *$P) {
// 	// print("initBaseParam node\n");
// }

dummyInitParam :: (param: *$P, node: *$N) {
}

paramSetValue :: (param: *$P, value: $ValueType) {
	param.value = value;
	setDirty(param);
}


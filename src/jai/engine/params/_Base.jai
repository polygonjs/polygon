// ParamInitMethod :: #type (param: *$P, node: *$N);

// ParamType :: enum u8 {
// 	ANY :: 0;
// 	FLOAT :: 1;
// 	UINTEGER :: 2;
// 	VECTOR3 :: 3;
// 	VECTOR3UINT :: 4;
// };
paramValueByType :: (T:Type, $doAssert:bool=true)->Type {
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
		// case ParamType.ANY; return u8;
		case FloatParam; return float32;
		case UIntegerParam; return u32;
		case Vector3Param; return Vector3;
		case Vector3UIntParam; return Vector3UInt;
	}
	// print("paramValueByType unknown type: %\n", T);
	// #assert(false);//, tprint("paramValueByType unknown type: %\n", T));
	if doAssert {
		assert(false, tprint("paramValueByType unknown type: %\n", T));
	}
	return u8;
}
paramType :: (typeName:string)->Type {
	if typeName == {
		case "FloatParam"; return FloatParam;
		case "UIntegerParam"; return UIntegerParam;
		case "Vector3Param"; return Vector3Param;
		case "Vector3UIntParam"; return Vector3UIntParam;
	}
	assert(false, tprint("paramType unknown typeName: %\n", typeName));
	return BaseParamAny;
}
initParamByType :: (param: *$P, node: *$N) {
	if param.type == {
		case FloatParam; {initParam(cast(*FloatParam)param, node);return;}
		case UIntegerParam; {initParam(cast(*UIntegerParam)param, node);return;}
		case Vector3Param; {initParam(cast(*Vector3Param)param, node);return;}
		case Vector3UIntParam; {initParam(cast(*Vector3UIntParam)param, node);return;}
	}
	assert(false, tprint("initParamByType unknown type: %\n", param.type));
}

BaseParam :: struct ($paramType: Type, $valueType: Type) {
	#as using coreGraphNode: CoreGraphNode(paramType);
	// type: ParamType= paramType;
	// paramType:ParamType=ParamTypeValue;
	node: *BaseNodeAny;
	value: valueType;
	defaultValue: valueType;
	// initParam :ParamInitMethod:initMethod;
	
}
BaseParamAny :: BaseParam(Any, u8);

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

paramSetValueGeneric :: (param: *$P, value: $ValueType)
#modify {
	ValueType = paramValueByType(P);
	// print("paramSetValue %->%\n", P, ValueType);
	return true;
}
{
	param.value = value;
	setDirty(param);
}


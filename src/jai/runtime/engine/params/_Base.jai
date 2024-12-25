ParamTypeId :: u8;

// BaseParamStruct :: struct {
// 	paramTypeId: ParamTypeId
// 	valueType: Type
// }

BaseParam :: struct (paramTypeId: ParamTypeId, valueType: Type) {
	#as using coreGraphNode: CoreGraphNode;
	// paramTypeId: ParamTypeId = paramTypeId;
	node: *BaseNodeAny;
	value: valueType;
	defaultValue: valueType;
	
}
BaseParamAny :: BaseParam(0, u8);

// newParam :: (node: *BaseNode, $T: Type) -> *T {
// 	param: *T = alloc(size_of(T));
// 	param.type = ParamType;

// 	tmp :T;
// 	param.initParam = tmp.initParam;

// 	initParam(param, node);

// 	return node;
// }
paramInit :: (param: *$P, node: *$N) {
	// print("initParam START %\n", <<param);
	param.node = xx node;

	// param.type = P;
	// tmp:P;

	graphAddNode(graph(node.graphId), param);

	// array_add(*node.params, xx param);
	graphNodeConnect(src=param, dest=node, false);

	// initBaseParam(param);
	// param.initParam(param, node);
	// print("initParam END %\n", <<param);
}
paramsResetValue :: (param: *$P) {
	param.value = param.defaultValue;
}


// initBaseParam :: (param: *$P) {
// 	// print("initBaseParam node\n");
// }

dummyInitParam :: (param: *$P, node: *$N) {
}

paramSetValueGeneric :: (param: *$P, value: $ValueType)
#modify {
	ValueType = generatedParamValueTypeByParamType(P);
	// print("paramSetValue %->%\n", P, ValueType);
	return true;
}
{
	param.value = value;
	paramPostSetValue(param);
}
paramPostSetValue :: inline (param: *$P)
{
	setDirty(param);
}

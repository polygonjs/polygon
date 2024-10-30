BaseTypedParamInitMethod :: #type (param: *$P, node: *$N);

ParamType :: enum u8 {
	ANY :: 0;
	FLOAT :: 1;
	INTEGER :: 2;
	VECTOR3 :: 3;
};


BaseParam :: struct ($paramType:ParamType, $ValueType: Type) {
	#as using coreGraphNode: CoreGraphNode;
	type: ParamType= paramType;
	node: *BaseNodeAny;
	// initParam :BaseTypedParamInitMethod= dummyInitParam;
	value: ValueType;
}
BaseParamAny :: BaseParam(ParamType.ANY, Any);

// newParam :: (node: *BaseNode, $T: Type) -> *T {
// 	param: *T = alloc(size_of(T));
// 	param.type = ParamType;

// 	tmp :T;
// 	param.initParam = tmp.initParam;

// 	initParam(param, node);

// 	return node;
// }
initParam :: (param: *$P, node: *$N) {
	initGraphNode(param, *node.scene.graph);
	param.node = xx node;
	array_add(*node.params, xx param);
	graphConnect(*node.scene.graph, param, node);

	initBaseParam(param);
	param.initParam(param, node);
}


initBaseParam :: (param: *$P) {
	// print("initBaseParam node\n");
}

// dummyInitParam :: (param: *$P, node: *$N) {
// }

paramSetValue :: (param: *$P, value: $ValueType) {
	param.value = value;
	print("paramSetValue: % %\n", param.type, value);
	print("graphNodeSetDirty\n");
	graphNodeSetDirty(param);
}


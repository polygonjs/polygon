// BaseContextNodeInitMethod :: #type (node: *BaseNodeAny);
// BaseTypedNodeInitMethod :: #type (node: *$T);
// NodeCookMethod :: #type (node: *$T, inputResults:GeoNodeCookInput) -> GeoNodeCookOutput;
// NodeComputeMethod :: #type (node: *$T, depth:u8=0) -> GeoNodeCookOutput;

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

BaseNode :: struct ($baseNodeT: Type, $nodeCtx: NodeContext, $ParamsType: Type, $baseMinInputs: u8=0, $baseMaxInputs: u8=1) {
	#as using coreGraphNode: CoreGraphNode(baseNodeT);
	ctx: NodeContext=nodeCtx;
	nodeId: NodeId;
	// name: string;
	// init_context_node :BaseContextNodeInitMethod;//= dummy_init_context_node;
	// initTypedNode :BaseTypedNodeInitMethod:initMethod;
	minInputsCount: u8= baseMinInputs;
	maxInputsCount: u8= baseMaxInputs;
	// cook:GeoNodeCookMethod:cookMethod;
	// nodeCompute:NodeComputeMethod:nodeComputeMethod;

	params: [..]*BaseParamAny;
	// let's have the structs whose size can change at the end of the struct,
	// to make it easier to cast and not have read/write issues.
	p:ParamsType;
	// inputs: [baseMaxInputs]*BaseNode(Any, nodeCtx, Any);
}
BaseNodeAny :: BaseNode(Any, NodeContext.ANY, Any);

newNode :: (scene: *NodesScene, $T: Type) -> *T {
	// node: *T = alloc(size_of(T));
	node: *T = newCoreGraphNode(*scene.graph, T);
	// node.type = T;

	// node.scene = scene;

	tmp :T;
	// node.type = T;//tmp.type;
	node.ctx = tmp.ctx;
	node.p = tmp.p;
	node.minInputsCount = tmp.minInputsCount;
	node.maxInputsCount = tmp.maxInputsCount;

	sceneNodeAdd(scene, node);
	// node.onDirty = tmp.onDirty;
	// node.cook = tmp.cook;
	// node.nodeCompute = tmp.nodeCompute;
	// node.name = tprint("%-name1",T);
	array_init(*node.params);
	// for nodeInput, i: node.inputs {
	// 	node.inputs[i] = null;
	// }
	// array_init(*node.inputs);
	// node.init_context_node = tmp.init_context_node;
	// node.initTypedNode = tmp.initTypedNode;

	initBaseNode(node);
	nodeInit(node);

	#if NODES_SCENE_EMIT_EVENTS {
		sceneEmitEvent(scene, NodesSceneEvent.NODE_ADDED, node);
	}

	return node;
}


#scope_file

TYPE :: BaseNodeAny;

initBaseNode :: (node: *$T) {
	array_init(*node.params);
	nodeParamsInit(node);
}



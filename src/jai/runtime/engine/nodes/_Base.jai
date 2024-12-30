NodeId :: u32;
NodeIdOrNone :: s64;
NodeTypeId :: u16;
NodeInputIndex :: u8;
NodeInputsCount :: NodeInputIndex;
NodeInputsCountBounds :: struct {
	min: NodeInputsCount;
	max: NodeInputsCount;
}

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

BaseNode :: struct ($ctx: NodeContext, BaseNodeType: Type, $ParamsType: Type, $minInputsCount:NodeInputsCount, $maxInputsCount:NodeInputsCount){
	#as using coreGraphNode: CoreGraphNode;
	type :Type=BaseNodeType;
	nodeId:NodeId;
	nodeTypeId:NodeTypeId;
	p:ParamsType;
}
BaseNodeAny :: BaseNode(.ANY, Any, Any, 0, 0);

#scope_file

TYPE :: BaseNodeAny;



NodeId :: u32;

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

BaseNode :: struct ($BaseNodeType: Type, $ParamsType: Type){
	#as using coreGraphNode: CoreGraphNode(BaseNodeType);
	nodeId:NodeId;
	nodeTypeId:u64;
	p:ParamsType;
}
BaseNodeAny :: BaseNode(Any, Any);

#scope_file

TYPE :: BaseNodeAny;



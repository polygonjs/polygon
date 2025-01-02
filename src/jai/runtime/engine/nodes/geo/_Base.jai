Object3DArray :: [..]*Object3DAny;
GeoNodeCookOutput :: *Object3DArray;
GeoNodeCookInput  :: []GeoNodeCookOutput;
GeoNodeCookMethod :: #type (node: $T, inputResults:GeoNodeCookInput);
NodePrepareInputCookResultsMethod :: #type (scene:*NodesScene, node: *$T);

GeoNode :: struct (GeoNodeType: Type, GeoParamsType: Type, inputs:[2]NodeInputsCount){
	#as using baseNode: BaseNode(NodeContext.GEOMETRY, GeoNodeType, GeoParamsType, minInputsCount=inputs[0], maxInputsCount=inputs[1]);
};
GeoNodeAny :: GeoNode;

geoNodeCookOutputClone :: (output: GeoNodeCookOutput)->GeoNodeCookOutput {
	clone :GeoNodeCookOutput = New(Object3DArray,,temp);
	clone.allocator = temp;
	array_resize(clone, output.count);
	for object, i: <<output {
		(<<clone)[i] = generatedWorldObjectClone(object);
	}
	return clone;
}


#scope_file

TYPE :: GeoNodeAny;


Object3DArray :: [..]*Object3D;
GeoNodeCookOutput :: *Object3DArray;
GeoNodeCookInput  :: [..]GeoNodeCookOutput;
GeoNodeCookMethod :: #type (nodeId: $T, inputResults:GeoNodeCookInput);

GeoNode :: struct ($GeoNodeType: Type, $geoParamsType: Type){
	#as using baseNode: BaseNode(GeoNodeType, geoParamsType);
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


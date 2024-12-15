TransformGeoParams :: struct {
	t: Vector3Param = .{value=.{0,0,0}};
	r: Vector3Param = .{value=.{0,0,0}};
	s: Vector3Param = .{value=.{1,1,1}};
	scale: FloatParam = .{value=1};
}
TransformGeoNode :: struct {
	#as using geoNode: GeoNode(TransformGeoNode, TransformGeoParams);
};

registerTransformGeoNode :: (){
	nodeRegisterGeo(TYPE, minInputsCount=1, maxInputsCount=1);
}

cook :GeoNodeCookMethod: (node: *TYPE, inputResults:GeoNodeCookInput) {
	nodesScene := graphNodeScene(node);
	assert(inputResults.count > 0, "TransformGeoNode::cook should have at least one input\n");
	inputResult0 := inputResults[0];

	{
		using node.p;
		for object: <<inputResult0 {
			(<<object).position += t.value;
			(<<object).scale *= s.value;
			transformableUpdateMatrix(object);
		}
	}

	completeGeoCookWithObjects(nodesScene, xx node, inputResult0);
}

#scope_file

TYPE :: TransformGeoNode;



OutputGeoParams :: struct {
	input: UIntegerParam = .{value=0};
}
OutputGeoNode :: struct {
	#as using geoNode: GeoNode(OutputGeoParams, init, maxInputs=10);
	// geoNode.initTypedNode = initOutputGeoNode;
	geoNode.onDirty = onOutputDirty;
};

cook :GeoNodeCookMethod: (node: *TYPE, inputs:GeoNodeCookInput)->GeoNodeCookOutput {
	selectedIndex := ifx node.p.input.value < inputs.count then node.p.input.value else inputs.count - 1;
	input := inputs[selectedIndex];
	scene := graphNodeScene(node);

	if input != null {
		array_resize(*scene.worldScene.children, 1);
		scene.worldScene.children[0] = xx input;
	} else {
		array_resize(*scene.worldScene.children, 0);
	}

	return input;
}

#scope_file

TYPE :: OutputGeoNode;

init :: (_node: *BaseNodeAny) {
	node := cast(*TYPE)_node;
	// print("init_box_geo_node\n");
	// print("node.params.count 2: %, %\n", node.params.count, node.params);
	// init_geo_node(node);
}

onOutputDirty :: (coreGraphNode: *CoreGraphNode) {
	// print("onOutputDirty: %\n", (cast(*TYPE)coreGraphNode).type);
	// print("cast: %\n", <<(cast(*TYPE) coreGraphNode));
	nodeCompute(cast(*TYPE) coreGraphNode);
}
// nodeComputeOutputGeoNode :NodeComputeMethod: (node: *TYPE, depth:u8=0)->GeoNodeCookOutput {
// 	return nodeCompute(cast(*TYPE)node, depth);
// }


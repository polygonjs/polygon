// // SwitchGeoType :: struct {}
// SwitchGeoParams :: struct {
// 	input: UIntegerParam;
// }
// SwitchGeoNode :: struct {
// 	#as using geoNode: GeoNode(SwitchGeoParams, init, cook, nodeCompute);
// 	// geoNode.initTypedNode = initSwitchGeoNode;
// };

// #scope_file

// NODE_TYPE :: SwitchGeoNode;

// init :: (_node: *BaseNodeAny) {
// 	node := cast(*SwitchGeoNode)_node;
// 	// print("init_switch_geo_node\n");
// 	// init_geo_node(node);
// }
// nodeCompute :NodeComputeMethod: (node: *$T, depth:u8=0)->GeoNodeCookOutput {
// 	return nodeCompute(cast(*TYPE)node, depth);
// }

// cook :GeoNodeCookMethod: (node: *NODE_TYPE, inputs:GeoNodeCookInput)->GeoNodeCookOutput {
// 	selectedIndex := ifx node.p.input.value < inputs.count then node.p.input.value else inputs.count - 1;
// 	input := inputs[selectedIndex];

// 	if input != null {
// 		array_resize(*node.scene.worldScene.children, 1);
// 		node.scene.worldScene.children[0] = xx input;
// 	} else {
// 		array_resize(*node.scene.worldScene.children, 0);
// 	}

// 	return input;
// }
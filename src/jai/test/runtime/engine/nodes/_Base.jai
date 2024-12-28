testBaseNode :: () {

	testWithScene("base node basic", (using options:TestProcedureOptions) {
		
		{
			box1 := createNode(nodesScene, BoxGeoNode);

			assertEqual(box1.minInputsCount, 0);
			assertEqual(box1.maxInputsCount, 1);
			// assertEqual(box1.inputs, .[0,1]);
			// assertEqual(box1.baseMinInputsCount, 0);

			assertEqual(box1.type, BoxGeoNode);
			assertEqual(box1.BaseNodeType, BoxGeoNode);
			assertEqual(box1.GeoNodeType, BoxGeoNode);

			// print("metaDatas: %\n", paramsMetaDataFixed(box1));
			// debugParams(box1);

			assertEqual(tprint("%", type_of(box1)), "*BoxGeoNode");
			assertEqual(tprint("%", type_of(<<box1)), "BoxGeoNode");


			assertEqual(size_of(type_of(<<box1)), 128);
			assertEqual(size_of(type_of(box1.p)), 104);

			box1r :BoxGeoNode = <<box1;
			// printMembers(box1r);
			// printMembers(box1r.contextNode);
			// printMembers(box1r.contextNode.baseNode);

		}

		// {
		// 	CoreGraphNode2 :: struct ($T: Type) {
		// 		type: Type:T;
		// 		graphNodeId: CoreGraphNodeId;
		// 		graphId: CoreGraphId;
		// 		// name: string;
		// 	}
		// 	BaseNode2 :: struct (BaseNodeType: Type, $ctx:NodeContext, $ParamsType: Type, $minInputsCount:u8, $maxInputsCount:u8){
		// 		#as using coreGraphNode: CoreGraphNode2(BaseNodeType);
		// 		nodeId:NodeId;
		// 		nodeTypeId:: #run nextNodeTypeId();
		// 		p:ParamsType;
		// 		// minInputsCount:u8:minInputsCount;
		// 		// maxInputsCount:u8:maxInputsCount;
		// 	}
		// 	GeoNode2 :: struct (GeoNodeType: Type, GeoParamsType: Type, inputs:[2]u8){
		// 		#as using baseNode: BaseNode2(GeoNodeType, NodeContext.GEOMETRY, GeoParamsType, minInputsCount=inputs[0], maxInputsCount=inputs[1]);
		// 	};
		// 	BoxGeoNode2 :: struct {
		// 		#as using contextNode: GeoNode2(BoxGeoNode, BoxGeoParams, inputs=.[0,1]);
		// 	};
		// 	OutputGeoNode2 :: struct {
		// 		#as using contextNode: GeoNode2(BoxGeoNode, BoxGeoParams, inputs=.[0,1]);
		// 	};

		// 	box1 :BoxGeoNode2;
		// 	output1 :OutputGeoNode2;
		// 	printMembers(box1);
		// 	printMembers(box1.contextNode);
		// 	printMembers(box1.contextNode.baseNode);

		// 	assertEqual(box1.nodeTypeId, 0);
		// 	assertEqual(output1.nodeTypeId, 1);
		// }

		endTest();
	});

}

NODE_TYPE_ID:u16 = 0;
nextNodeTypeId :: ()->u16 {
	currentId := NODE_TYPE_ID;
	NODE_TYPE_ID += 1;
	return currentId;
}
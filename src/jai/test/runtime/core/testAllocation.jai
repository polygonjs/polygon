testAllocation :: () {
	test("Monitor pool allocated data", (options:TestProcedureOptions) {
		nodesScene :NodesScene;
		nodesSceneInit(*nodesScene);
		defer nodesSceneReset(*nodesScene);
	
		box1 := createNode(*nodesScene, BoxGeoNode);
		output1 := createNode(*nodesScene, OutputGeoNode);
		setInput(output1, 0, box1);

		mb := 65*1024*1024;
		usedMemory:s64;
		blocksCount:s64;
		for 1..50 {
			paramSetValue(*box1.p.segments, .{1, 1, xx it});
			nodesSceneOutputNodesCompute(*nodesScene);
			usedMemory, blocksCount = poolUsedMemory(*nodesScene.worldScene.pool);
			ratio := (cast(float)usedMemory) / mb;
			// print("%:%, %, %\n", it, blocksCount, usedMemory, ratio);
		}
		assertEqual(blocksCount, 8, "8 blocks allocated");

		endTest();
	});
}

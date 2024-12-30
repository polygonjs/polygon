testAllocation :: () {
	test("Monitor pool allocated data", (options:TestProcedureOptions) {
		nodesScene :NodesScene;
		nodesSceneInit(*nodesScene);
		defer nodesSceneReset(*nodesScene);
	
		box1 := createNode(*nodesScene, BoxGeoNode);
		output1 := createNode(*nodesScene, OutputGeoNode);
		setInput(output1, 0, box1);

		// maxAllocatedMemory := 65*1024*1024;
		maxAllocatedMemory := 65*1024;
		usedMemory:s64;
		blocksCount:s64;
		assertEqual(blocksCount, 0, "0 blocks allocated");
		for 1..6 {
			paramSetValue(*box1.p.segments, .{1, 1, xx (10.0*it)});
			nodesSceneOutputNodesCompute(*nodesScene);
			usedMemory, blocksCount = poolUsedMemory(*nodesScene.worldScene.pool);
			ratio := (cast(float)usedMemory) / maxAllocatedMemory;
			// print("%:%, %, %\n", it, blocksCount, usedMemory, ratio);
		}
		assertEqual(blocksCount, 2, "2 blocks allocated");

		endTest();
	});
}

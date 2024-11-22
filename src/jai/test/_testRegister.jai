#load "runtime/_index.jai";
#load "editor/_index.jai";

registerTests :: () {

	// editor
	testEditor();
	testNetworkPanel();
	// runtime
	testArray();
	testBitArray();
	testCoreGraph();
	testMath();
	testNodesBasicDependency();
	testPerlinNoise();

}


#load "runtime/_index.jai";
#load "editor/_index.jai";

registerTests :: () {

	// editor
	testEditor();
	#if HAS_NETWORK_PANEL == true testNetworkPanel();
	testViewerPanel();
	// runtime
	testArray();
	testBitArray();
	testCoreGraph();
	testMath();
	testNodesBasicDependency();
	testPerlinNoise();
	// nodes
	testNoiseGeoNode();
	testOutputGeoNode();
	testTransformGeoNode();

}


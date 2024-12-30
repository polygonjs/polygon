#load "runtime/_index.jai";
#load "editor/_index.jai";

registerTests :: () {

	// - editor
	testEditor();
	#if HAS_NETWORK_PANEL == true testNetworkPanel();
	testViewerPanel();
	// - runtime
	// - runtime/core
	testAllocation();
	testArray();
	testBitArray();
	testCoreGraph();
	testMath();
	testPerlinNoise();
	testRaycaster();
	testVector();
	// - runtime/engine
	// - runtime/engine/scene
	testNodesBasicDependency();
	testNodeNames();
	testNodeSetInput();
	// - runtime/engine/nodes
	testBaseNode();
	// - runtime/engine/nodes/geo
	testFileSTLGeoNode();
	testNoiseGeoNode();
	testOutputGeoNode();
	testTransformGeoNode();
	// - runtime/engine/nodes/mat
	testBaseMatNode();
}


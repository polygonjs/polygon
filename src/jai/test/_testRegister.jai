#load "runtime/_index.jai";
#load "editor/_index.jai";

registerTests :: () {

	// - editor
	testEditor();
	#if HAS_NETWORK_PANEL == true testNetworkPanel();
	testViewerPanel();
	// - runtime
	// - runtime/core
	testArray();
	testBitArray();
	testCoreGraph();
	testMath();
	testPerlinNoise();
	testRaycaster();
	testVector();
	// - runtime/engine
	// - runtime/engine/nodes
	testBaseNode();
	testFileSTLGeoNode();
	testNoiseGeoNode();
	testOutputGeoNode();
	testTransformGeoNode();
	// - runtime/engine/scene
	testNodesBasicDependency();
	testNodeNames();
	testNodeSetInput();
}


#load "runtime/_index.jai";
#load "editor/_index.jai";

registerTests :: ()->[..]NamedProcedure {

	// editor
	testNetworkPanel();
	// runtime
	testArray();
	testBitArray();
	testCoreGraph();
	testMath();
	testNodesBasicDependency();
	testPerlinNoise();

	return NAMED_PROCEDURES_COMPILE_TIME;
}


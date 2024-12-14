TEST_ASSETS_LOCAL :: "/home/gui/work/web/games/polygon-next-assets/";
TEST_ASSETS_REMOTE :: "https://raw.githubusercontent.com/polygonjs/polygonjs-assets/5404a0cf55b796deb1ce94dc773374afdaa0684c/";
#if WASM {
	TEST_ASSETS :: TEST_ASSETS_REMOTE;
} else {
	TEST_ASSETS :: TEST_ASSETS_LOCAL;
}

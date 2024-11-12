
testMath :: () {
	test("nextPowerOf2", () {
		assertEqual(nextPowerOf2(0), 1);
		assertEqual(nextPowerOf2(1), 1);
		assertEqual(nextPowerOf2(2), 2);
		assertEqual(nextPowerOf2(3), 4);
		assertEqual(nextPowerOf2(4), 4);
		assertEqual(nextPowerOf2(5), 8);
		assertEqual(nextPowerOf2(6), 8);
		assertEqual(nextPowerOf2(7), 8);
		assertEqual(nextPowerOf2(8), 8);
		assertEqual(nextPowerOf2(9), 16);
		assertEqual(nextPowerOf2(10), 16);
		assertEqual(nextPowerOf2(11), 16);
		assertEqual(nextPowerOf2(12), 16);
		assertEqual(nextPowerOf2(13), 16);
		assertEqual(nextPowerOf2(14), 16);
		assertEqual(nextPowerOf2(15), 16);
		assertEqual(nextPowerOf2(254), 256);
		assertEqual(nextPowerOf2(255), 256);
		assertEqual(nextPowerOf2(256), 256);
		assertEqual(nextPowerOf2(257), 512);
		assertEqual(nextPowerOf2(511), 512);
		assertEqual(nextPowerOf2(512), 512);
		assertEqual(nextPowerOf2(513), 1024);
	});
}


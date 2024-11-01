#load "_testHelper.jai";
#load "test_array.jai";
#load "test_bit_array.jai";
#load "test_math.jai";
#load "test_perlin_noise.jai";
#load "test_nodes_basic_dependency.jai";

run_tests :: () {
	print("TEST START\n");
	// test_array();
	test_bit_array();
	test_math();
	// test_perlin_noise();
	test_nodes_basic_dependency();

	print("TEST COMPLETED\n");
}
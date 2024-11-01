
testBitArray :: () {
	dirty: Bit_Array;

	assertEqual(bits_count(2), 1);
	assertEqual(bits_count(3), 1);
	assertEqual(bits_count(4), 1);
	assertEqual(bits_count(5), 1);
	assertEqual(bits_count(6), 1);
	assertEqual(bits_count(7), 1);
	assertEqual(bits_count(8), 1);
	assertEqual(bits_count(64), 1);
	assertEqual(bits_count(65), 2);

	init_bit_array(*dirty, 2);
	assertEqual(dirty.slots.count, 1);
	assertEqual(dirty.count, 2);
	assertEqual(dirty[0], false);
	dirty[0]=true;
	assertEqual(dirty[0], true);

	bit_array_resize(*dirty, 4);
	assertEqual(dirty.slots.count, 1);
	assertEqual(dirty.count, 4);
	assertEqual(dirty[0], true);

	bit_array_resize(*dirty, 128);
	assertEqual(dirty.slots.count, 2);
	assertEqual(dirty.count, 128);
	assertEqual(dirty[0], true);
	dirty[100] = true;
	assertEqual(dirty[100], true);

	bit_array_resize(*dirty, 1024);
	assertEqual(dirty.slots.count, 16);
	assertEqual(dirty.count, 1024);
	assertEqual(dirty[0], true);
	assertEqual(dirty[100], true);

	deinit(*dirty);
}


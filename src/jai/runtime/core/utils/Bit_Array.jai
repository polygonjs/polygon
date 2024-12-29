BIT_ARRAY_DEFAULT_RESERVE_SIZE :: ARRAY_DEFAULT_RESERVE_SIZE;

init_bit_array :: (array: *Bit_Array) {
	init_bit_array(array, BIT_ARRAY_DEFAULT_RESERVE_SIZE);
}

bit_array_resize :: (array: *Bit_Array, new_count: u32, $initialize:=true) {
	new_size := bitsCount(new_count);
	old_count := array.count;
	if old_count == new_count return;
	push_allocator(array.allocator);
	array_resize(*array.slots, new_size);
	array.count = new_count;
	// array.data = cast(*T) realloc(array.data, new_count * size_of(T), array.count * size_of(T));
	// array.count = new_count;

	// #if initialize  init_range(array.data, old_count, new_count);
}
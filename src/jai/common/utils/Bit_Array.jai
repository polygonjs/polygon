bit_array_resize :: (array: *Bit_Array, new_count: u32, $initialize:=true) {
	new_size := bits_count(new_count);
	old_count := array.count;
	if old_count == new_count return;
	array_resize(*array.slots, new_size);
	array.count = new_count;
	// array.data = cast(*T) realloc(array.data, new_count * size_of(T), array.count * size_of(T));
	// array.count = new_count;

	// #if initialize  init_range(array.data, old_count, new_count);
}
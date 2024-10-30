array_find_ptr :: (array: *[] $T, item: T) -> bool, s64 {
	for <<array if it == item return true, it_index;
	return false, -1;  // Not found.
}
array_init :: (array: *[..] $T) {
	array.count = 0;
	array.allocated = 0;
	array.data = null;
	tmp_array:[..]u8;
	array.allocator = tmp_array.allocator;
}
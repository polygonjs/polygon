array_find_ptr :: (array: *[] $T, item: T) -> bool, s64 {
	for <<array if it == item return true, it_index;
	return false, -1;  // Not found.
}
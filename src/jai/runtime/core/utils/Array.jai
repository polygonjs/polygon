array_find_ptr :: (array: *[] $T, item: T) -> bool, s64 {
	for <<array if it == item return true, it_index;
	return false, -1;  // Not found.
}
array_init :: (array: *[..] $T, allocator: Allocator=context.allocator) {
	array.count = 0;
	array.allocated = 0;
	array.data = null;
	array.allocator = allocator;
}
array_concat :: (array0: [$N] $T, array1: [$M] T)-> [..] T {
	array:[..]T;
	for item: array0 {array_add(*array, item);}
	for item: array1 {array_add(*array, item);}
	return array;
}

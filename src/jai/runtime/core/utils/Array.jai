ARRAY_DEFAULT_RESERVE_SIZE :: 1024;
array_reserve :: (array: *[..] $T) {
	array_reserve(array, ARRAY_DEFAULT_RESERVE_SIZE);
}

array_find_ptr :: (array: *[] $T, item: T) -> bool, s64 {
	for <<array if it == item return true, it_index;
	return false, -1;  // Not found.
}
array_init :: (array: *[..] $T, allocator: Allocator=context.allocator, $reserve:bool=false) {
	// is_context := allocator.proc==context.allocator.proc;
	// if is_context {
	// 	// print("is context:%\n", allocator.proc==context.allocator.proc);
	// 	// print_stack_trace(context.stack_trace);
	// }

	array.count = 0;
	array.allocated = 0;
	array.data = null;
	array.allocator = allocator;
	#if reserve {
		array_reserve(array);
	}
}
array_concat :: (array0: [$N] $T, array1: [$M] T)-> [..] T {
	array:[..]T;
	for item: array0 {array_add(*array, item);}
	for item: array1 {array_add(*array, item);}
	return array;
}
array_set_count_and_maybe_grow :: (array: *[..] $T, newCount: s64) #modify {
	// tia := cast(*Type_Info_Array) T;
	// print("e:%\n", tia.element_type.type);
	// elementTypeInfo := tia.element_type.type;
	// print("elementTypeInfo:%\n", elementTypeInfo);
	// if elementTypeInfo == .STRUCT {

	// }
	return true;
} {
	array.count = newCount;
	maybe_grow(array);
}
maybe_grow :: inline (array: *[..] $T) {
	maybe_grow(xx array, size_of(T));
}
// array_copy_shallow :: (src: [..] T, target: *[..] $T) {
// 	target.count = src.count;
// 	array_resize(target, src.count);
// 	for i: 0..src.count-1 {
// 		target[i] = src[i];
// 	}
// }

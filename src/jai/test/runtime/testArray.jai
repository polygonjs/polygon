testArray :: () {
	test("Array", () {
		arr :[..]Vector2Int;
		array_add(*arr, .{1,2});
		array_add(*arr, .{3,4});
		array_add(*arr, .{5,6});

		value0 := arr[1];
		value0.x =17;
		assertEqual(arr[1].x, 3);

		ptr1 := *arr[1];
		ptr1.x = 17;
		assertEqual(arr[1].x, 17);

		nums:[3]u32;
		nums[1]=12;
		assertEqual(nums[1], 12);

		array_reset(*arr);
	});
}

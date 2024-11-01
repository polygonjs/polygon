testArray :: () {
	print("ok\n");

	arr :[..]Vector2Int;
	array_add(*arr, .{1,2});
	array_add(*arr, .{3,4});
	array_add(*arr, .{5,6});

	e := *arr[1];

	print("arr:%\n", arr);
	print("e:%\n", e);

	e.x = 17;

	print("e:%\n", e);

	e2 := arr[1];
	print("e2:%\n", e2);

	nums:[3]u32;
	print("nums:%\n", nums);
	nums[1]=12;
	print("nums:%\n", nums);
}


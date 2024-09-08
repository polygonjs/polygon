test_perlin_noise :: () {
	tests := Vector3.[
		.{-0.5, -0.395161, -0.5},
		.{1.2, 0, 0},
		.{1.2, 1.2, 0},
		.{1.2, 1.2, 0},
	];
	for tests print("% -> %\n", it, perlin_noise(it.x, it.y, it.z));
}
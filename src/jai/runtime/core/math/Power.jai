nextPowerOf2 :: (x: u32) -> u32 {
	if x == 0 return 1;
	x -= 1;
	x |= x >> 1;
	x |= x >> 2;
	x |= x >> 4;
	x |= x >> 8;
	x |= x >> 16;
	return x + 1;
}
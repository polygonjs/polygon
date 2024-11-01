#load "Matrix.jai";
#load "Radian.jai";
#load "Vector.jai";

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

bits_count :: (x: u32) -> u32 {
	return (x + 63) >> 6;
}

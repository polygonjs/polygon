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
deg_to_rad :: inline (degrees : float) -> float {
	return cast(float) (degrees * PI / 180.0);
}
round :: inline (x: float) -> float {
	return cast(float)cast(int)(x + (ifx x>0 then 0.5 else -0.5));
}

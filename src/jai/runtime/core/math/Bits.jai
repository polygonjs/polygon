bitsCount :: (x: u32) -> u32 {
	return (x + 63) >> 6;
}
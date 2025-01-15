export const WASM_DATA_SIZE = {
	bool: BigInt(1),
	u8: BigInt(1),
	u16: BigInt(2),
	u32: BigInt(4),
	u64: BigInt(8),
	s32: BigInt(4),
	float: BigInt(4),
	float32: BigInt(4),
	float64: BigInt(8),
};

export const ENUM_SIZE = WASM_DATA_SIZE.u32;


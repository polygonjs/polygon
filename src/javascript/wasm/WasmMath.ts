export const WASM_MATH = {
	acosf: Math.acos,
	cosf: Math.cos,
	pow: (a: bigint, exp: bigint) => a ** exp,
	powf: Math.pow,
	sinf: Math.sin,
};

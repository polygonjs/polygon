export function fmodf(x: number, y: number): number {
	if (y === 0) {
		return NaN; // Return NaN if y is 0, to mimic typical fmod behavior
	}

	// Use JavaScript's % operator, but ensuring it works correctly for floating-point numbers
	return x - Math.floor(x / y) * y;
}

export const WASM_MATH = {
	acosf: Math.acos,
	cosf: Math.cos,
	pow: (a: bigint, exp: bigint) => a ** exp,
	powf: Math.pow,
	sinf: Math.sin,
	atan2f: Math.atan2,
	log: Math.log,
	logf: Math.log,
	fmodf,
};

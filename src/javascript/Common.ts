export type UpdateWasmFunction = (
	uselessArg: BigInt,
	time: BigInt,
	aspect: BigInt
) => void;
export interface Vector2 {
	x: number;
	y: number;
}
export interface Vector3 {
	x: number;
	y: number;
	z: number;
}

declare global {
	interface Window {
		update_wasm: UpdateWasmFunction;
		// offset: number;
	}
}

window.update_wasm = (time) => console.log(`default update_wasm:${time}`);

export interface AllocatedMemory {
	buffer: Iterable<number>;
}
export interface AllocatedMemoryContainer {
	allocatedMemory?: AllocatedMemory;
}

export interface Shaders {
	basic: string;
}
export const SHADERS: Shaders = {
	basic: "",
};

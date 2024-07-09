export type SetTimeFunction = (uselessArg: BigInt, time: BigInt) => void;
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
		set_wasm_time: SetTimeFunction;
		// offset: number;
	}
}

window.set_wasm_time = (time) => console.log(`default set_time:${time}`);

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

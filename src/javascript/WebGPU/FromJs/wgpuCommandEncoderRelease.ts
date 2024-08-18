import { heapDeleteByIndex } from "../../WasmHeap";

export function wgpuCommandEncoderRelease(index: bigint) {
	// console.log("wgpuCommandEncoderRelease", pointer);
	heapDeleteByIndex(index);
	// commandEncoder?.release();
}


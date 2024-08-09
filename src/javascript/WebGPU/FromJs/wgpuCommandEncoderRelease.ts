import { heapDelete } from "../../WasmHeap";

export function wgpuCommandEncoderRelease(pointer: bigint) {
	// const commandEncoder = heapGet<GPUCommandEncoder>(pointer);
	// console.log("wgpuCommandEncoderRelease", pointer, commandEncoder);
	heapDelete(pointer);
	// commandEncoder?.release();
}

import { heapDelete } from "../../WasmHeap";

export function wgpuCommandBufferRelease(pointer: bigint) {
	// const commandBuffer = heapGet<GPUCommandBuffer>(pointer);
	// console.log("wgpuCommandBufferRelease", pointer, commandBuffer);
	heapDelete(pointer);
	// commandBuffer?.release();
}

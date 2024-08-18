import { heapDeleteByIndex } from "../../WasmHeap";

export function wgpuCommandBufferRelease(index: bigint) {
	// const commandBuffer = heapGet<GPUCommandBuffer>(pointer);
	// console.log("wgpuCommandBufferRelease", pointer, commandBuffer);
	heapDeleteByIndex(index);
	// commandBuffer?.release();
}


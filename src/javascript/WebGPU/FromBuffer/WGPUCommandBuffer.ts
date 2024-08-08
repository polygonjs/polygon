import { heapGet } from "../../WasmHeap";
import { WGPU_SIZE } from "../utils/WebGPUOffset";

export function WGPUCommandBufferFromBuffer(pointer: bigint): GPUCommandBuffer {
	const buffer = window.ALLOCATED_MEMORY_CONTAINER.allocatedMemory!.buffer;
	const u64 = new BigUint64Array(buffer);

	const pointerValue = u64[Number(pointer / WGPU_SIZE.u64)];
	const commandBuffer = heapGet<GPUCommandBuffer>(pointerValue)!;
	return commandBuffer;
}

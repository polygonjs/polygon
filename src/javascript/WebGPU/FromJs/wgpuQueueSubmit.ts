import { heapGet } from "../../WasmHeap";
import { WGPUCommandBufferFromBuffer } from "../FromBuffer/WGPUCommandBuffer";

export function wgpuQueueSubmit(
	queueHeapIndex: bigint,
	commandCount: bigint,
	commandsBufferPointer: bigint
): void {
	const queue = heapGet<GPUQueue>(queueHeapIndex)!;
	const commandBuffer = WGPUCommandBufferFromBuffer(commandsBufferPointer);
	// const commandBuffer = heapGet<GPUCommandBuffer>(commandsPointer)!;
	if (commandCount > 1) {
		throw new Error("commandCount > 1 is not supported yet");
	}
	return queue.submit([commandBuffer]);
}

import { heapDeleteByIndex } from "../../WasmHeap";

export function wgpuQueueRelease(index: bigint): void {
	// const queue = heapGet<GPUQueue>(queueHeapIndex);
	// queue?.release();
	heapDeleteByIndex(index);
}


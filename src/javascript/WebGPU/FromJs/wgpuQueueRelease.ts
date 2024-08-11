import { heapDelete } from "../../WasmHeap";

export function wgpuQueueRelease(queueHeapIndex: bigint): void {
	// const queue = heapGet<GPUQueue>(queueHeapIndex);
	// queue?.release();
	heapDelete(queueHeapIndex);
}

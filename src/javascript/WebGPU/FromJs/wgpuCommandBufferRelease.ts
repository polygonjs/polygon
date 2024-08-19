import { heapDeleteByIndex } from "../../WasmHeap";

export function wgpuCommandBufferRelease(index: bigint) {
	heapDeleteByIndex(index);
}


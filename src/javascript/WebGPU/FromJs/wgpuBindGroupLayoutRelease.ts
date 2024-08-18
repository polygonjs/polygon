import { heapDeleteByIndex } from "../../WasmHeap";

export function wgpuBindGroupLayoutRelease(index: bigint) {
	heapDeleteByIndex(index);
}


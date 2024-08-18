import { heapDeleteByIndex } from "../../WasmHeap";

export function wgpuBindGroupRelease(pointer: bigint) {
	heapDeleteByIndex(pointer);
}


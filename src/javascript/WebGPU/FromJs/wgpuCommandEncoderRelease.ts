import { heapDeleteByIndex } from "../../WasmHeap";

export function wgpuCommandEncoderRelease(index: bigint) {
	heapDeleteByIndex(index);
}


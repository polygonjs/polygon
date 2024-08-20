import { heapDeleteByIndex } from "../../WasmHeap";

export function wgpuComputePassEncoderRelease(index: bigint) {
	heapDeleteByIndex(index);
}


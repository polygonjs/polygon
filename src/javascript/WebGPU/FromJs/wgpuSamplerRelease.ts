import { heapDeleteByIndex } from "../../WasmHeap";

export function wgpuSamplerRelease(samplerHeapIndex: bigint) {
	heapDeleteByIndex(samplerHeapIndex);
}


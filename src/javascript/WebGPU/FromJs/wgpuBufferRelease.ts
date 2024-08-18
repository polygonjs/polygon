import { heapDeleteByIndex } from "../../WasmHeap";

export function wgpuBufferRelease(index: bigint) {
	// const buffer = heapGet<GPUBuffer>(pointer);
	// buffer?.release();
	heapDeleteByIndex(index);
}


import { heapDelete } from "../../WasmHeap";

export function wgpuBufferRelease(pointer: bigint) {
	// const buffer = heapGet<GPUBuffer>(pointer);
	// buffer?.release();
	heapDelete(pointer);
}

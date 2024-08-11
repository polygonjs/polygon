import { heapDelete, heapGet } from "../../WasmHeap";

export function wgpuBufferDestroy(pointer: bigint) {
	const buffer = heapGet<GPUBuffer>(pointer);
	buffer?.destroy();
	heapDelete(pointer);
}

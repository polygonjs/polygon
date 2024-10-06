import { heapDeleteByIndex, heapGet } from "../../WasmHeap";

export function wgpuBufferDestroy(index: bigint) {
	const buffer = heapGet<GPUBuffer>(index);
	if (buffer) {
		buffer.destroy();
	}
	heapDeleteByIndex(index);
}


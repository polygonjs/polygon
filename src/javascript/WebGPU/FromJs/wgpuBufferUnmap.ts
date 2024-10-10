import { heapGet } from "../../WasmHeap";

export function wgpuBufferUnmap(bufferHeapIndex: bigint) {
	const buffer = heapGet<GPUBuffer>(bufferHeapIndex)!;

	return buffer.unmap();
}


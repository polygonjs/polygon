import { heapGet } from "../../WasmHeap";

export function wgpuBufferMapAsync(
	bufferHeapIndex: bigint,
	mode: bigint,
	offset: bigint,
	size: bigint
) {
	const buffer = heapGet<GPUBuffer>(bufferHeapIndex)!;

	return buffer.mapAsync(Number(mode), Number(offset), Number(size));
}


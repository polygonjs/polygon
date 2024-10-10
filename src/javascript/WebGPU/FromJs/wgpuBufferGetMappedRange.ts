import { heapGet } from "../../WasmHeap";

export function wgpuBufferGetMappedRange(
	bufferHeapIndex: bigint,
	offset: bigint,
	size: bigint
) {
	const buffer = heapGet<GPUBuffer>(bufferHeapIndex)!;
	console.log(buffer, offset, size);
	return buffer.getMappedRange(Number(offset), Number(size));
}


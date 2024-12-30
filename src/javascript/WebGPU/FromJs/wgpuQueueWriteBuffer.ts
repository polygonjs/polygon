import { heapGet } from "../../WasmHeap";

export function wgpuQueueWriteBuffer(
	queueHeapIndex: bigint,
	bufferHeadIndex: bigint,
	bufferOffset: bigint,
	dataPointer: bigint,
	size: bigint
) {
	const queue = heapGet<GPUQueue>(queueHeapIndex)!;
	const gpuBuffer = heapGet<GPUBuffer>(bufferHeadIndex)!;
	const buffer = window.ALLOCATED_MEMORY_CONTAINER.allocatedMemory!.buffer;
	const start = Number(dataPointer);
	const sizeN = Number(size);

	return queue.writeBuffer(
		gpuBuffer,
		Number(bufferOffset),
		buffer,
		start,
		sizeN
	);
}


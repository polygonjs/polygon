import { heapGet } from "../../WasmHeap";
import { WGPU_SIZE } from "../utils/WebGPUOffset";

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
	const start = Number(dataPointer / WGPU_SIZE.float);
	const sizeN = Number(size);
	const elementsCount = sizeN / Number(WGPU_SIZE.float);
	const f32 = new Float32Array(buffer).subarray(start, start + elementsCount);

	return queue.writeBuffer(
		gpuBuffer,
		Number(bufferOffset),
		f32,
		0,
		elementsCount
	);
}


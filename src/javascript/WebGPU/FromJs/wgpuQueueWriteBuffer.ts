import { heapGet } from "../../WasmHeap";
import { WGPU_SIZE } from "../utils/WebGPUOffset";

export function wgpuQueueWriteBuffer(
	queueHeapIndex: bigint,
	bufferHeadIndex: bigint,
	bufferOffset: bigint,
	dataPointer: bigint,
	size: bigint
) {
	// console.log({
	// 	queueHeapIndex,
	// 	bufferHeadIndex,
	// 	bufferOffset,
	// 	dataPointer,
	// 	size,
	// });
	const queue = heapGet<GPUQueue>(queueHeapIndex)!;
	const gpuBuffer = heapGet<GPUBuffer>(bufferHeadIndex)!;
	const buffer = window.ALLOCATED_MEMORY_CONTAINER.allocatedMemory!.buffer;
	// const u8 = new Uint8Array(buffer);
	// const u32 = new Uint32Array(buffer);
	const start = Number(dataPointer / WGPU_SIZE.float);
	const sizeN = Number(size);
	const elementsCount = sizeN / Number(WGPU_SIZE.float);
	const f32 = new Float32Array(buffer).subarray(start, start + elementsCount);
	// const data = u64.slice(Number(dataPointer), Number(dataPointer) + size);
	// console.log("queue:", gpuBuffer, bufferOffset, f32, 0, sizeN);
	console.log(
		"writeBuffer",
		gpuBuffer,
		Number(bufferOffset),
		f32,
		0,
		elementsCount
	);
	for (let i = 0; i < elementsCount; i++) {
		if (isNaN(f32[i])) {
			console.error("writeBuffer: isNaN", i, f32[i]);
		}
	}
	return queue.writeBuffer(
		gpuBuffer,
		Number(bufferOffset),
		f32,
		0,
		elementsCount
	);
	// const pipeline = WGPURenderPipelineFromBuffer(
	// 	device,
	// 	pipelineDescriptorPtr
	// );
	// return heapAdd(pipeline);
}

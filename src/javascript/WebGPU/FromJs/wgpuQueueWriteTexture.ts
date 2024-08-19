import { heapGet } from "../../WasmHeap";
import { WGPUExtent3DFromBuffer } from "../FromBuffer/WGPUExtent3D";
import { WGPUImageCopyTextureFromBuffer } from "../FromBuffer/WGPUImageCopyTexture";
import { WGPUTextureDataLayout } from "../FromBuffer/WGPUTextureDataLayout";

export function wgpuQueueWriteTexture(
	queuHeapIndex: bigint,
	destinationPointer: bigint,
	dataPointer: bigint,
	dataSize: bigint,
	dataLayoutPointer: bigint,
	sizePointer: bigint
): void {
	const buffer = window.ALLOCATED_MEMORY_CONTAINER.allocatedMemory!.buffer;

	const queue = heapGet<GPUQueue>(queuHeapIndex)!;
	const destination = WGPUImageCopyTextureFromBuffer(destinationPointer);

	const data = new Uint8Array(buffer).subarray(
		Number(dataPointer),
		Number(dataPointer) + Number(dataSize)
	);

	const dataLayout = WGPUTextureDataLayout(dataLayoutPointer);
	const size = WGPUExtent3DFromBuffer(sizePointer);

	queue.writeTexture(destination, data, dataLayout, size);
	// return null as void;
}


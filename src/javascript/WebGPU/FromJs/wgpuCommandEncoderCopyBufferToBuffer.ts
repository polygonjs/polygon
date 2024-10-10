import { heapGet } from "../../WasmHeap";

export function wgpuCommandEncoderCopyBufferToBuffer(
	encoderHeapIndex: bigint,
	sourceHeapIndex: bigint,
	sourceOffset: bigint,
	destinationHeapIndex: bigint,
	destinationOffset: bigint,
	size: bigint
) {
	const encoder = heapGet<GPUCommandEncoder>(encoderHeapIndex)!;
	const source = heapGet<GPUBuffer>(sourceHeapIndex)!;
	const destination = heapGet<GPUBuffer>(destinationHeapIndex)!;

	return encoder.copyBufferToBuffer(
		source,
		Number(sourceOffset),
		destination,
		Number(destinationOffset),
		Number(size)
	);
}


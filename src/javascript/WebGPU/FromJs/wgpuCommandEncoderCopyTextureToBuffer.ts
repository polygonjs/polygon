import { heapGet } from "../../WasmHeap";
import { WGPUExtent3DFromBuffer } from "../FromBuffer/WGPUExtent3D";
import { WGPUImageCopyBufferFromBuffer } from "../FromBuffer/WGPUImageCopyBuffer";
import { WGPUImageCopyTextureFromBuffer } from "../FromBuffer/WGPUImageCopyTexture";

export function wgpuCommandEncoderCopyTextureToBuffer(
	encoderHeapIndex: bigint,
	sourceHeapIndex: bigint,
	destinationHeapIndex: bigint,
	copySizeHeapIndex: bigint
) {
	const encoder = heapGet<GPUCommandEncoder>(encoderHeapIndex)!;
	const source = WGPUImageCopyTextureFromBuffer(sourceHeapIndex);
	const destination = WGPUImageCopyBufferFromBuffer(destinationHeapIndex);
	const copySize = WGPUExtent3DFromBuffer(copySizeHeapIndex);

	return encoder.copyTextureToBuffer(source, destination, copySize);
}


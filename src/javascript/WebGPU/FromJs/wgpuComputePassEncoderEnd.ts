import { heapGet } from "../../WasmHeap";

export function wgpuComputePassEncoderEnd(encoderHeapIndex: bigint) {
	const encoder = heapGet<GPUComputePassEncoder>(encoderHeapIndex)!;
	return encoder.end();
}


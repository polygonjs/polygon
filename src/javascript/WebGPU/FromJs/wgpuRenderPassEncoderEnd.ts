// wgpuRenderPassEncoderEnd :: (renderPassEncoder: WGPURenderPassEncoder) -> void #foreign;

import { heapGet } from "../../WasmHeap";

export function wgpuRenderPassEncoderEnd(encoderHeapIndex: bigint) {
	const encoder = heapGet<GPURenderPassEncoder>(encoderHeapIndex)!;
	return encoder.end();
}


// wgpuRenderPassEncoderEnd :: (renderPassEncoder: WGPURenderPassEncoder) -> void #foreign;

import { heapGet } from "../../WasmHeap";

export function wgpuRenderPassEncoderEnd(renderPassEncoderHeapIndex: bigint) {
	const renderPassEncoder = heapGet<GPURenderPassEncoder>(
		renderPassEncoderHeapIndex
	)!;
	return renderPassEncoder.end();
}

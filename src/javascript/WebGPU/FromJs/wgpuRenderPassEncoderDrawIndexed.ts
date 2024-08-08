// wgpuRenderPassEncoderDrawIndexed :: (renderPassEncoder: WGPURenderPassEncoder, indexCount: u32, instanceCount: u32, firstIndex: u32, baseVertex: s32, firstInstance: u32) -> void #foreign;

import { heapGet } from "../../WasmHeap";

export function wgpuRenderPassEncoderDrawIndexed(
	renderPassEncoderHeapIndex: bigint,
	indexCount: number,
	instanceCount: number,
	firstIndex: number,
	baseVertex: number,
	firstInstance: number
) {
	const renderPassEncoder = heapGet<GPURenderPassEncoder>(
		renderPassEncoderHeapIndex
	)!;

	return renderPassEncoder.drawIndexed(
		indexCount,
		instanceCount,
		firstIndex,
		baseVertex,
		firstInstance
	);
}

import { heapGet } from "../../WasmHeap";

// wgpuRenderPassEncoderSetVertexBuffer :: (renderPassEncoder: WGPURenderPassEncoder, slot: u32, buffer: WGPUBuffer, offset: u64, size: u64) -> void #foreign;

export function wgpuRenderPassEncoderSetVertexBuffer(
	renderPassEncoderHeapIndex: bigint,
	slot: number,
	bufferHeapIndex: bigint,
	offset: bigint,
	size: bigint
) {
	const renderPassEncoder = heapGet<GPURenderPassEncoder>(
		renderPassEncoderHeapIndex
	)!;
	const buffer = heapGet<GPUBuffer>(bufferHeapIndex)!;
	return renderPassEncoder.setVertexBuffer(
		slot,
		buffer,
		Number(offset),
		Number(size)
	);
}


import { heapGet } from "../../WasmHeap";
import { indexFormatIntToGPUIndexFormat } from "../utils/WebGPUMap";
// wgpuRenderPassEncoderSetIndexBuffer :: (renderPassEncoder: WGPURenderPassEncoder, buffer: WGPUBuffer, format: WGPUIndexFormat, offset: u64, size: u64) -> void #foreign;

export function wgpuRenderPassEncoderSetIndexBuffer(
	renderPassEncoderHeapIndex: bigint,
	bufferHeapIndex: bigint,
	formatIndex: number,
	offset: bigint,
	size: bigint
) {
	const renderPassEncoder = heapGet<GPURenderPassEncoder>(
		renderPassEncoderHeapIndex
	)!;
	const buffer = heapGet<GPUBuffer>(bufferHeapIndex)!;
	const format = indexFormatIntToGPUIndexFormat(formatIndex);
	return renderPassEncoder.setIndexBuffer(
		buffer,
		format,
		Number(offset),
		Number(size)
	);
}

import { heapGet } from "../../WasmHeap";
import { WGPUColorFromBuffer } from "../FromBuffer/WGPUColor";

export function wgpuRenderPassEncoderSetBlendConstant(
	renderPassEncoderHeapIndex: bigint,
	colorPointer: bigint
) {
	const renderPassEncoder = heapGet<GPURenderPassEncoder>(
		renderPassEncoderHeapIndex
	);
	if (renderPassEncoder == null) {
		throw new Error(
			"wgpuRenderPassEncoderSetViewport renderPassEncoder is null"
		);
	}
	const color = WGPUColorFromBuffer(colorPointer);
	renderPassEncoder.setBlendConstant(color);
}

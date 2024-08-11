import { heapGet } from "../../WasmHeap";

export function wgpuRenderPassEncoderSetScissorRect(
	renderPassEncoderHeapIndex: bigint,
	x: number,
	y: number,
	width: number,
	height: number
) {
	const renderPassEncoder = heapGet<GPURenderPassEncoder>(
		renderPassEncoderHeapIndex
	);
	if (renderPassEncoder == null) {
		throw new Error(
			"wgpuRenderPassEncoderSetViewport renderPassEncoder is null"
		);
	}
	renderPassEncoder.setScissorRect(x, y, width, height);
}

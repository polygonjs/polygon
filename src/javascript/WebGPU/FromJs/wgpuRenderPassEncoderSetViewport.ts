import { heapGet } from "../../WasmHeap";

// wgpuRenderPassEncoderSetViewport :: (renderPassEncoder: WGPURenderPassEncoder, x: float, y: float, width: float, height: float, minDepth: float, maxDepth: float) -> void #foreign libwgpu_native;
export function wgpuRenderPassEncoderSetViewport(
	renderPassEncoderHeapIndex: bigint,
	x: number,
	y: number,
	width: number,
	height: number,
	minDepth: number,
	maxDepth: number
): void {
	const renderPassEncoder = heapGet<GPURenderPassEncoder>(
		renderPassEncoderHeapIndex
	);
	if (renderPassEncoder == null) {
		throw new Error(
			"wgpuRenderPassEncoderSetViewport renderPassEncoder is null"
		);
	}
	renderPassEncoder.setViewport(x, y, width, height, minDepth, maxDepth);
}

import { heapAdd, heapGet } from "../../WasmHeap";

export interface WGPURequestResponse {
	device: GPUDevice;
	presentationFormat: GPUTextureFormat;
}

export function js_wgpu_texture_get_width_surface(
	canvasHeapIndex: bigint
): number {
	const canvas = heapGet<HTMLCanvasElement>(canvasHeapIndex)!;
	return canvas.width;
}
export function js_wgpu_texture_get_height_surface(
	canvasHeapIndex: bigint
): number {
	const canvas = heapGet<HTMLCanvasElement>(canvasHeapIndex)!;
	return canvas.height;
}

export function wgpuSurfaceGetCurrentTexture() {
	const texture = window.webGPUContext.getCurrentTexture(); //.createView();
	const index = heapAdd(texture);
	return index;
}


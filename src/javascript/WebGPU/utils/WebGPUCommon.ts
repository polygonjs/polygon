import { heapAdd, heapGet } from "../../WasmHeap";

export interface WebGPURequestResponse {
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
	const texture = window.webGPUContext.getCurrentTexture();
	const index = heapAdd(texture);
	return index;
}

export function gpuMappedStateToWGPU(mapState: GPUBufferMapState) {
	switch (mapState) {
		case "mapped": {
			return 2;
		}
		case "pending": {
			return 1;
		}
		case "unmapped": {
			return 0;
		}
	}
	return 0;
}
export function wgpuErrorScopeFilterToGPU(filter: bigint): GPUErrorFilter {
	switch (filter) {
		case 0n: {
			return "validation";
		}
		case 1n: {
			return "out-of-memory";
		}
		case 2n: {
			return "internal";
		}
	}
	return "validation";
}

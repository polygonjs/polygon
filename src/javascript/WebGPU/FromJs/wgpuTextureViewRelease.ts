import { heapDelete, heapGet } from "../../WasmHeap";

export function wgpuTextureViewRelease(textureHeapIndex: bigint) {
	const textureView = heapGet<GPUTextureView>(textureHeapIndex);
	if (textureView instanceof GPUTextureView) {
		heapDelete(textureHeapIndex);
	} else {
		console.error(
			`wgpuTextureViewRelease: not a texture view at index ${textureHeapIndex}`
		);
	}
}

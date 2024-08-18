import { heapDeleteByIndex } from "../../WasmHeap";

export function wgpuTextureViewRelease(textureHeapIndex: bigint) {
	heapDeleteByIndex(textureHeapIndex);
	// const textureView = heapGet<GPUTextureView>(textureHeapIndex);
	// if (textureView instanceof GPUTextureView) {

	// } else {
	// 	console.error(
	// 		`wgpuTextureViewRelease: not a texture view at index ${textureHeapIndex}`
	// 	);
	// }
}


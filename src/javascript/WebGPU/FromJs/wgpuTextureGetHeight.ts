import { heapGet } from "../../WasmHeap";

export function wgpuTextureGetHeight(heapIndex: bigint) {
	const texture = heapGet<GPUTexture>(heapIndex)!;
	return texture.height;
}


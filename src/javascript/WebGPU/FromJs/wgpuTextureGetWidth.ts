import { heapGet } from "../../WasmHeap";

export function wgpuTextureGetWidth(heapIndex: bigint): number {
	const texture = heapGet<GPUTexture>(heapIndex)!;
	return texture.width;
}


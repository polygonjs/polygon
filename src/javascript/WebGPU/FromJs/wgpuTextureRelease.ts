import { heapDeleteByIndex, heapGet } from "../../WasmHeap";

export function wgpuTextureRelease(index: bigint) {
	const texture = heapGet<GPUTexture>(index);
	texture?.destroy();
	heapDeleteByIndex(index);
}


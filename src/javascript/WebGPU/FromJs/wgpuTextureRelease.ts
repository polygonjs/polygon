import { heapDelete, heapGet } from "../../WasmHeap";

export function wgpuTextureRelease(pointer: bigint) {
	const texture = heapGet<GPUTexture>(pointer);
	texture?.destroy();
	heapDelete(pointer);
}

import { heapDeleteByIndex } from "../../WasmHeap";

export function wgpuTextureViewRelease(textureHeapIndex: bigint) {
	heapDeleteByIndex(textureHeapIndex);
}


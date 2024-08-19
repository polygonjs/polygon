import { heapDeleteByIndex } from "../../WasmHeap";

export function wgpuRenderPassEncoderRelease(index: bigint) {
	heapDeleteByIndex(index);
}


import { heapDeleteByIndex } from "../../WasmHeap";

export function wgpuRenderPipelineRelease(index: bigint) {
	heapDeleteByIndex(index);
}


import { heapDelete } from "../../WasmHeap";

export function wgpuRenderPipelineRelease(pipelineHeapIndex: bigint) {
	heapDelete(pipelineHeapIndex);
}

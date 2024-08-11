import { heapDelete } from "../../WasmHeap";

export function wgpuBindGroupLayoutRelease(pointer: bigint) {
	heapDelete(pointer);
}

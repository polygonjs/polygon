import { heapDelete } from "../../WasmHeap";

export function wgpuBindGroupRelease(pointer: bigint) {
	heapDelete(pointer);
}

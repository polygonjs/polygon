import { heapGet } from "../../WasmHeap";

export function wgpuBufferGetMapState(bufferHeapIndex: bigint) {
	const buffer = heapGet<GPUBuffer>(bufferHeapIndex)!;
	switch (buffer.mapState) {
		case "mapped": {
			return 2;
		}
		case "pending": {
			return 1;
		}
		case "unmapped": {
			return 0;
		}
	}
	return 0;
}


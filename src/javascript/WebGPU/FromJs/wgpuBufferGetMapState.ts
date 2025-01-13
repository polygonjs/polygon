import { heapGet } from "../../WasmHeap";
import { gpuMappedStateToWGPU } from "../utils/WebGPUCommon";

export function wgpuBufferGetMapState(bufferHeapIndex: bigint) {
	const buffer = heapGet<GPUBuffer>(bufferHeapIndex)!;
	return gpuMappedStateToWGPU(buffer.mapState);
}


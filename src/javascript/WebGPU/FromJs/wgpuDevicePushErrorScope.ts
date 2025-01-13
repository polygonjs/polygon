import { heapAdd, heapGet } from "../../WasmHeap";
import { wgpuErrorScopeFilterToGPU } from "../utils/WebGPUCommon";

export function wgpuDevicePushErrorScope(
	deviceHeapIndex: bigint,
	filter: bigint
) {
	const device = heapGet<GPUDevice>(deviceHeapIndex)!;
	const gpufilter = wgpuErrorScopeFilterToGPU(filter);
	const queue = device.pushErrorScope(gpufilter);
	return heapAdd(queue);
}


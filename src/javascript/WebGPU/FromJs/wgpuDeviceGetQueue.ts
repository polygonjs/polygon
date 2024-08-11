import { heapAdd, heapGet } from "../../WasmHeap";

export function wgpuDeviceGetQueue(deviceHeapIndex: bigint) {
	const device = heapGet<GPUDevice>(deviceHeapIndex)!;
	const queue = device.queue;
	return heapAdd(queue);
}

import { heapAdd, heapGet } from "../../WasmHeap";
import { WGPUBufferDescriptorFromBuffer } from "../FromBuffer/WGPUBufferDescriptor";

export function wgpuDeviceCreateBuffer(
	deviceHeadIndex: bigint,
	descriptorPointer: bigint
) {
	const device = heapGet<GPUDevice>(deviceHeadIndex)!;
	const descriptor = WGPUBufferDescriptorFromBuffer(descriptorPointer);
	const buffer = device.createBuffer(descriptor);
	const bufferHeapIndex = heapAdd(buffer);
	return bufferHeapIndex;
}


import { heapAdd, heapGet } from "../../WasmHeap";
import { WGPUBindGroupDescriptorFromBuffer } from "../FromBuffer/WGPUBindGroupDescriptor";

export function wgpuDeviceCreateBindGroup(
	deviceHeadIndex: bigint,
	descriptorPointer: bigint
) {
	const device = heapGet<GPUDevice>(deviceHeadIndex)!;
	const descriptor = WGPUBindGroupDescriptorFromBuffer(descriptorPointer);
	const bindGroup = device.createBindGroup(descriptor);
	return heapAdd(bindGroup);
}


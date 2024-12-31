import { heapAdd, heapGet } from "../../WasmHeap";
import { WGPUBindGroupLayoutDescriptorFromBuffer } from "../FromBuffer/WGPUBindGroupLayoutDescriptor";

export function wgpuDeviceCreateBindGroupLayout(
	deviceHeapIndex: bigint,
	descriptorPointer: bigint
) {
	const device = heapGet<GPUDevice>(deviceHeapIndex)!;
	const desc = WGPUBindGroupLayoutDescriptorFromBuffer(descriptorPointer);

	const bindGroupLayout = device.createBindGroupLayout(desc);
	return heapAdd(bindGroupLayout);
}


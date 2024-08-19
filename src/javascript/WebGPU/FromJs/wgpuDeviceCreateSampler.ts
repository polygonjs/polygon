import { heapAdd, heapGet } from "../../WasmHeap";
import { WGPUSamplerDescriptorFromBuffer } from "../FromBuffer/WGPUSamplerDescriptor";

export function wgpuDeviceCreateSampler(
	deviceHeapIndex: bigint,
	descriptorHeapIndex: bigint
) {
	const device = heapGet<GPUDevice>(deviceHeapIndex)!;
	const descriptor = WGPUSamplerDescriptorFromBuffer(descriptorHeapIndex);
	const sampler = device.createSampler(descriptor);
	return heapAdd(sampler);
}


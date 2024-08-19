import { heapAdd, heapGet } from "../../WasmHeap";
import { WGPUShaderModuleDescriptorFromBuffer } from "../FromBuffer/WGPUShaderModuleDescriptor";

export function wgpuDeviceCreateShaderModule(
	deviceHeapIndex: bigint,
	descriptorPointer: bigint
) {
	const device = heapGet<GPUDevice>(deviceHeapIndex)!;
	const descriptor = WGPUShaderModuleDescriptorFromBuffer(descriptorPointer);
	const shaderModule = device.createShaderModule(descriptor);
	return heapAdd(shaderModule);
}


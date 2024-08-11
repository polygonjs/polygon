import { heapAdd, heapGet } from "../../WasmHeap";
import { WGPUShaderModuleDescriptorFromBuffer } from "../FromBuffer/WGPUShaderModuleDescriptor";

export function wgpuDeviceCreateShaderModule(
	deviceHeapIndex: bigint,
	descriptorPointer: bigint
) {
	const device = heapGet<GPUDevice>(deviceHeapIndex)!;
	const descriptor = WGPUShaderModuleDescriptorFromBuffer(descriptorPointer);
	// console.log("wgpuDeviceCreateShaderModule", descriptor);
	const shaderModule = device.createShaderModule(descriptor);
	return heapAdd(shaderModule);
}

import { heapAdd, heapGet } from "../../WasmHeap";
import { WGPUComputePipelineDescriptorFromBuffer } from "../FromBuffer/WGPUComputePipelineDescriptor";

export function wgpuDeviceCreateComputePipeline(
	deviceHeapIndex: bigint,
	descriptorPointer: bigint
) {
	const device = heapGet<GPUDevice>(deviceHeapIndex)!;
	const descriptor =
		WGPUComputePipelineDescriptorFromBuffer(descriptorPointer);
	const pipeline = device.createComputePipeline(descriptor);
	return heapAdd(pipeline);
}


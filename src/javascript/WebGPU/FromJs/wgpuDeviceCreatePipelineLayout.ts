import { heapAdd, heapGet } from "../../WasmHeap";
import { WGPUPipelineLayoutDescriptorFromBuffer } from "../FromBuffer/WGPUPipelineLayoutDescriptor";

export function wgpuDeviceCreatePipelineLayout(
	deviceHeapIndex: bigint,
	descriptorPointer: bigint
) {
	const device = heapGet<GPUDevice>(deviceHeapIndex)!;
	const pipelineLayoutDescriptor =
		WGPUPipelineLayoutDescriptorFromBuffer(descriptorPointer);
	const pipelineLayout = device.createPipelineLayout(
		pipelineLayoutDescriptor
	);
	return heapAdd(pipelineLayout);
}

import { heapAdd, heapGet } from "../../WasmHeap";
import { WGPURenderPipelineDescriptorFromBuffer } from "../FromBuffer/WGPURenderPipelineDescriptor";

export function wgpuDeviceCreateRenderPipeline(
	deviceHeapIndex: bigint,
	descriptorPointer: bigint
) {
	const device = heapGet<GPUDevice>(deviceHeapIndex)!;
	const descriptor =
		WGPURenderPipelineDescriptorFromBuffer(descriptorPointer);
	// console.log("wgpuDeviceCreateRenderPipeline", descriptor);
	const pipeline = device.createRenderPipeline(descriptor);
	return heapAdd(pipeline);
}

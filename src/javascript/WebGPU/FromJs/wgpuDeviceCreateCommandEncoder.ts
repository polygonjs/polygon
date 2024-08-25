import { heapAdd, heapGet } from "../../WasmHeap";
import { WGPUCommandEncoderDescriptorFromBuffer } from "../FromBuffer/WGPUCommandEncoderDescriptor";

export function wgpuDeviceCreateCommandEncoder(
	deviceHeadIndex: bigint,
	descriptorPointer: bigint
) {
	const device = heapGet<GPUDevice>(deviceHeadIndex)!;

	const descriptor =
		WGPUCommandEncoderDescriptorFromBuffer(descriptorPointer);
	const encoder = device.createCommandEncoder(descriptor);
	return heapAdd(encoder);
}


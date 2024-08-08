import { heapAdd, heapGet } from "../../WasmHeap";
import { WGPUCommandEncoderDescriptorFromBuffer } from "../FromBuffer/WGPUCommandEncoderDescriptor";

export function wgpuDeviceCreateCommandEncoder(
	deviceHeadIndex: bigint,
	descriptorPointer: bigint
) {
	const buffer = window.ALLOCATED_MEMORY_CONTAINER.allocatedMemory!.buffer;
	const u64 = new BigUint64Array(buffer);
	const device = heapGet<GPUDevice>(deviceHeadIndex)!;

	const descriptor = WGPUCommandEncoderDescriptorFromBuffer(
		descriptorPointer,
		u64
	);
	const encoder = device.createCommandEncoder(descriptor);
	return heapAdd(encoder);
}

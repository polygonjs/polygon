import { heapAdd, heapGet } from "../../WasmHeap";
import { WGPUTextureDescriptorFromBuffer } from "../FromBuffer/WGPUTextureDescriptor";

export function wgpuDeviceCreateTexture(
	deviceHeapIndex: bigint,
	descPointer: bigint
) {
	const device = heapGet<GPUDevice>(deviceHeapIndex)!;
	const descriptor = WGPUTextureDescriptorFromBuffer(descPointer);
	const texture = device.createTexture(descriptor);
	return heapAdd(texture);
}


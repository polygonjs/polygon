import { heapAdd, heapGet } from "../../WasmHeap";
import { WGPUTextureDescriptorFromPointer } from "../FromBuffer/WGPUTextureDescriptor";

export function wgpuDeviceCreateTexture(
	deviceHeapIndex: bigint,
	descPointer: bigint
) {
	const device = heapGet<GPUDevice>(deviceHeapIndex)!;
	const descriptor = WGPUTextureDescriptorFromPointer(descPointer);
	const texture = device.createTexture(descriptor);
	return heapAdd(texture);
}

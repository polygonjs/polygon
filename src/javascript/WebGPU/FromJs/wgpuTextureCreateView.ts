import { heapAdd, heapGet } from "../../WasmHeap";
import { WGPUTextureViewDescriptorFromBuffer } from "../FromBuffer/WGPUTextureViewDescriptor";

export function wgpuTextureCreateView(
	texturePointer: bigint,
	descriptorPointer: bigint
) {
	const texture = heapGet<GPUTexture>(texturePointer);
	if (!texture) {
		throw new Error("wgpuTextureCreateView: texture is null");
	}
	const desc = WGPUTextureViewDescriptorFromBuffer(descriptorPointer);
	const textureView = texture.createView(desc);
	return heapAdd(textureView);
}

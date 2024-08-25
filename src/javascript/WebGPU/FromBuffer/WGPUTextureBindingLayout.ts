import {
	textureSampleTypeIntToGPUTextureSampleType,
	textureViewDimentionIntToGPUTextureViewDimension,
} from "../utils/WebGPUMap";
import { WGPU_OFFSET } from "../utils/WebGPUOffset";
import { u32Create } from "../utils/WebGPUUtils";

export function WGPUTextureBindingLayoutFromBuffer(
	pointer: bigint
): GPUTextureBindingLayout | undefined {
	const buffer = window.ALLOCATED_MEMORY_CONTAINER.allocatedMemory!.buffer;
	const u32 = new Uint32Array(buffer);
	const _u32 = u32Create(u32, pointer);
	//
	const offset = WGPU_OFFSET.WGPUTextureBindingLayout;
	//
	const sampleType = textureSampleTypeIntToGPUTextureSampleType(
		_u32(offset.sampleType)
	);
	if (sampleType == null) {
		return;
	}
	const viewDimension = textureViewDimentionIntToGPUTextureViewDimension(
		_u32(offset.viewDimension)
	);
	const multisampled = _u32(offset.multisampled) > 0;

	const layout: GPUTextureBindingLayout = {
		sampleType,
		viewDimension,
		multisampled,
	};
	return layout;
}


import {
	textureAspectIntToGPUTextureAspect,
	textureFormatIntToGPUTextureFormat,
	textureViewDimentionIntToGPUTextureViewDimension,
} from "../utils/WebGPUMap";
import { WGPU_OFFSET } from "../utils/WebGPUOffset";
import { labelFromBuffer, u32Create } from "../utils/WebGPUUtils";

export function WGPUTextureViewDescriptorFromBuffer(
	pointer: bigint
): GPUTextureViewDescriptor {
	const buffer = window.ALLOCATED_MEMORY_CONTAINER.allocatedMemory!.buffer;
	const u32 = new Uint32Array(buffer);
	const u64 = new BigUint64Array(buffer);
	const _u32 = u32Create(u32, pointer);
	// ;
	const offset = WGPU_OFFSET.WGPUTextureViewDescriptor;
	//
	const label = labelFromBuffer(pointer, offset, u64);
	//
	const formatb = _u32(offset.format);
	const format = textureFormatIntToGPUTextureFormat(formatb);
	//
	const dimensionb = _u32(offset.dimension);
	const dimension =
		textureViewDimentionIntToGPUTextureViewDimension(dimensionb);
	//
	const baseMipLevel = _u32(offset.baseMipLevel);
	const mipLevelCount = _u32(offset.mipLevelCount);
	const baseArrayLayer = _u32(offset.baseArrayLayer);
	const arrayLayerCount = _u32(offset.arrayLayerCount);
	//
	const aspectb = _u32(offset.aspect);
	const aspect = textureAspectIntToGPUTextureAspect(aspectb);

	const desc: GPUTextureViewDescriptor = {
		label,
		format,
		dimension,
		baseMipLevel,
		mipLevelCount,
		baseArrayLayer,
		arrayLayerCount,
		aspect,
	};
	return desc;
}


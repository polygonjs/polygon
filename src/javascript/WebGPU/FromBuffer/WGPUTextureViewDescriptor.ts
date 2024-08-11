import {
	textureAspectIntToGPUTextureAspect,
	textureFormatIntToGPUTextureFormat,
	textureViewDimentionIntToGPUTextureViewDimension,
} from "../utils/WebGPUMap";
import { WGPU_OFFSET, WGPU_SIZE } from "../utils/WebGPUOffset";
import { labelFromBuffer } from "../utils/WebGPUUtils";

export function WGPUTextureViewDescriptorFromBuffer(
	pointer: bigint
): GPUTextureViewDescriptor {
	const buffer = window.ALLOCATED_MEMORY_CONTAINER.allocatedMemory!.buffer;
	const u32 = new Uint32Array(buffer);
	const u64 = new BigUint64Array(buffer);
	// const pointer = Number(pointerb);
	const offset = WGPU_OFFSET.WGPUTextureViewDescriptor;
	//
	const label = labelFromBuffer(pointer, offset, u64);
	//
	const formatOffset = offset.format;
	const formatSize = WGPU_SIZE.u32;
	const formatStart = (pointer + formatOffset) / formatSize;
	const formatb = u32[Number(formatStart)];
	const format = textureFormatIntToGPUTextureFormat(formatb);
	//
	const dimensionOffset = offset.dimension;
	const dimensionSize = WGPU_SIZE.u32;
	const dimensionStart = (pointer + dimensionOffset) / dimensionSize;
	const dimensionb = u32[Number(dimensionStart)];
	const dimension =
		textureViewDimentionIntToGPUTextureViewDimension(dimensionb);
	//
	const baseMipLevelOffset = offset.baseMipLevel;
	const baseMipLevelSize = WGPU_SIZE.u32;
	const baseMipLevelStart = (pointer + baseMipLevelOffset) / baseMipLevelSize;
	const baseMipLevel = u32[Number(baseMipLevelStart)];
	//
	const mipLevelCountOffset = offset.mipLevelCount;
	const mipLevelCountSize = WGPU_SIZE.u32;
	const mipLevelCountStart =
		(pointer + mipLevelCountOffset) / mipLevelCountSize;
	const mipLevelCount = u32[Number(mipLevelCountStart)];
	//
	const baseArrayLayerOffset = offset.baseArrayLayer;
	const baseArrayLayerSize = WGPU_SIZE.u32;
	const baseArrayLayerStart =
		(pointer + baseArrayLayerOffset) / baseArrayLayerSize;
	const baseArrayLayer = u32[Number(baseArrayLayerStart)];
	//
	const arrayLayerCountOffset = offset.arrayLayerCount;
	const arrayLayerCountSize = WGPU_SIZE.u32;
	const arrayLayerCountStart =
		(pointer + arrayLayerCountOffset) / arrayLayerCountSize;
	const arrayLayerCount = u32[Number(arrayLayerCountStart)];
	//
	const aspectOffset = offset.aspect;
	const aspectSize = WGPU_SIZE.u32;
	const aspectStart = (pointer + aspectOffset) / aspectSize;
	const aspectb = u32[Number(aspectStart)];
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

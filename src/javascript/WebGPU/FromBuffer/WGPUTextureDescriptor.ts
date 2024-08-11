import {
	textureDimensionIntToGPUTextureDimension,
	textureFormatIntToGPUTextureFormat,
} from "../utils/WebGPUMap";
import { WGPU_OFFSET, WGPU_SIZE } from "../utils/WebGPUOffset";
import {
	createWGPUItemsByPointer,
	labelFromBuffer,
	u32Create,
	u64Create,
} from "../utils/WebGPUUtils";
import { WGPUExtent3DFromBuffer } from "./WGPUExtent3D";

export function WGPUTextureDescriptorFromPointer(
	pointer: bigint
): GPUTextureDescriptor {
	const buffer = window.ALLOCATED_MEMORY_CONTAINER.allocatedMemory!.buffer;
	// const pointer = Number(pointerb);
	const offset = WGPU_OFFSET.WGPUTextureDescriptor;
	// const u8 = new Uint8Array(buffer);
	const u32 = new Uint32Array(buffer);
	const u64 = new BigUint64Array(buffer);
	const _u32 = u32Create(u32, pointer);
	const _u64 = u64Create(u64, pointer);

	const label = labelFromBuffer(pointer, offset, u64);
	//
	// const usageOffset = offset.usage;
	// const usageSize = WGPU_SIZE.u32;
	// const usageStart = (pointer + usageOffset) / usageSize;
	// const usageb = u64[Number(usageStart)];
	const usage = _u32(offset.usage); //Number(usageb);
	//
	const dimensionOffset = offset.dimension;
	const dimensionSize = WGPU_SIZE.u32;
	const dimensionStart = (pointer + dimensionOffset) / dimensionSize;
	const dimensionb = u64[Number(dimensionStart)];
	const dimension = textureDimensionIntToGPUTextureDimension(
		Number(dimensionb)
	);
	//
	const size = WGPUExtent3DFromBuffer(pointer + offset.size);
	//
	// const formatOffset = offset.format;
	// const formatSize = WGPU_SIZE.u32;
	// const formatStart = (pointer + formatOffset) / formatSize;
	const formatb = _u32(offset.format); // u32[Number(formatStart)];
	const format = textureFormatIntToGPUTextureFormat(formatb);
	//
	const mipLevelCount = _u32(offset.mipLevelCount);
	const sampleCount = _u32(offset.sampleCount);
	const viewFormatCount = _u64(offset.viewFormatCount);

	const viewFormats = createWGPUItemsByPointer<GPUTextureFormat>({
		u64,
		pointer,
		arrayOffset: offset.viewFormats,
		itemsCount: viewFormatCount,
		itemSize: WGPU_SIZE.WGPUTextureFormat,
		callback: (itemPointer) => {
			const itemFormatb = u32[Number(itemPointer)];
			const itemFormat = textureFormatIntToGPUTextureFormat(itemFormatb);
			return itemFormat;
		},
	});

	const desc: GPUTextureDescriptor = {
		label,
		usage,
		dimension,
		size,
		format,
		mipLevelCount,
		sampleCount,
		viewFormats,
	};
	return desc;
}

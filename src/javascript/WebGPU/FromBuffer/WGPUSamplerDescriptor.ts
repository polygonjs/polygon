import {
	addressModeIntToGPUAddressMode,
	compareFunctionIntToGPUCompareFunction,
	filterModeIntToGPUFilterMode,
	mipmapFilterModeIntToGPUMipmapFilterMode,
} from "../utils/WebGPUMap";
import { WGPU_OFFSET } from "../utils/WebGPUOffset";
import { labelFromBuffer, u16Create, u32Create } from "../utils/WebGPUUtils";

export function WGPUSamplerDescriptorFromBuffer(
	pointer: bigint
): GPUSamplerDescriptor {
	const buffer = window.ALLOCATED_MEMORY_CONTAINER.allocatedMemory!.buffer;
	const u16 = new Uint16Array(buffer);
	const u32 = new Uint32Array(buffer);
	const u64 = new BigUint64Array(buffer);
	const offset = WGPU_OFFSET.WGPUSamplerDescriptor;
	const _u32 = u32Create(u32, pointer);
	const _u16 = u16Create(u16, pointer);

	//
	const label = labelFromBuffer(pointer, offset, u64);
	const addressModeU = addressModeIntToGPUAddressMode(
		_u32(offset.addressModeU)
	);
	const addressModeV = addressModeIntToGPUAddressMode(
		_u32(offset.addressModeV)
	);
	const addressModeW = addressModeIntToGPUAddressMode(
		_u32(offset.addressModeW)
	);
	const magFilter = filterModeIntToGPUFilterMode(_u32(offset.magFilter));
	const minFilter = filterModeIntToGPUFilterMode(_u32(offset.minFilter));
	const mipmapFilter = mipmapFilterModeIntToGPUMipmapFilterMode(
		_u32(offset.mipmapFilter)
	);
	const lodMinClamp = _u32(offset.lodMinClamp);
	const lodMaxClamp = _u32(offset.lodMaxClamp);
	const compare = compareFunctionIntToGPUCompareFunction(
		_u32(offset.compare)
	);
	const maxAnisotropy = _u16(offset.maxAnisotropy);

	const sampler: GPUSamplerDescriptor = {
		label,
		addressModeU,
		addressModeV,
		addressModeW,
		magFilter,
		minFilter,
		mipmapFilter,
		lodMinClamp,
		lodMaxClamp,
		compare,
		maxAnisotropy,
	};

	return sampler;
}

import {
	addressModeIntToGPUAddressMode,
	compareFunctionIntToGPUCompareFunction,
	filterModeIntToGPUFilterMode,
	mipmapFilterModeIntToGPUMipmapFilterMode,
} from "../utils/WebGPUMap";
import { _label, _num } from "../utils/WebGPUUtils";
import { WGPUSamplerDescriptor } from "../utils/WGPUStructInfos";

export function WGPUSamplerDescriptorFromBuffer(
	p: bigint
): GPUSamplerDescriptor {
	const m = WGPUSamplerDescriptor.members;

	//
	const label = _label(p, m);
	const addressModeU = addressModeIntToGPUAddressMode(
		_num(p, m.addressModeU)
	);
	const addressModeV = addressModeIntToGPUAddressMode(
		_num(p, m.addressModeV)
	);
	const addressModeW = addressModeIntToGPUAddressMode(
		_num(p, m.addressModeW)
	);
	const magFilter = filterModeIntToGPUFilterMode(_num(p, m.magFilter));
	const minFilter = filterModeIntToGPUFilterMode(_num(p, m.minFilter));
	const mipmapFilter = mipmapFilterModeIntToGPUMipmapFilterMode(
		_num(p, m.mipmapFilter)
	);
	const lodMinClamp = _num(p, m.lodMinClamp);
	const lodMaxClamp = _num(p, m.lodMaxClamp);
	const compare = compareFunctionIntToGPUCompareFunction(_num(p, m.compare));
	const maxAnisotropy = _num(p, m.maxAnisotropy);

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


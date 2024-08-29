import {
	textureAspectIntToGPUTextureAspect,
	textureFormatIntToGPUTextureFormat,
	textureViewDimentionIntToGPUTextureViewDimension,
} from "../utils/WebGPUMap";
import { _label, _num } from "../utils/WebGPUUtils";
import { WGPUTextureViewDescriptor } from "../utils/WGPUStructInfos";

export function WGPUTextureViewDescriptorFromBuffer(
	p: bigint
): GPUTextureViewDescriptor {
	const m = WGPUTextureViewDescriptor.members;
	//
	const label = _label(p, m);
	//
	const formatb = _num(p, m.format);
	const format = textureFormatIntToGPUTextureFormat(formatb);
	//
	const dimensionb = _num(p, m.dimension);
	const dimension =
		textureViewDimentionIntToGPUTextureViewDimension(dimensionb);
	//
	const baseMipLevel = _num(p, m.baseMipLevel);
	const mipLevelCount = _num(p, m.mipLevelCount);
	const baseArrayLayer = _num(p, m.baseArrayLayer);
	const arrayLayerCount = _num(p, m.arrayLayerCount);
	//
	const aspectb = _num(p, m.aspect);
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


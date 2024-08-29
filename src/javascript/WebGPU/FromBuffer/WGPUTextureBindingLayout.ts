import {
	textureSampleTypeIntToGPUTextureSampleType,
	textureViewDimentionIntToGPUTextureViewDimension,
} from "../utils/WebGPUMap";
import { _num } from "../utils/WebGPUUtils";
import { WGPUTextureBindingLayout } from "../utils/WGPUStructInfos";

export function WGPUTextureBindingLayoutFromBuffer(
	p: bigint
): GPUTextureBindingLayout | undefined {
	const m = WGPUTextureBindingLayout.members;
	//
	const sampleType = textureSampleTypeIntToGPUTextureSampleType(
		_num(p, m.sampleType)
	);
	if (sampleType == null) {
		return;
	}
	const viewDimension = textureViewDimentionIntToGPUTextureViewDimension(
		_num(p, m.viewDimension)
	);
	const multisampled = _num(p, m.multisampled) > 0;

	const layout: GPUTextureBindingLayout = {
		sampleType,
		viewDimension,
		multisampled,
	};
	return layout;
}


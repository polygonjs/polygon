import { samplerBindingTypeIntToGPUSamplerBindingType } from "../utils/WebGPUMap";
import { _num } from "../utils/WebGPUUtils";
import { WGPUSamplerBindingLayout } from "../utils/WGPUStructInfos";

export function WGPUSamplerBindingLayoutFromBuffer(
	p: bigint
): GPUSamplerBindingLayout | undefined {
	const m = WGPUSamplerBindingLayout.members;
	//
	const type = samplerBindingTypeIntToGPUSamplerBindingType(_num(p, m.type));
	if (type == null) {
		return;
	}

	const layout: GPUSamplerBindingLayout = {
		type,
	};
	return layout;
}


import { samplerBindingTypeIntToGPUSamplerBindingType } from "../utils/WebGPUMap";
import { _num } from "../../wasm/WasmUtils";
import { WGPUSamplerBindingLayout } from "../utils/WGPUStructInfos";

export function WGPUSamplerBindingLayoutFromBuffer(
	p: bigint
): GPUSamplerBindingLayout | undefined {
	const m = WGPUSamplerBindingLayout.members;
	//
	const type = samplerBindingTypeIntToGPUSamplerBindingType(_num(p, m.type));

	const layout: GPUSamplerBindingLayout = {
		type,
	};
	return layout;
}


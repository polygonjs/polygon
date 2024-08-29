import { textureFormatIntToGPUTextureFormat } from "../utils/WebGPUMap";
import { _big, _num } from "../utils/WebGPUUtils";
import { WGPUColorTargetState } from "../utils/WGPUStructInfos";
import { WGPUBlendStateFromBuffer } from "./WGPUBlendState";

export function WGPUColorTargetStateFromBuffer(p: bigint): GPUColorTargetState {
	const m = WGPUColorTargetState.members;
	//
	const formatb = _num(p, m.format);
	const format = textureFormatIntToGPUTextureFormat(formatb);
	//
	const blendPointer = _big(p, m.blend);
	const blend = WGPUBlendStateFromBuffer(blendPointer);
	//
	const writeMask = _num(p, m.writeMask);
	//
	const target: GPUColorTargetState = {
		format,
		blend,
		writeMask,
	};
	return target;
}


import { WGPUBlendState } from "../utils/WGPUStructInfos";
import { WGPUBlendComponentFromBuffer } from "./WGPUBlendComponent";

export function WGPUBlendStateFromBuffer(pointer: bigint): GPUBlendState {
	const m = WGPUBlendState.members;
	//
	const color = WGPUBlendComponentFromBuffer(pointer + m.color.offset);
	const alpha = WGPUBlendComponentFromBuffer(pointer + m.alpha.offset);
	//
	const blendState: GPUBlendState = { color, alpha };
	return blendState;
}


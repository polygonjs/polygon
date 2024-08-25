import { WGPU_OFFSET } from "../utils/WebGPUOffset";
import { WGPUBlendComponentFromBuffer } from "./WGPUBlendComponent";

export function WGPUBlendStateFromBuffer(pointer: bigint): GPUBlendState {
	const offset = WGPU_OFFSET.WGPUBlendState;
	//
	const color = WGPUBlendComponentFromBuffer(pointer + offset.color);
	const alpha = WGPUBlendComponentFromBuffer(pointer + offset.alpha);
	//
	const blendState: GPUBlendState = { color, alpha };
	return blendState;
}


import { WGPU_OFFSET } from "../utils/WebGPUOffset";
import { WGPUBlendComponentFromBuffer } from "./WGPUBlendComponent";

export function WGPUBlendStateFromBuffer(
	pointer: bigint,
	u32: Uint32Array
): GPUBlendState {
	const offset = WGPU_OFFSET.WGPUBlendState;
	//
	const color = WGPUBlendComponentFromBuffer(pointer + offset.color, u32);
	const alpha = WGPUBlendComponentFromBuffer(pointer + offset.alpha, u32);
	//
	const blendState: GPUBlendState = { color, alpha };
	return blendState;
}

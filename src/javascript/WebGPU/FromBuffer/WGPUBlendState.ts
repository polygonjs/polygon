import { WGPU_OFFSET } from "../utils/WebGPUOffset";
import { WGPUBlendComponentFromBuffer } from "./WGPUBlendComponent";

export function WGPUBlendStateFromBuffer(pointer: bigint): GPUBlendState {
	const buffer = window.ALLOCATED_MEMORY_CONTAINER.allocatedMemory!.buffer;
	const u32 = new Uint32Array(buffer);
	const offset = WGPU_OFFSET.WGPUBlendState;
	//
	const color = WGPUBlendComponentFromBuffer(pointer + offset.color, u32);
	const alpha = WGPUBlendComponentFromBuffer(pointer + offset.alpha, u32);
	//
	const blendState: GPUBlendState = { color, alpha };
	return blendState;
}


import { textureFormatIntToGPUTextureFormat } from "../utils/WebGPUMap";
import { WGPU_OFFSET, WGPU_SIZE } from "../utils/WebGPUOffset";
import { u32Create, u64Create } from "../utils/WebGPUUtils";
import { WGPUBlendStateFromBuffer } from "./WGPUBlendState";

export function WGPUColorTargetStateFromBuffer(
	pointer: bigint
): GPUColorTargetState {
	const buffer = window.ALLOCATED_MEMORY_CONTAINER.allocatedMemory!.buffer;
	const u32 = new Uint32Array(buffer);
	const u64 = new BigUint64Array(buffer);
	const _u32 = u32Create(u32, pointer);
	const _u64 = u64Create(u64, pointer); //
	const offset = WGPU_OFFSET.WGPUColorTargetState;
	//
	//
	const formatb = _u32(offset.format);
	const format = textureFormatIntToGPUTextureFormat(formatb);
	//
	const blendPointer = _u64(offset.blend);
	const blend = WGPUBlendStateFromBuffer(blendPointer);
	//
	const writeMaskOffset = offset.writeMask;
	const writeMaskSize = WGPU_SIZE.u32;
	const writeMaskStart = (pointer + writeMaskOffset) / writeMaskSize;
	const writeMask = u32[Number(writeMaskStart)];
	//
	const target: GPUColorTargetState = {
		format,
		blend,
		writeMask,
	};
	return target;
}


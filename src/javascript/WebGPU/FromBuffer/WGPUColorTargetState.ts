import { textureFormatIntToGPUTextureFormat } from "../utils/WebGPUMap";
import { WGPU_OFFSET, WGPU_SIZE } from "../utils/WebGPUOffset";
import { WGPUBlendStateFromBuffer } from "./WGPUBlendState";

export function WGPUColorTargetStateFromBuffer(
	pointer: bigint,
	u32: Uint32Array,
	u64: BigUint64Array
): GPUColorTargetState {
	const offset = WGPU_OFFSET.WGPUColorTargetState;
	//
	//
	const formatOffset = offset.format;
	const formatSize = WGPU_SIZE.u32;
	const formatStart = (pointer + formatOffset) / formatSize;
	const formatb = u32[Number(formatStart)];
	const format = textureFormatIntToGPUTextureFormat(formatb);
	//
	const blendPointerOffset = offset.blend;
	const blendPointerSize = WGPU_SIZE.u64;
	const blendPointerStart = (pointer + blendPointerOffset) / blendPointerSize;
	const blendPointer = u64[Number(blendPointerStart)];
	const blend = WGPUBlendStateFromBuffer(blendPointer, u32);
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

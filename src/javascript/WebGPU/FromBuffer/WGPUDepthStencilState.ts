import {
	compareFunctionIntToGPUCompareFunction,
	textureFormatIntToGPUTextureFormat,
} from "../utils/WebGPUMap";
import { WGPU_OFFSET } from "../utils/WebGPUOffset";
import { f32Create, s32Create, u32Create } from "../utils/WebGPUUtils";
import { WGPUStencilFaceStateFromBuffer } from "./WGPUStencilFaceState";

export function WGPUDepthStencilStateFromBuffer(
	pointer: bigint
): GPUDepthStencilState {
	const buffer = window.ALLOCATED_MEMORY_CONTAINER.allocatedMemory!.buffer;
	const u32 = new Uint32Array(buffer);
	const s32 = new Int32Array(buffer);
	const f32 = new Float32Array(buffer);
	const _u32 = u32Create(u32, pointer);
	const _s32 = s32Create(s32, pointer);
	const _f32 = f32Create(f32, pointer);
	//
	const offset = WGPU_OFFSET.WGPUDepthStencilState;

	//
	const formatb = _u32(offset.format);
	const format = textureFormatIntToGPUTextureFormat(formatb);
	//
	const depthWriteEnabledb = _u32(offset.depthWriteEnabled);
	const depthWriteEnabled = Boolean(depthWriteEnabledb);
	//
	const depthCompareb = _u32(offset.depthCompare);
	const depthCompare = compareFunctionIntToGPUCompareFunction(depthCompareb);
	//

	const stencilFront = WGPUStencilFaceStateFromBuffer(
		pointer + offset.stencilFront
	);
	const stencilBack = WGPUStencilFaceStateFromBuffer(
		pointer + offset.stencilBack
	);
	//
	const stencilReadMask = _u32(offset.stencilReadMask);
	const stencilWriteMask = _u32(offset.stencilWriteMask);
	const depthBias = _s32(offset.depthBias);
	const depthBiasSlopeScale = _f32(offset.depthBiasSlopeScale);
	const depthBiasClamp = _f32(offset.depthBiasClamp);

	//
	const depthStencilState: GPUDepthStencilState = {
		format,
		depthWriteEnabled,
		depthCompare,
		stencilFront,
		stencilBack,
		stencilReadMask,
		stencilWriteMask,
		depthBias,
		depthBiasSlopeScale,
		depthBiasClamp,
	};
	return depthStencilState;
}


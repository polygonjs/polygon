import {
	compareFunctionIntToGPUCompareFunction,
	textureFormatIntToGPUTextureFormat,
} from "../utils/WebGPUMap";
import { WGPU_OFFSET, WGPU_SIZE } from "../utils/WebGPUOffset";
import { WGPUStencilFaceStateFromBuffer } from "./WGPUStencilFaceState";

export function WGPUDepthStencilStateFromBuffer(
	pointer: bigint,
	u32: Uint32Array
): GPUDepthStencilState {
	const offset = WGPU_OFFSET.WGPUDepthStencilState;
	const buffer = window.ALLOCATED_MEMORY_CONTAINER.allocatedMemory!.buffer;
	const f32 = new Float32Array(buffer);
	//
	const formatOffset = offset.format;
	const formatSize = WGPU_SIZE.u32;
	const formatStart = (pointer + formatOffset) / formatSize;
	const formatb = u32[Number(formatStart)];
	const format = textureFormatIntToGPUTextureFormat(formatb);
	//
	const depthWriteEnabledOffset = offset.depthWriteEnabled;
	const depthWriteEnabledSize = WGPU_SIZE.u32;
	const depthWriteEnabledStart =
		(pointer + depthWriteEnabledOffset) / depthWriteEnabledSize;
	const depthWriteEnabledb = u32[Number(depthWriteEnabledStart)];
	const depthWriteEnabled = Boolean(depthWriteEnabledb);
	//
	const depthCompareOffset = offset.depthCompare;
	const depthCompareSize = WGPU_SIZE.u32;
	const depthCompareStart = (pointer + depthCompareOffset) / depthCompareSize;
	const depthCompareb = u32[Number(depthCompareStart)];
	const depthCompare = compareFunctionIntToGPUCompareFunction(depthCompareb);
	//
	function stencilFaceState(b: bigint): GPUStencilFaceState {
		return WGPUStencilFaceStateFromBuffer(b, u32);
	}
	const stencilFront = stencilFaceState(pointer + offset.stencilFront);
	const stencilBack = stencilFaceState(pointer + offset.stencilBack);
	//
	const stencilReadMaskOffset = offset.stencilReadMask;
	const stencilReadMaskSize = WGPU_SIZE.u32;
	const stencilReadMaskStart =
		(pointer + stencilReadMaskOffset) / stencilReadMaskSize;
	const stencilReadMask = u32[Number(stencilReadMaskStart)];
	//
	const stencilWriteMaskOffset = offset.stencilWriteMask;
	const stencilWriteMaskSize = WGPU_SIZE.u32;
	const stencilWriteMaskStart =
		(pointer + stencilWriteMaskOffset) / stencilWriteMaskSize;
	const stencilWriteMask = u32[Number(stencilWriteMaskStart)];
	//
	const depthBiasOffset = offset.depthBias;
	const depthBiasSize = WGPU_SIZE.s32;
	const depthBiasStart = (pointer + depthBiasOffset) / depthBiasSize;
	const depthBias = u32[Number(depthBiasStart)];
	//
	const depthBiasSlopeScaleOffset = offset.depthBiasSlopeScale;
	const depthBiasSlopeScaleSize = WGPU_SIZE.float;
	const depthBiasSlopeScaleStart =
		(pointer + depthBiasSlopeScaleOffset) / depthBiasSlopeScaleSize;
	const depthBiasSlopeScale = f32[Number(depthBiasSlopeScaleStart)];
	//
	const depthBiasClampOffset = offset.depthBiasClamp;
	const depthBiasClampSize = WGPU_SIZE.float;
	const depthBiasClampStart =
		(pointer + depthBiasClampOffset) / depthBiasClampSize;
	const depthBiasClamp = f32[Number(depthBiasClampStart)];

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

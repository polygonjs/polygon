import {
	cullModeIntToGPUCullMode,
	frontFaceIntToGPUFrontFace,
	indexFormatIntToGPUIndexFormat,
	topologyIntToGPUPrimitiveTopology,
} from "../utils/WebGPUMap";
import { WGPU_OFFSET, WGPU_SIZE } from "../utils/WebGPUOffset";

export function WGPUPrimitiveStateFromBuffer(
	pointer: bigint,
	u32: Uint32Array
): GPUPrimitiveState {
	const offset = WGPU_OFFSET.WGPUPrimitiveState;

	//
	const topologyOffset = offset.topology;
	const topologySize = WGPU_SIZE.u32;
	const topologyState = (pointer + topologyOffset) / topologySize;
	const topologyb = u32[Number(topologyState)];
	const topology = topologyIntToGPUPrimitiveTopology(topologyb);
	//
	const stripIndexFormatOffset = offset.stripIndexFormat;
	const stripIndexFormatSize = WGPU_SIZE.u32;
	const stripIndexFormatState =
		(pointer + stripIndexFormatOffset) / stripIndexFormatSize;
	const stripIndexFormatb = u32[Number(stripIndexFormatState)];
	const stripIndexFormat = indexFormatIntToGPUIndexFormat(stripIndexFormatb);
	//
	const frontFaceOffset = offset.frontFace;
	const frontFaceSize = WGPU_SIZE.u32;
	const frontFaceState = (pointer + frontFaceOffset) / frontFaceSize;
	const frontFaceb = u32[Number(frontFaceState)];
	const frontFace = frontFaceIntToGPUFrontFace(frontFaceb);
	//
	const cullModeOffset = offset.cullMode;
	const cullModeSize = WGPU_SIZE.u32;
	const cullModeState = (pointer + cullModeOffset) / cullModeSize;
	const cullModeb = u32[Number(cullModeState)];
	const cullMode = cullModeIntToGPUCullMode(cullModeb);

	//
	const primitiveState: GPUPrimitiveState = {
		topology,
		stripIndexFormat,
		frontFace,
		cullMode,
	};
	return primitiveState;
}

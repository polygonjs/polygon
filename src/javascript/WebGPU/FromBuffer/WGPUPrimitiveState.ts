import {
	cullModeIntToGPUCullMode,
	frontFaceIntToGPUFrontFace,
	indexFormatIntToGPUIndexFormat,
	topologyIntToGPUPrimitiveTopology,
} from "../utils/WebGPUMap";
import { WGPU_OFFSET } from "../utils/WebGPUOffset";
import { u32Create } from "../utils/WebGPUUtils";

export function WGPUPrimitiveStateFromBuffer(
	pointer: bigint
): GPUPrimitiveState {
	const buffer = window.ALLOCATED_MEMORY_CONTAINER.allocatedMemory!.buffer;
	const u32 = new Uint32Array(buffer);
	const _u32 = u32Create(u32, pointer);
	//
	const offset = WGPU_OFFSET.WGPUPrimitiveState;

	//
	const topologyb = _u32(offset.topology);
	const topology = topologyIntToGPUPrimitiveTopology(topologyb);
	//
	const stripIndexFormatb = _u32(offset.stripIndexFormat);
	const stripIndexFormat = indexFormatIntToGPUIndexFormat(stripIndexFormatb);
	//
	const frontFaceb = _u32(offset.frontFace);
	const frontFace = frontFaceIntToGPUFrontFace(frontFaceb);
	//
	const cullModeb = _u32(offset.cullMode);
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


import {
	cullModeIntToGPUCullMode,
	frontFaceIntToGPUFrontFace,
	indexFormatIntToGPUIndexFormat,
	topologyIntToGPUPrimitiveTopology,
} from "../utils/WebGPUMap";
import { _num } from "../utils/WebGPUUtils";
import { WGPUPrimitiveState } from "../utils/WGPUStructInfos";

export function WGPUPrimitiveStateFromBuffer(p: bigint): GPUPrimitiveState {
	const m = WGPUPrimitiveState.members;

	//
	const topologyb = _num(p, m.topology);
	const topology = topologyIntToGPUPrimitiveTopology(topologyb);
	//
	const stripIndexFormatb = _num(p, m.stripIndexFormat);
	const stripIndexFormat = indexFormatIntToGPUIndexFormat(stripIndexFormatb);
	//
	const frontFaceb = _num(p, m.frontFace);
	const frontFace = frontFaceIntToGPUFrontFace(frontFaceb);
	//
	const cullModeb = _num(p, m.cullMode);
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


import {
	compareFunctionIntToGPUCompareFunction,
	textureFormatIntToGPUTextureFormat,
} from "../utils/WebGPUMap";
import { _num } from "../../wasm/WasmUtils";
import { WGPUDepthStencilState } from "../utils/WGPUStructInfos";
import { WGPUStencilFaceStateFromBuffer } from "./WGPUStencilFaceState";

export function WGPUDepthStencilStateFromBuffer(
	p: bigint
): GPUDepthStencilState {
	const m = WGPUDepthStencilState.members;

	//
	const formatb = _num(p, m.format);
	const format = textureFormatIntToGPUTextureFormat(formatb);
	//
	const depthWriteEnabledb = _num(p, m.depthWriteEnabled);
	const depthWriteEnabled = Boolean(depthWriteEnabledb);
	//
	const depthCompareb = _num(p, m.depthCompare);
	const depthCompare = compareFunctionIntToGPUCompareFunction(depthCompareb);
	//

	const stencilFront = WGPUStencilFaceStateFromBuffer(
		p + m.stencilFront.offset
	);
	const stencilBack = WGPUStencilFaceStateFromBuffer(
		p + m.stencilBack.offset
	);
	//
	const stencilReadMask = _num(p, m.stencilReadMask);
	const stencilWriteMask = _num(p, m.stencilWriteMask);
	const depthBias = _num(p, m.depthBias);
	const depthBiasSlopeScale = _num(p, m.depthBiasSlopeScale);
	const depthBiasClamp = _num(p, m.depthBiasClamp);

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


import {
	compareFunctionIntToGPUCompareFunction,
	stencilOperationIntToGPUStencilOperation,
} from "../utils/WebGPUMap";
import { WGPU_OFFSET, WGPU_SIZE } from "../utils/WebGPUOffset";

export function WGPUStencilFaceStateFromBuffer(
	pointer: bigint,
	u32: Uint32Array
): GPUStencilFaceState {
	const offset = WGPU_OFFSET.WGPUStencilFaceState;
	//
	const compareOffset = offset.compare;
	const compareSize = WGPU_SIZE.u32;
	const compareStart = (pointer + compareOffset) / compareSize;
	const compareb = u32[Number(compareStart)];
	const compare = compareFunctionIntToGPUCompareFunction(compareb);
	//
	function stencilOp(pointerOffset: bigint): GPUStencilOperation {
		const size = WGPU_SIZE.u32;
		const start = (pointer + pointerOffset) / size;
		const b = u32[Number(start)];
		return stencilOperationIntToGPUStencilOperation(b);
	}
	//
	const failOp = stencilOp(offset.failOp);
	const depthFailOp = stencilOp(offset.depthFailOp);
	const passOp = stencilOp(offset.passOp);
	//
	const stencilFaceState: GPUStencilFaceState = {
		compare,
		failOp,
		depthFailOp,
		passOp,
	};
	return stencilFaceState;
}

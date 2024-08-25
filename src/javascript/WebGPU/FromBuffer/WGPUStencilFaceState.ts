import {
	compareFunctionIntToGPUCompareFunction,
	stencilOperationIntToGPUStencilOperation,
} from "../utils/WebGPUMap";
import { WGPU_OFFSET } from "../utils/WebGPUOffset";
import { u32Create } from "../utils/WebGPUUtils";

export function WGPUStencilFaceStateFromBuffer(
	pointer: bigint
): GPUStencilFaceState {
	const buffer = window.ALLOCATED_MEMORY_CONTAINER.allocatedMemory!.buffer;
	const u32 = new Uint32Array(buffer);
	const _u32 = u32Create(u32, pointer);
	//
	const offset = WGPU_OFFSET.WGPUStencilFaceState;
	//
	const compareb = _u32(offset.compare);
	const compare = compareFunctionIntToGPUCompareFunction(compareb);
	const failOp = stencilOperationIntToGPUStencilOperation(
		Number(_u32(offset.failOp))
	);
	const depthFailOp = stencilOperationIntToGPUStencilOperation(
		Number(_u32(offset.depthFailOp))
	);
	const passOp = stencilOperationIntToGPUStencilOperation(
		Number(_u32(offset.passOp))
	);
	//
	const stencilFaceState: GPUStencilFaceState = {
		compare,
		failOp,
		depthFailOp,
		passOp,
	};
	return stencilFaceState;
}


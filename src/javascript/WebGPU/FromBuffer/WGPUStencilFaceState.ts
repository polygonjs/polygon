import {
	compareFunctionIntToGPUCompareFunction,
	stencilOperationIntToGPUStencilOperation,
} from "../utils/WebGPUMap";
import { _num } from "../../wasm/WasmUtils";
import { WGPUStencilFaceState } from "../utils/WGPUStructInfos";

export function WGPUStencilFaceStateFromBuffer(p: bigint): GPUStencilFaceState {
	//
	const m = WGPUStencilFaceState.members;
	//
	const compareb = _num(p, m.compare);
	const compare = compareFunctionIntToGPUCompareFunction(compareb);
	const failOp = stencilOperationIntToGPUStencilOperation(_num(p, m.failOp));
	const depthFailOp = stencilOperationIntToGPUStencilOperation(
		_num(p, m.depthFailOp)
	);
	const passOp = stencilOperationIntToGPUStencilOperation(_num(p, m.passOp));
	//
	const stencilFaceState: GPUStencilFaceState = {
		compare,
		failOp,
		depthFailOp,
		passOp,
	};
	return stencilFaceState;
}


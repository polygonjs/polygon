import {
	blendFactorIntToGPUBlendFactor,
	blendOperationIntToGPUBlendOperation,
} from "../utils/WebGPUMap";
import { _num } from "../../wasm/WasmUtils";
import { WGPUBlendComponent } from "../utils/WGPUStructInfos";

export function WGPUBlendComponentFromBuffer(p: bigint): GPUBlendComponent {
	const m = WGPUBlendComponent.members;
	//
	const operationb = _num(p, m.operation);
	const operation: GPUBlendOperation =
		blendOperationIntToGPUBlendOperation(operationb);
	//
	const srcFactor = blendFactorIntToGPUBlendFactor(_num(p, m.srcFactor));
	const dstFactor = blendFactorIntToGPUBlendFactor(_num(p, m.dstFactor));
	//
	const blendComponent: GPUBlendComponent = {
		operation,
		srcFactor,
		dstFactor,
	};
	return blendComponent;
}


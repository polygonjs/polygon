import {
	blendFactorIntToGPUBlendFactor,
	blendOperationIntToGPUBlendOperation,
} from "../utils/WebGPUMap";
import { WGPU_OFFSET, WGPU_SIZE } from "../utils/WebGPUOffset";

export function WGPUBlendComponentFromBuffer(
	pointer: bigint,
	u32: Uint32Array
): GPUBlendComponent {
	const offset = WGPU_OFFSET.WGPUBlendComponent;
	//
	const operationOffset = offset.operation;
	const operationSize = WGPU_SIZE.u32;
	const operationStart = (pointer + operationOffset) / operationSize;
	const operationb = u32[Number(operationStart)];
	const operation: GPUBlendOperation =
		blendOperationIntToGPUBlendOperation(operationb);
	//
	function blendFactor(pointerOffset: bigint): GPUBlendFactor {
		const size = WGPU_SIZE.u32;
		const start = (pointer + pointerOffset) / size;
		const b = u32[Number(start)];
		return blendFactorIntToGPUBlendFactor(b);
	}
	const srcFactor = blendFactor(offset.srcFactor);
	const dstFactor = blendFactor(offset.dstFactor);
	//
	const blendComponent: GPUBlendComponent = {
		operation,
		srcFactor,
		dstFactor,
	};
	return blendComponent;
}

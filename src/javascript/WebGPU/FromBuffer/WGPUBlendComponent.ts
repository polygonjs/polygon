import {
	blendFactorIntToGPUBlendFactor,
	blendOperationIntToGPUBlendOperation,
} from "../utils/WebGPUMap";
import { WGPU_OFFSET } from "../utils/WebGPUOffset";
import { u32Create } from "../utils/WebGPUUtils";

export function WGPUBlendComponentFromBuffer(
	pointer: bigint
): GPUBlendComponent {
	const buffer = window.ALLOCATED_MEMORY_CONTAINER.allocatedMemory!.buffer;
	const u32 = new Uint32Array(buffer);
	const _u32 = u32Create(u32, pointer);
	//
	const offset = WGPU_OFFSET.WGPUBlendComponent;
	//
	const operationb = _u32(offset.operation); //u32[Number(operationStart)];
	const operation: GPUBlendOperation =
		blendOperationIntToGPUBlendOperation(operationb);
	//
	const srcFactor = blendFactorIntToGPUBlendFactor(
		Number(_u32(offset.srcFactor))
	);
	const dstFactor = blendFactorIntToGPUBlendFactor(
		Number(_u32(offset.dstFactor))
	);
	//
	const blendComponent: GPUBlendComponent = {
		operation,
		srcFactor,
		dstFactor,
	};
	return blendComponent;
}


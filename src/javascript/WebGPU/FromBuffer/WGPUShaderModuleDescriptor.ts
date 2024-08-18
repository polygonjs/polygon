import { WGPU_OFFSET, WGPU_SIZE } from "../utils/WebGPUOffset";
import { labelFromBuffer } from "../utils/WebGPUUtils";
import { WGPUShaderModuleWGSLDescriptorFromBuffer } from "./WGPUShaderModuleWGSLDescriptor";

export function WGPUShaderModuleDescriptorFromBuffer(
	pointer: bigint
): GPUShaderModuleDescriptor {
	const buffer = window.ALLOCATED_MEMORY_CONTAINER.allocatedMemory!.buffer;
	// const pointer = Number(pointerb);
	const offset = WGPU_OFFSET.WGPUShaderModuleDescriptor;
	// const u8 = new Uint8Array(buffer);
	// const u32 = new Uint32Array(buffer);
	const u64 = new BigUint64Array(buffer);
	//
	const label = labelFromBuffer(pointer, offset, u64);
	//
	const nextInChainPointerIndex =
		(pointer + offset.nextInChain) / WGPU_SIZE.u64;
	const nextInChainPointer = u64[Number(nextInChainPointerIndex)];
	const wgslDescriptor =
		WGPUShaderModuleWGSLDescriptorFromBuffer(nextInChainPointer);

	const descriptor: GPUShaderModuleDescriptor = {
		label,
		code: wgslDescriptor.code,
	};
	return descriptor;
}
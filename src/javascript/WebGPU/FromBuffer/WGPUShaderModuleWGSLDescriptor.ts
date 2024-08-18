import { WGPU_OFFSET } from "../utils/WebGPUOffset";
import { stringFromBuffer } from "../utils/WebGPUUtils";

interface Mock_GPUShaderModuleWGSLDescriptor {
	code: string;
}
export function WGPUShaderModuleWGSLDescriptorFromBuffer(
	pointer: bigint
): Mock_GPUShaderModuleWGSLDescriptor {
	const buffer = window.ALLOCATED_MEMORY_CONTAINER.allocatedMemory!.buffer;
	// const pointer = Number(pointerb);
	const offset = WGPU_OFFSET.WGPUShaderModuleWGSLDescriptor;
	// const u8 = new Uint8Array(buffer);
	// const u32 = new Uint32Array(buffer);
	const u64 = new BigUint64Array(buffer);

	const code = stringFromBuffer(pointer, offset.code, u64);
	if (!code) {
		throw new Error(
			"WGPUShaderModuleWGSLDescriptorFromBuffer:code is null"
		);
	}

	const descriptor: Mock_GPUShaderModuleWGSLDescriptor = {
		code,
	};
	return descriptor;
}
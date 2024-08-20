import { WGPU_OFFSET } from "../utils/WebGPUOffset";
import { labelFromBuffer } from "../utils/WebGPUUtils";

export function WGPUComputePassDescriptorFromBuffer(
	pointer: bigint
): GPUComputePassDescriptor {
	const buffer = window.ALLOCATED_MEMORY_CONTAINER.allocatedMemory!.buffer;
	const u64 = new BigUint64Array(buffer);
	//
	const offset = WGPU_OFFSET.WGPUComputePipelineDescriptor;
	//
	const label = labelFromBuffer(pointer, offset, u64);
	//

	const desc: GPUComputePassDescriptor = {
		label,
	};
	return desc;
}


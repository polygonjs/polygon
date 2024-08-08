import { WGPU_OFFSET } from "../utils/WebGPUOffset";
import { labelFromBuffer } from "../utils/WebGPUUtils";

export function WGPUCommandBufferDescriptorFromBuffer(
	pointer: bigint
): GPUCommandBufferDescriptor {
	const buffer = window.ALLOCATED_MEMORY_CONTAINER.allocatedMemory!.buffer;
	const u64 = new BigUint64Array(buffer);
	const offset = WGPU_OFFSET.WGPUCommandBufferDescriptor;

	const label = labelFromBuffer(pointer, offset, u64);

	const desc: GPUCommandBufferDescriptor = { label };
	return desc;
}

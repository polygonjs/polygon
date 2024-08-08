import { WGPU_OFFSET, WGPU_SIZE } from "../utils/WebGPUOffset";
import { labelFromBuffer } from "../utils/WebGPUUtils";

export function WGPUBufferDescriptorFromBuffer(
	pointer: bigint
): GPUBufferDescriptor {
	const buffer = window.ALLOCATED_MEMORY_CONTAINER.allocatedMemory!.buffer;
	// const pointer = Number(pointerb);
	const offset = WGPU_OFFSET.WGPUBufferDescriptor;
	// const u8 = new Uint8Array(buffer);
	const u32 = new Uint32Array(buffer);
	const u64 = new BigUint64Array(buffer);
	//
	// const labelOffset = offset.label;
	// const labelSize = WGPU_SIZE.u64;
	// const labelStart = (pointer + labelOffset) / labelSize;
	// const labelPointer = u64[Number(labelStart)];
	const label = labelFromBuffer(pointer, offset, u64); //jsStringFromJaiStringWithoutLength(labelPointer);
	//
	const usageOffset = offset.usage;
	const usageSize = WGPU_SIZE.u32;
	const usageStart = (pointer + usageOffset) / usageSize;
	const usage = u32[Number(usageStart)];
	//
	const sizeOffset = offset.size;
	const sizeSize = WGPU_SIZE.u64;
	const sizeStart = (pointer + sizeOffset) / sizeSize;
	const size = Number(u64[Number(sizeStart)]);
	//
	const mappedAtCreationOffset = offset.mappedAtCreation;
	const mappedAtCreationSize = WGPU_SIZE.u32;
	const mappedAtCreationStart =
		(pointer + mappedAtCreationOffset) / mappedAtCreationSize;
	const mappedAtCreation = Boolean(u32[Number(mappedAtCreationStart)]);
	//
	const desc: GPUBufferDescriptor = {
		label,
		usage,
		size,
		mappedAtCreation,
	};
	return desc;
}

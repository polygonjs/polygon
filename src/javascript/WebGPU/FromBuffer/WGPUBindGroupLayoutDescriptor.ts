import { WGPU_OFFSET, WGPU_SIZE } from "../utils/WebGPUOffset";
import {
	createWGPUItemsByPointer,
	labelFromBuffer,
	u64Create,
} from "../utils/WebGPUUtils";
import { WGPUBindGroupLayoutEntryFromBuffer } from "./WGPUBindGroupLayoutEntry";

export function WGPUBindGroupLayoutDescriptorFromBuffer(
	pointer: bigint
): GPUBindGroupLayoutDescriptor {
	const buffer = window.ALLOCATED_MEMORY_CONTAINER.allocatedMemory!.buffer;
	const u64 = new BigUint64Array(buffer);
	const _u64 = u64Create(u64, pointer);
	//
	const offset = WGPU_OFFSET.WGPUBindGroupLayoutDescriptor;
	//
	const label = labelFromBuffer(pointer, offset, u64);
	const entriesCount = _u64(offset.entryCount);
	const entries = createWGPUItemsByPointer<GPUBindGroupLayoutEntry>({
		u64,
		pointer,
		arrayOffset: offset.entries,
		itemsCount: entriesCount,
		itemSize: WGPU_SIZE.WGPUBindGroupLayoutEntry,
		callback: (itemPointer) =>
			WGPUBindGroupLayoutEntryFromBuffer(itemPointer),
	});

	const desc: GPUBindGroupLayoutDescriptor = {
		label,
		entries,
	};
	return desc;
}


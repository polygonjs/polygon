import { heapGet } from "../../WasmHeap";
import { WGPU_OFFSET, WGPU_SIZE } from "../utils/WebGPUOffset";
import {
	createWGPUItemsByPointer,
	labelFromBuffer,
	u64Create,
} from "../utils/WebGPUUtils";
import { WGPUBindGroupEntryFromBuffer } from "./WGPUBindGroupEntry";

export function WGPUBindGroupDescriptorFromBuffer(
	pointer: bigint
): GPUBindGroupDescriptor {
	const buffer = window.ALLOCATED_MEMORY_CONTAINER.allocatedMemory!.buffer;
	const u64 = new BigUint64Array(buffer);
	const _u64 = u64Create(u64, pointer);
	//
	const offset = WGPU_OFFSET.WGPUBindGroupDescriptor;

	//
	const label = labelFromBuffer(pointer, offset, u64);
	//
	const layoutPointer = _u64(offset.layout);
	const layout = heapGet<GPUBindGroupLayout>(layoutPointer);
	if (!layout) {
		throw new Error("layout is null");
	}
	//
	const entryCount = _u64(offset.entryCount);
	//
	const entries: GPUBindGroupEntry[] = createWGPUItemsByPointer({
		u64,
		pointer,
		arrayOffset: offset.entries,
		itemsCount: entryCount,
		itemSize: WGPU_SIZE.WGPUBindGroupEntry,
		callback: (itemPointer) => WGPUBindGroupEntryFromBuffer(itemPointer),
	});

	const desc: GPUBindGroupDescriptor = {
		label,
		layout,
		entries,
	};
	return desc;
}


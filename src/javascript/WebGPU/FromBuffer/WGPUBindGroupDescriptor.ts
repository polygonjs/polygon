import { heapGet } from "../../WasmHeap";
import { WGPU_OFFSET, WGPU_SIZE } from "../utils/WebGPUOffset";
import {
	createWGPUItemsByPointer,
	labelFromBuffer,
	numberFromBuffer,
} from "../utils/WebGPUUtils";
import { WGPUBindGroupEntryFromBuffer } from "./WGPUBindGroupEntry";

export function WGPUBindGroupDescriptorFromBuffer(
	pointer: bigint
): GPUBindGroupDescriptor {
	const buffer = window.ALLOCATED_MEMORY_CONTAINER.allocatedMemory!.buffer;
	const u32 = new Uint32Array(buffer);
	const u64 = new BigUint64Array(buffer);
	const offset = WGPU_OFFSET.WGPUBindGroupDescriptor;

	//
	const label = labelFromBuffer(pointer, offset, u64);
	//
	const layoutOffset = offset.layout;
	const layoutSize = WGPU_SIZE.u64;
	const layoutStart = (pointer + layoutOffset) / layoutSize;
	const layoutPointer = u64[Number(layoutStart)];
	const layout = heapGet<GPUBindGroupLayout>(layoutPointer);
	if (!layout) {
		throw new Error("layout is null");
	}
	//
	const entryCount = numberFromBuffer(u64, pointer, offset.entryCount);
	//
	const entries: GPUBindGroupEntry[] = createWGPUItemsByPointer({
		u64,
		pointer,
		arrayOffset: offset.entries,
		itemsCount: entryCount,
		itemSize: WGPU_SIZE.WGPUBindGroupEntry,
		callback: (itemPointer) =>
			WGPUBindGroupEntryFromBuffer(itemPointer, u32, u64),
	});
	// const entryArrayPointerIndex = (pointer + offset.entries) / WGPU_SIZE.u64;
	// const entryArrayPointer = u64[Number(entryArrayPointerIndex)];
	// for (let i = 0; i < entryCount; i++) {
	// 	const entryPointer =
	// 		entryArrayPointer + BigInt(i) * WGPU_SIZE.WGPUBindGroupEntry;
	// 	const entry = WGPUBindGroupEntryFromBuffer(entryPointer, u32, u64);
	// 	entries.push(entry);
	// }

	const desc: GPUBindGroupDescriptor = {
		label,
		layout,
		entries,
	};
	return desc;
}

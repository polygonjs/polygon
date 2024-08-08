import { WGPU_OFFSET, WGPU_SIZE } from "../utils/WebGPUOffset";
import {
	createWGPUItemsByPointer,
	labelFromBuffer,
	numberFromBuffer,
} from "../utils/WebGPUUtils";
import { WGPUBindGroupLayoutEntryFromBuffer } from "./WGPUBindGroupLayoutEntry";

export function WGPUBindGroupLayoutDescriptorFromBuffer(
	pointer: bigint
): GPUBindGroupLayoutDescriptor {
	const buffer = window.ALLOCATED_MEMORY_CONTAINER.allocatedMemory!.buffer;
	const u64 = new BigUint64Array(buffer);
	// const pointer = Number(pointerb);
	const offset = WGPU_OFFSET.WGPUBindGroupLayoutDescriptor;
	//
	const label = labelFromBuffer(pointer, offset, u64);
	const entriesCount = numberFromBuffer(u64, pointer, offset.entryCount);
	const entries = createWGPUItemsByPointer<GPUBindGroupLayoutEntry>({
		u64,
		pointer,
		arrayOffset: offset.entries,
		itemsCount: entriesCount,
		itemSize: WGPU_SIZE.WGPUBindGroupLayoutEntry,
		callback: (itemPointer) =>
			WGPUBindGroupLayoutEntryFromBuffer(itemPointer),
	});
	//
	// const bindingOffset = offset.binding;
	// const bindingSize = WGPU_SIZE.u32;
	// const bindingStart = (pointer + bindingOffset) / bindingSize;
	// const binding = u32[Number(bindingStart)];

	// if (entriesCount > 1) {
	// 	console.error(
	// 		`entriesCount>1 not supported yet ${Number(entriesCount)}`
	// 	);
	// }
	// // console.log({
	// // 	u32,
	// // 	pointer,
	// // 	bindingOffset,
	// // 	bindingSize,
	// // 	bindingStart,
	// // 	binding,
	// // });
	// //
	// const visibilityOffset = offset.visibility;
	// const visibilitySize = WGPU_SIZE.u32;
	// const visibilityStart = (pointer + visibilityOffset) / visibilitySize;
	// const visibility = u32[Number(visibilityStart)];
	// //
	// // const bufferOffset = offset.buffer;
	// // const bufferSize = offset.sampler - bufferOffset;
	// const bufferTypeOffset =
	// 	offset.buffer + WGPU_OFFSET.WGPUBufferBindingLayout.type;
	// const bufferSize = WGPU_SIZE.u32;
	// const bufferStart = (pointer + bufferTypeOffset) / bufferSize;
	// const bufferTypeInt = u32[Number(bufferStart)];
	// const bufferType = bufferTypeIntToGPUBufferBindingType(bufferTypeInt);
	// //
	// // console.log("WGPUBindGroupLayoutFromBuffer", {
	// // 	binding,
	// // 	visibility,
	// // 	bufferType,
	// // });
	// const entries: GPUBindGroupLayoutEntry[] = [
	// 	{
	// 		binding,
	// 		visibility,
	// 		buffer: { type: bufferType },
	// 	},
	// ];
	const desc: GPUBindGroupLayoutDescriptor = {
		label,
		entries,
	};
	return desc;
	// const bindGroupLayout = device.createBindGroupLayout({ entries });
	// console.log(entries, bindGroupLayout);
	// return bindGroupLayout;
	// const heapIndex= heapAdd(bindGroupLayout);
	// console.log(entries,bindGroupLayout,heapIndex)
	// heapIndex
}

import { heapGet } from "../../WasmHeap";
import { WGPU_OFFSET } from "../utils/WebGPUOffset";
import {
	createWGPUItemsByHeapIndex,
	labelFromBuffer,
	numberFromBuffer,
} from "../utils/WebGPUUtils";

export function WGPUPipelineLayoutDescriptorFromBuffer(
	pointer: bigint
): GPUPipelineLayoutDescriptor {
	const buffer = window.ALLOCATED_MEMORY_CONTAINER.allocatedMemory!.buffer;
	// const pointer = Number(pointerb);
	const offset = WGPU_OFFSET.WGPUPipelineLayoutDescriptor;
	// const u8 = new Uint8Array(buffer);
	const u64 = new BigUint64Array(buffer);
	//
	// const labelOffset = offset.label;
	// const labelSize = SIZE.u64;
	// const labelStart = (pointer + labelOffset) / labelSize;
	// const labelPointer = u64[Number(labelStart)];
	// const label = jsStringFromJaiStringWithoutLength(BigInt(labelPointer));
	const label = labelFromBuffer(pointer, offset, u64);
	//
	const groupLayoutCount = numberFromBuffer(
		u64,
		pointer,
		offset.bindGroupLayoutCount
	);
	//
	const bindGroupLayouts: GPUBindGroupLayout[] = createWGPUItemsByHeapIndex({
		u64,
		pointer,
		arrayOffset: offset.bindGroupLayouts,
		itemsCount: groupLayoutCount,
		callback: (itemHeapIndex) => {
			const bindGroupLayout = heapGet<GPUBindGroupLayout>(itemHeapIndex);
			if (!bindGroupLayout) {
				console.error("bindGroupLayout is null");
				throw new Error("bindGroupLayout is null");
			}
			return bindGroupLayout;
		},
	});
	// for (let i = 0; i < groupLayoutCount; i++) {
	// 	// const groupLayoutPointer =
	// 	// 	(pointer + offset.bindGroupLayouts) / WGPU_SIZE.u64;
	// 	// const groupLayoutPointerPointer = u64[Number(groupLayoutPointer)];
	// 	// // we only add i, and not size_of(a-struct)*i
	// 	// // since WGPUBindGroupLayout is just a pointer, therefore NewArray(X, WGPUBindGroupLayout)
	// 	// // is an array of pointers
	// 	// const groupLayoutHeapIndex =
	// 	// 	u64[Number(groupLayoutPointerPointer / WGPU_SIZE.u64) + i];
	// 	const groupLayoutHeapIndex = arrayItemHeapIndex(
	// 		u64,
	// 		pointer,
	// 		offset.bindGroupLayouts,
	// 		i
	// 	);
	// 	const bindGroupLayout =
	// 		heapGet<GPUBindGroupLayout>(groupLayoutHeapIndex);
	// 	if (!bindGroupLayout) {
	// 		console.error("bindGroupLayout is null");
	// 		throw new Error("bindGroupLayout is null");
	// 	}
	// 	bindGroupLayouts.push(bindGroupLayout);
	// }
	//
	const pipelineDescriptor: GPUPipelineLayoutDescriptor = {
		label,
		bindGroupLayouts,
	};
	// const pipelineLayout = device.createPipelineLayout(pipelineDescriptor);
	for (let i = 0; i < groupLayoutCount; i++) {
		// heapDeleteByItem(bindGroupLayouts[i]);
	}
	// TODO: run heapDelete for each bindGroupLayout ?
	return pipelineDescriptor;
}

